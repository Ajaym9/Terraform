resource "google_monitoring_notification_channel" "basic" {
  display_name = var.notificationdisplayname
  project      = var.project_id
  type         = "email"
  labels = {
    email_address = var.email
  }
}
