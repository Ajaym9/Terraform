resource "google_project" "dev-project" {
  name       = var.project_name
  project_id = "${var.project_name}"
  folder_id  = var.folder_id
  billing_account = var.billing_id
  auto_create_network = false
}
