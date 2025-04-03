variable "topics" {
  description = "Pubsub topics"
  type = map(object({
    topic_labels = map(string)
  }))
}

variable "kms_key_name" {
  description = "KMS key name"
  type        = string
  default     = ""
}

variable "project_id" {
  description = "project id"
  type        = string
}

variable "topic_message_retention" {
  description = "pubsub topic message retention"
  type        = string
}

variable "regions" {
  description = "List of regions used to set persistence policy."
  type        = list(string)
  default     = []
}

variable "dead_letter_configs" {
  description = "Per-subscription dead letter policy configuration."
  type = map(object({
    topic                 = string
    max_delivery_attempts = number
  }))
  default = {}
}

variable "minimum_backoff" {
  description = "The minimum delay between consecutive deliveries of a given message."
  type        = string
  default     = null
}

variable "maximum_backoff" {
  description = "The maximum delay between consecutive deliveries of a given message."
  type        = string
  default     = null
}

variable "defaults" {
  description = "Subscription defaults for options."
  type = object({
    ack_deadline_seconds       = number
    message_retention_duration = string
    retain_acked_messages      = bool
    expiration_policy_ttl      = string
  })
  default = {
    ack_deadline_seconds       = null
    message_retention_duration = null
    retain_acked_messages      = null
    expiration_policy_ttl      = null
  }
}

variable "subscriptions" {
  description = "Topic subscriptions. Also define push configs for push subscriptions. If options is set to null subscription defaults will be used. Labels default to topic labels if set to null."
  type = map(object({
    topic  = string
    labels = map(string)
    options = object({
      ack_deadline_seconds         = number
      message_retention_duration   = string
      retain_acked_messages        = bool
      expiration_policy_ttl        = string
      enable_message_ordering      = bool
      enable_exactly_once_delivery = bool
    })
  }))
  default = {}
}

variable "push_configs" {
  description = "Push subscription configurations."
  type = map(object({
    attributes = map(string)
    endpoint   = string
    oidc_token = object({
      audience              = string
      service_account_email = string
    })
  }))
  default = {}
}
