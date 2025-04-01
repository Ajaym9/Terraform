resource "google_compute_router" "this" {
  name    = var.router_name
  network = var.network
  region  = var.region
  project = var.project
}

resource "google_compute_router_nat" "this" {
 provider                            = google-beta 
 name                               = var.nat_name
  router                             = google_compute_router.this.name
  region                             = var.region
  project                            = var.project
  nat_ip_allocate_option             = var.nat_ip_allocate_option
  source_subnetwork_ip_ranges_to_nat = var.source_subnetwork_ip_ranges_to_nat
 # type = "PRIVATE"

  log_config {
    enable = var.enable_log_config
    filter = var.filter
  }

  nat_ips = var.nat_ips

  # Optional - if you want to configure the settings for each NAT gateway
 # min_ports_per_vm = var.min_ports_per_vm
 # max_ports_per_vm = var.max_ports_per_vm
}