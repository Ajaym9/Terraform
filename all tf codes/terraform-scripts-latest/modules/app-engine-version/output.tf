output "app-engine-service" {
  description = "App Engine service ID."
  value       = google_app_engine_standard_app_version.myapp_v1.service
}

output "app-engine-version-id" {
  description = "App Engine version ID."
  value       = google_app_engine_standard_app_version.myapp_v1.version_id
}