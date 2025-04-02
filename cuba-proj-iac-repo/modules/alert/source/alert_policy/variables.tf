variable "project" {
  description = "GCP project ID"
  type        = string
}

variable "display_name" {
  description = "Display name for the alert policy"
  type        = string
}

variable "notification_channel_ids" {
  description = "List of notification channel IDs"
  type        = list(string)
}

variable "conditions" {
  description = "List of conditions for the alert policy"
  type = list(object({
    display_name    = string
    filter          = string
    comparison      = string
    threshold_value = number
  }))
}


