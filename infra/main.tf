provider "google" {
  project = var.project_id
  region  = var.region
}

# Habilitar servicios necesarios
resource "google_project_service" "run" {
  service = "run.googleapis.com"
}

resource "google_project_service" "cloudbuild" {
  service = "cloudbuild.googleapis.com"
}

resource "google_project_service" "sqladmin" {
  service = "sqladmin.googleapis.com"
}

# -----------------------------
# Cloud SQL (PostgreSQL)
# -----------------------------
module "cloudsql" {
  source           = "./modules/cloudsql"
  project_id       = var.project_id
  region           = var.region
  db_instance_name = var.db_instance_name
  db_name          = var.db_name
  db_user          = var.db_user
  db_password      = var.db_password
}

# -----------------------------
# Service Account (Backend)
# -----------------------------
module "service_account_backend" {
  source              = "./modules/service_account"
  project_id          = var.project_id
  account_id          = "panaderia-backend-sa"
  display_name        = "Panadería Backend Service Account"
  create              = var.create_service_account
  impersonate_members = ["user:${var.deployer_email}"]
}

resource "google_project_iam_member" "backend_sql_client" {
  project = var.project_id
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${module.service_account_backend.email}"
}

# -----------------------------
# Cloud Run (Backend)
# -----------------------------
module "cloudrun_backend" {
  source                 = "./modules/cloudrun"
  project_id             = var.project_id
  region                 = var.region
  service_name           = var.backend_service_name
  container_image        = var.backend_image
  container_port         = var.backend_port
  db_name                = var.db_name
  db_user                = var.db_user
  db_password            = var.db_password
  db_instance_connection = module.cloudsql.connection_name
  use_service_account    = var.create_service_account
  service_account_email  = module.service_account_backend.email
  allow_unauthenticated  = true
}

# -----------------------------
# Service Account (Frontend)
# -----------------------------
module "service_account_frontend" {
  source              = "./modules/service_account"
  project_id          = var.project_id
  account_id          = "panaderia-frontend-sa"
  display_name        = "Panadería Frontend Service Account"
  create              = var.create_service_account
  impersonate_members = ["user:${var.deployer_email}"]
}

# -----------------------------
# Cloud Run (Frontend)
# -----------------------------
module "cloudrun_frontend" {
  source                 = "./modules/cloudrun"
  project_id             = var.project_id
  region                 = var.region
  service_name           = var.frontend_service_name
  container_image        = var.frontend_image
  container_port         = var.frontend_port
  db_name                = ""
  db_user                = ""
  db_password            = ""
  db_instance_connection = ""
  use_service_account    = var.create_service_account
  service_account_email  = module.service_account_frontend.email
  allow_unauthenticated  = true
  api_url                = module.cloudrun_backend.url
}