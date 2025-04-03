#######################################################################
#         create DNS managed zone with A records                      #
#######################################################################

resource "google_dns_managed_zone" "prod" {
  name     = var.dns_managed_zone_name
  dns_name = var.dns_name
  project  = var.project_id
}

#######################################################################
#                create DNS authorization                             #
#######################################################################

resource "google_certificate_manager_dns_authorization" "dns" {
  name        = var.dns_authname
  description = var.dns_description
  domain      = var.domain
  project     = var.project_id
  depends_on  = [google_dns_managed_zone.prod]
}

#######################################################################
#                create certificates with certificate manager         #
#######################################################################

resource "google_certificate_manager_certificate" "xlb7_cm_ssl_cert_1" {
  name = "${var.appid}-xlb7-certificate-test-cm-cert-2"
  project     = var.project_id
  description = "GCP-managed SSL certificate for the global external layer7 load balancer."
  managed {
    domains = [var.domain]
    dns_authorizations = [google_certificate_manager_dns_authorization.dns.id]
  }
}


resource "google_certificate_manager_certificate_map" "certificate_map" {
  name        = var.certificate_map
  description = "Certificate Map"
  project = var.project_id
}

resource "google_certificate_manager_certificate_map_entry" "certificate_map_entry" {
  name        = var.map_entry
  description = "certificate map entry"
  project  = var.project_id
  hostname = var.domain
  map      = google_certificate_manager_certificate_map.certificate_map.name

  certificates = [google_certificate_manager_certificate.xlb7_cm_ssl_cert_1.id]
}

#######################################################################
#    create Global load balancer with backend services                #
#######################################################################

resource "google_compute_global_address" "default" {
  project    = var.project_id
  name       = var.global_address
  ip_version = var.ip_version
}

#######################################################################
#    create Global load balancer with backend bucket                  #
#######################################################################

resource "google_compute_global_forwarding_rule" "default" {
  name                  = var.global_forwarding_rule_name
  target                = google_compute_target_https_proxy.default.id
  ip_address            = google_compute_global_address.default.id
  ip_protocol           = var.forwarding_ip_protocol
  project               = var.project_id
  load_balancing_scheme = var.lb_balancing_scheme
  port_range = var.port_range
  depends_on = [google_compute_global_address.default]
}

#######################################################################
#             create target https proxy                               #
#######################################################################

resource "google_compute_target_https_proxy" "default" {
  name    = var.target_proxy_name
  project = var.project_id
  url_map = google_compute_url_map.default.id
  certificate_map = "//certificatemanager.googleapis.com/${google_certificate_manager_certificate_map.certificate_map.id}"
  depends_on      = [google_compute_global_address.default]
}

#######################################################################
#                        create url map                               #
#######################################################################

resource "google_compute_url_map" "default" {
  name            = var.url_map_name
  project         = var.project_id
  default_service = google_compute_backend_service.backend_service.id
}

#######################################################################
#               create a backend service with NEGs                    #
#######################################################################

resource "google_compute_backend_service" "backend_service" {
  name       = var.backend_service
  provider   = google-beta
  protocol   = var.backend_protocol
  enable_cdn = var.enable_cdn
  log_config {
    enable      = true
    sample_rate = 1
  }
  load_balancing_scheme = var.backend_balancing_scheme
  backend {
    group          = google_compute_region_network_endpoint_group.appengine_neg.id
   balancing_mode = var.balancing_mode
  }
}

resource "google_compute_region_network_endpoint_group" "appengine_neg" {
  name                  = var.neg_name
  network_endpoint_type = var.endpoint_type
  region                = var.region
  app_engine {
    service = var.app_service
    version = var.app_version_id
  }
}




