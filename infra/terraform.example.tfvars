# === Proyecto y región ===
project_id      = "tu-proyecto-id"
region          = "us-central1"

# === Cloud SQL ===
db_instance_name = "panaderia-db"
db_name          = "panaderia"
db_user          = "postgres"
db_password      = "cambia_esto_por_seguridad"

# === Cloud Run ===
service_name     = "panaderia-backend"
container_image  = "gcr.io/tu-proyecto-id/panaderia-backend"

# === Despliegue ===
deployer_email   = "tucorreo@tudominio.com"
create_service_account = true