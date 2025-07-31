# === Configuración ===
TF=terraform
ENV ?= dev
TFVARS=terraform.$(ENV).tfvars
TFVARS_EXAMPLE=terraform.example.tfvars

.PHONY: init plan apply destroy output clean check-tfvars

default: plan

# === Validar archivo tfvars ===
check-tfvars:
	@if [ ! -f $(TFVARS) ]; then \
		echo "⚠️  Archivo $(TFVARS) no encontrado. Creando desde plantilla $(TFVARS_EXAMPLE)..."; \
		cp $(TFVARS_EXAMPLE) $(TFVARS); \
	fi

all: init validate plan

# === Inicializar Terraform ===
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

# === Autentificación ===
login:
	gcloud auth application-default login

# === Limpieza ===
clean:
	rm -rf .terraform terraform.tfstate* terraform.*.tfvars.backup
