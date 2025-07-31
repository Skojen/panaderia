# === Proyecto y región ===
project_id              = "tu-proyecto-id"
region                  = "us-central1"

# === Cloud SQL ===
db_instance_name        = "panaderia-db"
db_name                 = "panaderia"
db_user                 = "postgres"
db_password             = "cambia_esto_por_seguridad"

# === Cloud Run ===
backend_service_name    = "panaderia-backend"
backend_image           = "gcr.io/tu-proyecto-id/panaderia-backend"
backend_port            = 3000

frontend_service_name   = "panaderia-frontend"
frontend_image          = "gcr.io/tu-proyecto-id/panaderia-frontend"
frontend_port           = 80

# === Despliegue ===
deployer_email          = "tucorreo@tudominio.com"
create_service_account  = true