resource "google_storage_bucket" "log-bucket" {
  name     = var.bucket_name
  location = var.location
  project = var.project
  autoclass {
    enabled = true
  }
  uniform_bucket_level_access = true
}


