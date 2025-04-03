resource "google_logging_organization_sink" "my-sink" {
  name   = var.org_sinkname
  description = var.description
  org_id = var.org_id
 
  # Can export to pubsub, cloud storage, or bigquery
  destination = var.destination
 
  # Log all WARN or higher severity messages relating to instances
  filter = var.filter
  include_children = true
}
 
 
resource "google_project_iam_member" "log-writer" {
  project = var.log-projectid
  role    = var.role
  member  = google_logging_organization_sink.my-sink.writer_identity
}
