resource "google_monitoring_notification_channel" "basic" {
  display_name = var.notificationdisplayname
  project      = var.project_id
  type         = var.type
  labels =  var.labels
}
