resource "google_compute_firewall" "rule" {
  name    = var.name
  network = var.network
  project = var.project

  direction = var.direction
  priority  = var.priority
  disabled  = var.disabled

  # Allowed traffic rules
  dynamic "allow" {
    for_each = var.allowed
    content {
      protocol = allow.value.protocol
      ports    = allow.value.ports
    }
  }

  # Denied traffic rules
  dynamic "deny" {
    for_each = var.denied
    content {
      protocol = deny.value.protocol
      ports    = deny.value.ports
    }
  }

  source_tags = length(var.source_tags) > 0 && length(var.source_service_accounts) == 0 ? var.source_tags : null
  source_service_accounts = length(var.source_service_accounts) > 0 && length(var.source_tags) == 0 ? var.source_service_accounts : null

  # Set `target_tags` or `target_service_accounts`, not both.
  target_tags = length(var.target_tags) > 0 && length(var.target_service_accounts) == 0 ? var.target_tags : null
  target_service_accounts = length(var.target_service_accounts) > 0 && length(var.target_tags) == 0 ? var.target_service_accounts : null

  source_ranges            = var.source_ranges
  destination_ranges       = var.destination_ranges
  log_config {
    metadata = var.log_metadata
  }
}


