resource "google_compute_shared_vpc_service_project" "serviceproject" {
  host_project    = var.host-project
  service_project = var.serviceproject-id
}
 
