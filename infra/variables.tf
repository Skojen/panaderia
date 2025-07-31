variable "project_id" {
  type        = string
  description = "ID del proyecto de Google Cloud"
}

variable "region" {
  type        = string
  description = "Región de despliegue (por ejemplo, us-central1)"
}

variable "db_instance_name" {
  type        = string
  description = "Nombre de la instancia de Cloud SQL para el backend"
}

variable "db_name" {
  type        = string
  description = "Nombre de la base de datos PostgreSQL en Cloud SQL"
}

variable "db_user" {
  type        = string
  description = "Usuario de la base de datos PostgreSQL"
}

variable "db_password" {
  type        = string
  description = "Contraseña del usuario de la base de datos PostgreSQL"
}

variable "backend_service_name" {
  type        = string
  description = "Nombre del servicio backend en Cloud Run"
}

variable "backend_image" {
  type        = string
  description = "Imagen Docker para el backend"
}

variable "backend_port" {
  type        = number
  default     = 3000
  description = "Puerto interno que expone el backend (Node.js)"
}

variable "frontend_service_name" {
  type        = string
  description = "Nombre del servicio frontend en Cloud Run"
}

variable "frontend_image" {
  type        = string
  description = "Imagen Docker para el frontend"
}

variable "frontend_port" {
  type        = number
  default     = 80
  description = "Puerto interno que expone el frontend (REACT)"
}

variable "deployer_email" {
  type        = string
  description = "Email del usuario o cuenta de servicio que realiza el despliegue"
}

variable "create_service_account" {
  type        = bool
  default     = true
  description = "Indica si se debe crear una cuenta de servicio para el despliegue"
}