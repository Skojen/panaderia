variable "project_id" {
  type        = string
  description = "ID del proyecto de Google Cloud"
}

variable "account_id" {
  type        = string
  description = "ID de la cuenta de servicio (sin dominio)"
}

variable "display_name" {
  type        = string
  description = "Nombre visible para la cuenta de servicio"
}

variable "create" {
  type        = bool
  default     = true
  description = "Si se debe crear la cuenta de servicio"
}

variable "impersonate_members" {
  type        = list(string)
  default     = []
  description = "Lista de miembros (por ejemplo user:correo@dominio.com) con permiso de impersonar esta cuenta"
}