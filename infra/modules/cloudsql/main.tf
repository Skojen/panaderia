resource "google_sql_database_instance" "default" {
  name             = var.db_instance_name
  database_version = "POSTGRES_15"
  region           = var.region

  settings {
    tier = "db-f1-micro"

    # Agregado para evitar errores comunes
    ip_configuration {
      ipv4_enabled    = true
    }

    # Opcional: habilitar conexión por socket Cloud Run (recomendado)
    database_flags {
      name  = "cloudsql.iam_authentication"
      value = "off"
    }
  }

  deletion_protection = false
  root_password       = var.db_password
}

resource "google_sql_database" "default" {
  name     = var.db_name
  instance = google_sql_database_instance.default.name
}

resource "google_sql_user" "default" {
  name     = var.db_user
  instance = google_sql_database_instance.default.name
  password = var.db_password
}
