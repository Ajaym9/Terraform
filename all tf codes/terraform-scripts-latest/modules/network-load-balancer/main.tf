#######################################################################
#         	   create DNS managed zone                            #
#######################################################################

resource "google_dns_managed_zone" "prod" {
  name     = var.dns_managed_zone_name
  dns_name = var.dns_name
  project  = var.project_id
}

#######################################################################
#    create load balancer with target pool	                      #
#######################################################################

resource "google_compute_forwarding_rule" "default" {
  provider              = google-beta
  region                = var.region
  project               = var.project_id
  name                  = var.forwarding_rule
  target       = google_compute_target_pool.default.self_link	
  load_balancing_scheme = var.lbscheme
  port_range            = var.ports
  ip_protocol           = var.ip_protocol
}

resource "google_compute_target_pool" "default" {
  provider         = google-beta
  project          = var.project_id
  name             = var.target_pool
  region           = var.region
  session_affinity = var.session_affinity
  instances = var.instance_url  
}


