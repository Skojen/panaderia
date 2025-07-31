resource "null_resource" "init_postgres" {
  provisioner "local-exec" {
    command = <<EOT
      echo "Ejecutando init.sql desde ../backend/db/init.sql en Cloud SQL..." 

      cloud-sql-proxy ${module.cloudsql.connection_name} &
      PROXY_PID=$!
      sleep 5

      PGPASSWORD='${var.db_password}' psql \
        -h 127.0.0.1 \
        -U ${var.db_user} \
        -d ${var.db_name} \
        -f ../backend/db/init.sql

      kill $PROXY_PID || true
    EOT
    interpreter = ["/bin/bash", "-c"]
  }

  triggers = {
    sql_hash = filesha256("../backend/db/init.sql")
  }

  depends_on = [
    module.cloudsql,
    google_project_iam_member.backend_sql_client
  ]
}