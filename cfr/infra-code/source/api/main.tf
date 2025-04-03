resource "google_project_service" "apienable" {
  project = var.project_id
  service = var.apiname
}
