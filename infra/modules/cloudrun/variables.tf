variable "project_id" {
  type        = string
  description = "ID del proyecto de Google Cloud"
}

variable "region" {
  type        = string
  description = "Región donde se desplegará el servicio"
}

variable "service_name" {
  type        = string
  description = "Nombre del servicio en Cloud Run"
}

variable "container_image" {
  type        = string
  description = "Imagen Docker a desplegar en Cloud Run"
}

variable "db_name" {
  type        = string
  default     = ""
  description = "Nombre de la base de datos (vacío si no aplica)"
}

variable "db_user" {
  type        = string
  default     = ""
  description = "Usuario de la base de datos (vacío si no aplica)"
}

variable "db_password" {
  type        = string
  default     = ""
  description = "Contraseña de la base de datos (vacío si no aplica)"
}

variable "db_instance_connection" {
  type        = string
  default     = ""
  description = "Connection name de Cloud SQL (vacío si no aplica)"
}

variable "use_service_account" {
  type        = bool
  default     = false
  description = "Define si se usará una cuenta de servicio personalizada"
}

variable "service_account_email" {
  type        = string
  default     = ""
  description = "Email de la cuenta de servicio a usar"
}

variable "container_port" {
  type        = number
  default     = 8080
  description = "Puerto que el contenedor escucha internamente"
}

variable "allow_unauthenticated" {
  type        = bool
  default     = false
  description = "Permitir acceso público al servicio"
}

variable "api_url" {
  type        = string
  description = "URL del backend para consumir desde el frontend"
  default     = ""
}