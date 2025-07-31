resource "google_service_account" "backend" {
  count        = var.create_service_account ? 1 : 0
  account_id   = "panaderia-sa"
  display_name = "Panadería Backend Service Account"
}

resource "google_project_iam_member" "act_as" {
  count   = var.create_service_account ? 1 : 0
  project = var.project_id
  role    = "roles/iam.serviceAccountUser"
  member  = "user:${var.deployer_email}"
}