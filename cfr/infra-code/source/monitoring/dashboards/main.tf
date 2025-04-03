//custom dashboard creation
resource "google_monitoring_dashboard" "dashboard" {
  dashboard_json = var.dashboard_json
  project        = var.project_id
}
