resource "google_cloud_run_service" "default" {
  name     = var.run_name		
  location = var.run_location		
project = var.project_id		
  template {
    spec {
      containers {
        image = var.run_container_image		
      }
    }
  }

  traffic {
    percent         = var.run_percent		
    latest_revision = var.run_revision		
  }
}

resource "google_cloud_run_service_iam_member" "member" {
  for_each = toset(var.run_roles)
  location = google_cloud_run_service.default.location
  project = google_cloud_run_service.default.project
  service = google_cloud_run_service.default.name
  role = each.value				
  member = var.run_member			
}



