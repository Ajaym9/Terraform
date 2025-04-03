resource "google_logging_project_sink" "my-sink" {
  name   = var.sink_name
  project = var.source-project-id
  destination = var.destination
  filter = var.filter
  unique_writer_identity=true
}
 
resource "google_project_iam_member" "iamrolesink" {
  project = var.log-projectid
  role   = var.role
  member = google_logging_project_sink.my-sink.writer_identity
}
