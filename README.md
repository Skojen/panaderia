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
- Gcloud (para `infra/`)
- Terraform CLI (para `infra/`)

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

## ☁️ Infraestructura con Terraform (`infra/`)

La carpeta `infra/` contiene los módulos necesarios para desplegar la infraestructura en GCP o similar, incluyendo:

- Cloud Run para el backend y frontend
- Cloud SQL para PostgreSQL
- Variables configurables vía `terraform.tfvars`
- Uso de `Makefile` para aplicar o destruir recursos

Ejemplo:

```bash
cd infra
make init
make plan ENV=dev
make apply ENV=dev
```

> Se requiere configurar las credenciales de GCP y definir los secretos en `terraform.{env}.tfvars`

---

## 📁 Estructura de carpetas

```
panaderia/
├── .devcontainer/       # Dev Container config (Dockerfile, docker-compose)
├── backend/             # API Express + conexión PostgreSQL
├── frontend/            # React app + Makefile
├── infra/               # Terraform IaC
└── README.md
```

---

## 🧪 Notas adicionales

- PostgreSQL usa el puerto **5434** para evitar conflictos locales
- El contenedor frontend usa `REACT_APP_API_URL=http://backend:3010`
- Las variables de entorno están configuradas vía `docker-compose` en lugar de `.env`

---

## 👨‍💻 Autor / Contacto

Este sistema es parte de un entorno moderno de desarrollo desacoplado, con foco en buenas prácticas, portabilidad y automatización.