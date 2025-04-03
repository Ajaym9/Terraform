######################################################################
#    create Global load balancer with backend services                #
#######################################################################

resource "google_compute_global_address" "default" {
  project       = var.static_project_id
  name          = var.global_address
  ip_version = var.ip_version  
}

resource "google_certificate_manager_dns_authorization" "dns" {
  name        = var.dns_authname
  description = var.dns_description
  domain      = var.domain
  project     = var.project_id
}

resource "google_certificate_manager_certificate" "xlb7_cm_ssl_cert_1" {
  name        = var.certificate_manager
  project     = var.project_id
  description = "GCP-managed SSL certificate for the global external layer7 load balancer."
  managed {
    domains            = [
      google_certificate_manager_dns_authorization.dns.domain
    ]
    dns_authorizations = [google_certificate_manager_dns_authorization.dns.id]
  }
}

resource "google_certificate_manager_certificate_map" "certificate_map" {
  name        = var.certificate_map             #"certificate-map"
  description = "Certificate Map"
  project     = var.project_id
}

resource "google_certificate_manager_certificate_map_entry" "certificate_map_entry" {
  name        = var.map_entry		
  description = "certificate map entry"
  project     = var.project_id

  map = google_certificate_manager_certificate_map.certificate_map.name

  certificates = [google_certificate_manager_certificate.xlb7_cm_ssl_cert_1.id]
  hostname = var.host_name			
}

resource "google_compute_global_forwarding_rule" "default" {
  name        = var.global_forwarding_rule_name
  target      = google_compute_target_https_proxy.default.id
  ip_address            = google_compute_global_address.default.id
  ip_protocol = var.forwarding_ip_protocol
  project     = var.project_id
  load_balancing_scheme   = var.lb_balancing_scheme
  port_range = var.port_range
 depends_on=[google_compute_global_address.default]
}

resource "google_compute_target_https_proxy" "default" {
  name             = var.target_proxy_name
  project          = var.project_id 
  url_map          = google_compute_url_map.default.id
certificate_map = "//certificatemanager.googleapis.com/${google_certificate_manager_certificate_map.certificate_map.id}"
depends_on=[google_compute_global_address.default]
}

resource "google_compute_url_map" "default" {
  name            = var.url_map_name
  project         = var.project_id
  default_service = google_compute_backend_bucket.image_backend.id
}

resource "google_compute_backend_bucket" "image_backend" {
  name        = var.backend_name
  project     = var.project_id
  bucket_name = google_storage_bucket.bucket.name
  enable_cdn  = var.enable_cdn
  depends_on  = [google_storage_bucket.bucket]
   cdn_policy {
    cache_mode        =  var.cache_mode   	        #"CACHE_ALL_STATIC"
    client_ttl        = var.client_ttl			#3600
    default_ttl       = var.default_ttl      		#3600
    max_ttl           = var.max_ttl 			#86400
    negative_caching  = var.negative_caching		#true
    serve_while_stale = var.serve_while_stale		#86400
  }

}

#######################################################################
#  Create Google cloud storage bucket with required permissions       #
#######################################################################

locals {
  prefix = (
    var.prefix == null || var.prefix == "" # keep "" for backward compatibility
    ? ""
    : "${var.prefix}-"
  )
  notification = try(var.notification_config.enabled, false)
}

resource "google_storage_bucket" "bucket" {
  name                        = "${local.prefix}${lower(var.name)}"
  project                     = var.project_id
  location                    = var.location
  storage_class               = var.storage_class
  force_destroy               = var.force_destroy
  uniform_bucket_level_access = var.uniform_bucket_level_access
  labels                      = var.labels
  versioning {
    enabled = var.versioning
  }

  dynamic "website" {
    for_each = var.website == null ? [] : [""]

    content {
      main_page_suffix = var.website.main_page_suffix
      not_found_page   = var.website.not_found_page
    }
  }

  dynamic "encryption" {
    for_each = var.encryption_key == null ? [] : [""]

    content {
      default_kms_key_name = var.encryption_key
    }
  }

  dynamic "retention_policy" {
    for_each = var.retention_policy == null ? [] : [""]
    content {
      retention_period = var.retention_policy.retention_period
      is_locked        = var.retention_policy.is_locked
    }
  }

  dynamic "logging" {
    for_each = var.logging_config == null ? [] : [""]
    content {
      log_bucket        = var.logging_config.log_bucket
      log_object_prefix = var.logging_config.log_object_prefix
    }
  }

  dynamic "cors" {
    for_each = var.cors == null ? [] : [""]
    content {
      origin          = var.cors.origin
      method          = var.cors.method
      response_header = var.cors.response_header
      max_age_seconds = max(3600, var.cors.max_age_seconds)
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rule

    content {
      action {
        type          = lifecycle_rule.value.action["type"]
        storage_class = lifecycle_rule.value.action["storage_class"]
      }
      condition {
        age                        = lifecycle_rule.value.condition["age"]
        created_before             = lifecycle_rule.value.condition["created_before"]
        with_state                 = lifecycle_rule.value.condition["with_state"]
        matches_storage_class      = lifecycle_rule.value.condition["matches_storage_class"]
        num_newer_versions         = lifecycle_rule.value.condition["num_newer_versions"]
        custom_time_before         = lifecycle_rule.value.condition["custom_time_before"]
        days_since_custom_time     = lifecycle_rule.value.condition["days_since_custom_time"]
        days_since_noncurrent_time = lifecycle_rule.value.condition["days_since_noncurrent_time"]
        noncurrent_time_before     = lifecycle_rule.value.condition["noncurrent_time_before"]
      }
    }
  }
}

resource "google_storage_bucket_iam_member" "bindings" {
  for_each = var.iam
  bucket   = google_storage_bucket.bucket.name
  role     = each.key
  member   = each.value
}






