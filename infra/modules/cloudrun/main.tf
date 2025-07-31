resource "google_cloud_run_service" "backend" {
  name     = var.service_name
  location = var.region

  template {
    spec {
      service_account_name = var.use_service_account ? var.service_account_email : null
      containers {
        image = var.container_image

        env {
          name  = "NODE_ENV"
          value = "production"
        }
        env {
          name  = "DB_ENGINE"
          value = "postgres"
        }
        env {
          name  = "DB_NAME"
          value = var.db_name
        }
        env {
          name  = "DB_USER"
          value = var.db_user
        }
        env {
          name  = "DB_PASSWORD"
          value = var.db_password
        }
        env {
          name  = "DB_HOST"
          value = "/cloudsql/${var.db_instance_connection}"
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  autogenerate_revision_name = true
}