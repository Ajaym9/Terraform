resource "google_logging_project_sink" "sink1" {
  name        = var.sink_name
  destination = var.destination
  project = var.source-project-id
  filter = var.filter
  exclusions {
    name        = var.exclusion_name
    description = var.exclusion_description
    filter      = var.exclusion_filter
  }
  unique_writer_identity = true
}
 
resource "google_project_iam_member" "iamrolesink" {
  project = var.log-projectid
  role   = var.role
  member = google_logging_project_sink.sink1.writer_identity
}
