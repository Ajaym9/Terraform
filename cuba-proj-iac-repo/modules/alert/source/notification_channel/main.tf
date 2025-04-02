resource "google_monitoring_notification_channel" "email_channel" {
  display_name = var.display_name
  project = var.project
  type         = "email"

  labels = {
    email_address = var.email_address
  }
}


