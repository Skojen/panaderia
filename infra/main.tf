provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_project_service" "run" {
  service = "run.googleapis.com"
}

resource "google_project_service" "cloudbuild" {
  service = "cloudbuild.googleapis.com"
}

resource "google_project_service" "sqladmin" {
  service = "sqladmin.googleapis.com"
}

module "cloudsql" {
  source            = "./modules/cloudsql"
  project_id        = var.project_id
  region            = var.region
  db_instance_name  = var.db_instance_name
  db_name           = var.db_name
  db_user           = var.db_user
  db_password       = var.db_password
}

module "service_account" {
  source                = "./modules/service_account"
  project_id            = var.project_id
  deployer_email        = var.deployer_email
  create_service_account = var.create_service_account
}

module "cloudrun" {
  source                  = "./modules/cloudrun"
  project_id              = var.project_id
  region                  = var.region
  service_name            = var.service_name
  container_image         = var.container_image
  db_name                 = var.db_name
  db_user                 = var.db_user
  db_password             = var.db_password
  db_instance_connection  = module.cloudsql.connection_name
  use_service_account     = var.create_service_account
  service_account_email   = module.service_account.service_account_email
}