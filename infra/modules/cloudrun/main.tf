resource "google_cloud_run_service" "default" {
  name     = var.service_name
  location = var.region

  template {
    metadata {
      annotations = {
        "run.googleapis.com/cloudsql-instances" = var.db_instance_connection
      }
    }

    spec {
      service_account_name = var.use_service_account ? var.service_account_email : null

      containers {
        image = var.container_image
        
        # Puerto del container
        ports  {
          container_port = var.container_port
        }

        # Siempre presentes
        env {
          name  = "NODE_ENV"
          value = "production"
        }

        # Solo si se requiere conectarse al api del backend
        dynamic "env" {
          for_each = var.api_url != "" ? [1] : []
          content {
            name  = "API_URL"
            value = var.api_url
          }
        }

        # Solo si se requiere base de datos
        dynamic "env" {
          for_each = var.db_name != "" ? [1] : []
          content {
            name  = "DB_ENGINE"
            value = "postgres"
          }
        }

        dynamic "env" {
          for_each = var.db_name != "" ? [1] : []
          content {
            name  = "DB_NAME"
            value = var.db_name
          }
        }

        dynamic "env" {
          for_each = var.db_user != "" ? [1] : []
          content {
            name  = "DB_USER"
            value = var.db_user
          }
        }

        dynamic "env" {
          for_each = var.db_password != "" ? [1] : []
          content {
            name  = "DB_PASSWORD"
            value = var.db_password
          }
        }

        dynamic "env" {
          for_each = var.db_instance_connection != "" ? [1] : []
          content {
            name  = "DB_HOST"
            value = "/cloudsql/${var.db_instance_connection}"
          }
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

resource "google_cloud_run_service_iam_member" "public_invoker" {
  count    = var.allow_unauthenticated ? 1 : 0
  location = var.region
  service  = google_cloud_run_service.default.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}