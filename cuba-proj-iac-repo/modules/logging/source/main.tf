
###################main.tf#############################
resource "google_logging_project_sink" "my-sink" {
  name   =   var.name
  description = var.description
  #folder = var.foldername
 # include_children  = var.include_children
  destination =  var.destination

  # Log all WARN or higher severity messages relating to instances
  #filter =""
  unique_writer_identity = var.unique_writer_identity#true
}
resource "google_project_iam_binding" "log-writer" {
  project = var.project
  role = var.role

members = [
    google_logging_project_sink.my-sink.writer_identity,
  ]
}


