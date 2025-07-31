# === Configuración ===
TF=terraform
ENV ?= dev
TFVARS=terraform.$(ENV).tfvars
TFVARS_EXAMPLE=terraform.example.tfvars

# Extrae project_id automáticamente desde el archivo tfvars
PROJECT_ID := $(shell grep -E '^project_id' $(TFVARS) | sed 's/.*=\s*"\(.*\)"/\1/')

.PHONY: init plan apply destroy output clean check-tfvars \
        build-backend push-backend build-frontend push-frontend \
        deploy-prod lint fmt validate login refresh all default

default: plan

# === Validar archivo tfvars ===
check-tfvars:
	@if [ ! -f $(TFVARS) ]; then \
		echo "⚠️  Archivo $(TFVARS) no encontrado. Creando desde plantilla $(TFVARS_EXAMPLE)..."; \
		cp $(TFVARS_EXAMPLE) $(TFVARS); \
	fi

# === Inicialización y validación ===
all: init validate plan

init: check-tfvars
	$(TF) init

fmt:
	$(TF) fmt -recursive

lint: fmt validate
	@echo "✅ Código Terraform formateado y validado correctamente."

validate:
	$(TF) validate

# === Planificación y despliegue ===
plan: check-tfvars
	$(TF) plan -var-file=$(TFVARS)

apply: check-tfvars
	$(TF) apply -var-file=$(TFVARS)

destroy: check-tfvars
	$(TF) destroy -var-file=$(TFVARS)

refresh: check-tfvars
	$(TF) refresh -var-file=$(TFVARS)

output:
	$(TF) output

# === Build & Push Imágenes ===

build-backend:
	cd ../backend && docker build -t gcr.io/$(PROJECT_ID)/panaderia-backend .

build-frontend:
	cd ../frontend && docker build -t gcr.io/$(PROJECT_ID)/panaderia-frontend .

push-backend:
	docker push gcr.io/$(PROJECT_ID)/panaderia-backend

push-frontend:
	docker push gcr.io/$(PROJECT_ID)/panaderia-frontend

# === Flujo completo de despligue ===
deploy:  check-tfvars build-backend build-frontend push-backend push-frontend init validate plan apply

# === Autentificación GCP ===
login:
	gcloud auth application-default login

# === Limpieza local ===
clean:
	rm -rf .terraform terraform.tfstate* terraform.*.tfvars.backup
