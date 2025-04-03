resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  ip_cidr_range = var.ip_range
  region        = var.subnet_region
  network       = var.vpc_name
  project       = var.network_project_id
  private_ip_google_access = true
  secondary_ip_range {
    range_name    = var.range_name
    ip_cidr_range = var.sec_ip_range
  }
  secondary_ip_range {
    range_name = var.range_name_2
    ip_cidr_range = var.sec_ip_range_2
}
}
