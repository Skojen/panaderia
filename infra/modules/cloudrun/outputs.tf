output "url" {
  description = "La URL pública del servicio Cloud Run"
  value       = google_cloud_run_service.default.status[0].url
}