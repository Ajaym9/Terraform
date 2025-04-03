resource "google_container_cluster" "primary" {
provider                    = google-beta
  name     = var.cluster_name
  location = var.cluster_location
  project  = var.project_id
  remove_default_node_pool = var.default_node_pool 
  initial_node_count       = var.initial_node_count 
}


resource "google_container_node_pool" "primary_preemptible_nodes" {
provider                    = google-beta
 project = var.project_id
  name       = var.pool_name
 location   = var.pool_location
  cluster    = google_container_cluster.primary.name
  node_count = var.node_count
  node_config {
    preemptible  = var.preemptible_config
    machine_type = var.machine_type
    service_account = var.service_account_email
    oauth_scopes    = var.scopes                               
  }
}
