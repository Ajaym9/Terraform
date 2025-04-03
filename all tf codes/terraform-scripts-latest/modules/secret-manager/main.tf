resource "google_project_service_identity" "security" {
  provider = google-beta
  project  = var.project_id
  service  = var.secret_service
}

resource "google_secret_manager_secret" "value" {
  secret_id = var.secret_id
  project   = var.project_id
  replication {
    user_managed {
      replicas {
        location = var.secret_location
      }
    }
  }
  depends_on = [google_project_service_identity.security]
}

resource "google_secret_manager_secret_iam_member" "role" {
  project   = var.project_id
  secret_id = google_secret_manager_secret.value.secret_id
  role      = var.secret_role
  member    = var.secret_member
}

resource "google_secret_manager_secret_version" "secret_data" {
  secret      = google_secret_manager_secret.value.id
  for_each    = tomap(var.secret_data)
  secret_data = each.value
}
