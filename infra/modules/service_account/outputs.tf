output "email" {
  value       = try(google_service_account.this[0].email, "")
  description = "Email de la cuenta de servicio creada (vacío si no se creó)"
}
