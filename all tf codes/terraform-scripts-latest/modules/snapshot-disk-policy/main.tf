
resource "google_compute_disk_resource_policy_attachment" "attachment" {
  name = google_compute_resource_policy.snapshot.name
  disk = var.disk_name
  project = var.project_id
  zone = var.disk_zone
}

resource "google_compute_resource_policy" "snapshot" {
  name   = var.snapshot_policy_name 	
  region = var.snapshot_policy_region	
  project = var.project_id 
  snapshot_schedule_policy {
    schedule {
      daily_schedule {
        days_in_cycle = var.policy_days 
        start_time    = var.start_time 	
      }
    }
  }
}

/*
################compute policies for weekly schedule

resource "google_compute_resource_policy" "snapshot" {
  name    = var.snapshot_policy_name
  region  = var.snapshot_policy_region
  project = var.project_id
  snapshot_schedule_policy {
    schedule {
      weekly_schedule {
        day_of_weeks {
          start_time = var.start_time
          day        = var.day_of_snapshot
        }
      }
    }
    retention_policy {
      max_retention_days = var.max_retention_days
    }
  }
}
*/