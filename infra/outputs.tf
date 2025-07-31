output "backend_url" {
  value       = module.cloudrun_backend.url
  description = "URL pública del backend desplegado en Cloud Run"
}

output "frontend_url" {
  value       = module.cloudrun_frontend.url
  description = "URL pública del frontend desplegado en Cloud Run"
}