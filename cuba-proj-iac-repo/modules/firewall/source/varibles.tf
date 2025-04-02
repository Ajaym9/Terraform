variable "name" {
  description = "The name of the firewall rule"
  type        = string
}

variable "network" {
  description = "The name or self-link of the network to attach the firewall rule"
  type        = string
}

variable "direction" {
  description = "Direction of traffic (INGRESS or EGRESS)"
  type        = string
  default     = "INGRESS"
}

variable "priority" {
  description = "Priority of the firewall rule"
  type        = number
  default     = 1000
}

variable "disabled" {
  description = "Whether the firewall rule is disabled"
  type        = bool
  default     = false
}
variable "allowed" {
  description = "List of allowed traffic rules"
  type = list(object({
    protocol = string
    ports    = list(string)
  }))
  default = []
}

variable "denied" {
  description = "List of denied traffic rules"
  type = list(object({
    protocol = string
    ports    = list(string)
  }))
  default = []
}

variable "source_ranges" {

  description = "List of source IP ranges for ingress rules"
  type        = list(string)
  default     = []
}

variable "project"{
type = string
}

variable "destination_ranges" {
  description = "List of destination IP ranges for egress rules"
  type        = list(string)
  default     = []
}

variable "source_tags" {
  description = "List of source tags for firewall rule"
  type        = list(string)
  default     = []
}

variable "source_service_accounts" {
  description = "List of source service accounts for firewall rule"
  type        = list(string)
  default     = []
}

variable "target_tags" {
  description = "List of target tags for firewall rule"
  type        = list(string)
  default     = []
}

variable "target_service_accounts" {
  description = "List of target service accounts for firewall rule"
  type        = list(string)
  default     = []
}

variable "log_metadata" {
  description = "Metadata logging configuration"
  type        = string
  default     = "INCLUDE_ALL_METADATA"
}


