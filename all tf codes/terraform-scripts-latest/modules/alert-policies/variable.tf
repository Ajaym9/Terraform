variable "alertname" {
  type = string
}
variable "notification_channel" {
  type = list(string)
}
variable "combiner" {
  type = string
}
variable "condition_name" {
  type = string
}
variable "project_id" {
  type = string
}

variable "condition_threshold" {
  description = "A condition that compares a time series against a threshold."
  type = object({
    filter               = string
    duration             = string
    threshold            = number
    comparison           = string
    alignment_period     = string
    per_series_aligner   = string
  })
}

