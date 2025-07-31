# Panadería — Sistema de Gestión

Este repositorio contiene una arquitectura desacoplada para una aplicación de pedidos de panadería, compuesta por:

- **Frontend** en React (carpeta `frontend/`)
- **Backend** en Node.js (Express) (carpeta `backend/`)
- **Base de datos PostgreSQL**
- **Infraestructura como código** con Terraform (carpeta `infra/`)
- **Entorno de desarrollo completo** con Dev Container (`.devcontainer/`)

---

## 🧱 Requisitos

- Docker + Docker Compose
- VSCode con la extensión "Dev Containers"
- Node.js y npm (solo si deseas trabajar sin Dev Container en frontend)
- [Gcloud CLI](https://cloud.google.com/sdk/docs/install)
- [Terraform CLI](https://developer.hashicorp.com/terraform/install)
- PostgreSQL client (`psql`) y `cloud-sql-proxy`

Instalación recomendada de herramientas adicionales:

```bash
# PostgreSQL client (Linux Debian/Ubuntu)
sudo apt update && sudo apt install postgresql-client -y

# Cloud SQL Proxy (versión v2)
wget https://storage.googleapis.com/cloud-sql-connectors/cloud-sql-proxy/v2.10.1/cloud-sql-proxy.linux.amd64 -O ../bin/cloud-sql-proxy
chmod +x ../bin/cloud-sql-proxy
```

> Se asume que usas un entorno basado en Linux o Cloud Shell. Ajusta rutas si trabajas desde otro entorno.

---

## ⚙️ Uso con Dev Container (recomendado)

1. Abre el proyecto con VSCode:

   ```bash
   code .
   ```

2. Selecciona `Reopen in Container` al ser solicitado (o desde la Command Palette).

Esto levantará automáticamente:

- PostgreSQL (puerto `5434`)
- Backend en Node (puerto `3010`)
- Frontend compilado (puerto `8090`)
- Workspace montado completo (`/workspace`)

Al cerrar VSCode, los contenedores se eliminan automáticamente gracias a:

```json
"shutdownAction": "stopCompose"
```

---

## 🚀 Uso local del frontend sin Dev Container

La carpeta `frontend/` contiene un `Makefile` con operaciones comunes para desarrollo:

```bash
cd frontend

make start         # Inicia React en modo desarrollo (localhost:3000)
make build         # Compila la app
make lint          # Corre eslint
make test          # Corre tests (si están definidos)
make open          # Abre en el navegador
```

Requiere tener `npm` instalado. La API backend debe estar corriendo en `localhost:3010`.

---

## 🛠️ Uso del Makefile (infraestructura)

Dentro de la carpeta `infra/`, se encuentra un `Makefile` que permite:

```bash
make init ENV=dev        # Ejecuta 'terraform init' con upgrade
make plan ENV=dev        # Prepara el plan de ejecución
make apply ENV=dev       # Aplica la infraestructura
make destroy ENV=dev     # Elimina los recursos creados
```

Para producción, reemplaza `dev` por `prod`.

---

## 📦 Archivos de variables (`terraform.{env}.tfvars`)

Cada entorno (`dev` o `prod`) debe tener su archivo de variables. Ejemplo de `terraform.dev.tfvars`:

```hcl
project_id         = "panaderia-serverless"
region             = "us-central1"
backend_image      = "gcr.io/panaderia-serverless/panaderia-backend"
frontend_image     = "gcr.io/panaderia-serverless/panaderia-frontend"
db_name            = "panaderia"
db_user            = "postgres"
db_password        = "tu_password_segura"
db_tier            = "db-f1-micro"
db_instance_name   = "panaderia-db"
```

Asegúrate de configurar estos valores antes de aplicar Terraform.

---

## ☁️ Infraestructura con Terraform (`infra/`)

La carpeta `infra/` contiene los módulos necesarios para desplegar la infraestructura en Google Cloud Platform:

- Cloud Run para backend y frontend
- Cloud SQL para PostgreSQL
- Cuentas de servicio personalizadas
- Inyección de variables `REACT_APP_API_URL` en tiempo de build
- Ejecución automática de `init.sql` usando `cloud-sql-proxy` + `psql`

### 🔧 Preparación inicial

```bash
cd infra
make init ENV={env}
```

### 🌐 Aplicación por entorno

```bash
make plan ENV=dev
make apply ENV=dev
```

Para producción:

```bash
make plan ENV=prod
make apply ENV=prod
```

> Asegúrate de tener los archivos `terraform.dev.tfvars` y `terraform.prod.tfvars` con tus valores personalizados.

### 🧪 Carga de `init.sql` a PostgreSQL

Durante `make apply ENV={env}`, el archivo `backend/db/init.sql` se ejecuta automáticamente utilizando `cloud-sql-proxy` si detecta cambios

---

## 🔁 CI/CD automatizado (opcional)

Si deseas integrar un pipeline CI/CD (GitHub Actions, GitLab CI, Cloud Build), se recomienda:

- Construir el frontend con la variable `REACT_APP_API_URL` inyectada:

```bash
docker build  --build-arg REACT_APP_API_URL=https://panaderia-backend-xxx.a.run.app   -t gcr.io/YOUR_PROJECT_ID/panaderia-frontend .
```

- Subir la imagen al Container Registry:

```bash
docker push gcr.io/YOUR_PROJECT_ID/panaderia-frontend
```

- Ejecutar `terraform apply` desde el CI con las credenciales de GCP configuradas:

```bash
terraform init -upgrade
terraform apply -var-file=terraform.prod.tfvars -auto-approve
```

---

## 📁 Estructura de carpetas

```
panaderia/
├── .devcontainer/       # Dev Container config (Dockerfile, docker-compose)
├── backend/             # API Express + conexión PostgreSQL
│   └── db/init.sql      # Script SQL para inicializar tablas y datos
├── frontend/            # React app + Makefile
├── infra/               # Terraform IaC + Makefile
│   └── terraform.dev.tfvars  # Variables de entorno dev
├── bin/                 # Herramientas auxiliares (ej: cloud-sql-proxy)
└── README.md
```

---

## 👨‍💻 Autor / Contacto

Este sistema es parte de un entorno moderno de desarrollo desacoplado, con foco en buenas prácticas, portabilidad y automatización.

# 📦 Despliegue paso a paso con Makefile

Este proyecto incluye un `Makefile` dentro de la carpeta `infra/` que automatiza todo el flujo de despliegue, desde la construcción de imágenes Docker hasta la aplicación de infraestructura con Terraform.

A continuación, se detalla el procedimiento **completo** para realizar un despliegue:

---

## 🔧 Paso 1: Configurar variables del entorno

Primero asegúrate de tener el archivo de variables `terraform.dev.tfvars` o `terraform.prod.tfvars` creado.

Si no existe, el `Makefile` lo generará automáticamente desde `terraform.example.tfvars`:

```bash
make check-tfvars ENV=dev
```

Esto creará el archivo base `terraform.dev.tfvars`.

Edita ese archivo y asegúrate de definir las siguientes variables clave:

```hcl
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
```

---

## 🛠️ Paso 2: Autenticación con GCP

Antes de ejecutar cualquier acción sobre Google Cloud, debes autenticarte:

```bash
make login
```

Esto ejecuta `gcloud auth application-default login` y almacena las credenciales.

---

## 🏗️ Paso 3: Construcción de imágenes Docker

Asegúrate de estar en la carpeta `infra/` y ejecuta:

```bash
make build-backend ENV=dev
make build-frontend ENV=dev
```

Esto construirá las imágenes para backend y frontend utilizando los valores de `project_id` extraídos desde tu archivo `terraform.dev.tfvars`.

---

## ☁️ Paso 4: Subida de imágenes a Google Container Registry

Una vez construidas, sube las imágenes a GCR:

```bash
make push-backend ENV=dev
make push-frontend ENV=dev
```

Esto te permitirá referenciar las imágenes desde Terraform.

---

## 🧪 Paso 5: Inicializar y validar infraestructura

Inicia y valida tu configuración Terraform:

```bash
make init ENV=dev
make validate ENV=dev
make fmt ENV=dev
make lint ENV=dev    # Atajo para formato + validación
```

---

## 📋 Paso 6: Planificar la infraestructura

Verifica el plan de ejecución:

```bash
make plan ENV=dev
```

Esto mostrará qué recursos serán creados, modificados o destruidos.

---

## 🚀 Paso 7: Aplicar la infraestructura

Aplica los cambios definidos en tu plan:

```bash
make apply ENV=dev
```

Este paso también ejecutará automáticamente el `init.sql` en la instancia PostgreSQL usando `cloud-sql-proxy`.

---

## 🔁 Paso alternativo: Despliegue completo automatizado

Si deseas realizar los pasos anteriores en una sola línea:

```bash
make deploy ENV=dev
```

Este comando ejecuta en orden: `build → push → apply`.

---

## 🧹 Limpieza

Para destruir todos los recursos creados:

```bash
make destroy ENV=dev
```

Y para limpiar archivos locales generados por Terraform:

```bash
make clean
```

## 👨‍💻 Autor / Contacto

Este sistema es parte de un entorno moderno de desarrollo desacoplado, con foco en buenas prácticas, portabilidad y automatización.