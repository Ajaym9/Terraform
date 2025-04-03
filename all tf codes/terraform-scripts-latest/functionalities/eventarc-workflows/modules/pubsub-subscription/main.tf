#####################################################################
#  Create Pubsub subscription with required permissions             #
#####################################################################

locals {
  oidc_config = {
    for k, v in var.push_configs : k => v.oidc_token
  }
  subscriptions = {
    for k, v in var.subscriptions : k => {
      topic   = v.topic
      labels  = try(v.labels, v, null) == null ? {} : v.labels
      options = try(v.options, v, null) == null ? var.defaults : v.options
    }
  }
}


#####################################################################
#                    Create Pubsub subscription                     #
#####################################################################

resource "google_pubsub_subscription" "default" {
  for_each                     = local.subscriptions
  project                      = var.project_id
  name                         = each.key
  topic                        = each.value.topic
  labels                       = each.value.labels
  ack_deadline_seconds         = each.value.options.ack_deadline_seconds
  message_retention_duration   = each.value.options.message_retention_duration
  retain_acked_messages        = each.value.options.retain_acked_messages
  enable_message_ordering      = each.value.options.enable_message_ordering
  enable_exactly_once_delivery = each.value.options.enable_exactly_once_delivery

  retry_policy {
    minimum_backoff = var.minimum_backoff
    maximum_backoff = var.maximum_backoff
  }

  dynamic "expiration_policy" {
    for_each = each.value.options.expiration_policy_ttl == null ? [] : [""]
    content {
      ttl = each.value.options.expiration_policy_ttl
    }
  }

  dynamic "dead_letter_policy" {
    for_each = try(var.dead_letter_configs[each.key], null) == null ? [] : [""]
    content {
      dead_letter_topic     = var.dead_letter_configs[each.key].topic
      max_delivery_attempts = var.dead_letter_configs[each.key].max_delivery_attempts
    }
  }

  dynamic "push_config" {
    for_each = try(var.push_configs[each.key], null) == null ? [] : [""]
    content {
      push_endpoint = var.push_configs[each.key].endpoint
      attributes    = var.push_configs[each.key].attributes
      dynamic "oidc_token" {
        for_each = (
          local.oidc_config[each.key] == null ? [] : [""]
        )
        content {
          service_account_email = local.oidc_config[each.key].service_account_email
          audience              = local.oidc_config[each.key].audience
        }
      }
    }
  }

}



