resource "google_compute_global_address" "private_ip_address" {
  provider      = google-beta
  name          = var.ip_name
  project       = var.host-project
  purpose       = var.ip_purpose
  address_type  = var.ip_type
  prefix_length = 22
  address       = "10.157.20.0"
  ip_version    = var.ip_version
  network       = var.network
}

resource "google_service_networking_connection" "private_vpc_connection" {
  provider                = google-beta
  network                 = var.network
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

#code for postgresql instance creation
resource "google_sql_database_instance" "data-server" {
  name             = var.sql_name
  region           = var.sql_region
  database_version = var.database_version
  project          = var.project_id
  settings {
    tier = var.tier
    ip_configuration {
      ipv4_enabled    = false
      private_network = "projects/${var.host-project}/global/networks/${var.network}"
      #enable_private_path_for_google_cloud_services = true

    }
    backup_configuration {
      enabled = true
      #binary_log_enabled = true
    }

  }
  deletion_protection = false
  depends_on          = [google_service_networking_connection.private_vpc_connection]

}


resource "google_sql_user" "users" {
  project  = var.project_id
  name     = var.name
  instance = google_sql_database_instance.data-server.name
  password = var.password
}
