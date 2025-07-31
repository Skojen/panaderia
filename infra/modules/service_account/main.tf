resource "google_service_account" "this" {
  count        = var.create ? 1 : 0
  account_id   = var.account_id
  display_name = var.display_name
  project      = var.project_id
}

resource "google_service_account_iam_member" "impersonation" {
  for_each = var.create ? toset(var.impersonate_members) : toset([])

  service_account_id = google_service_account.this[0].name
  role               = "roles/iam.serviceAccountUser"
  member             = each.value
}
