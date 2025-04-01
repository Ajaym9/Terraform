variable "project" {
  description = "The Google Cloud project ID"
  type        = string
}

variable "region" {
  description = "The region where the NAT gateway should be created"
  type        = string
}

variable "network" {
  description = "The VPC network name"
  type        = string
}

variable "router_name" {
  description = "The name of the Cloud Router"
  type        = string
}

variable "nat_name" {
  description = "The name of the NAT gateway"
  type        = string
}

variable "nat_ip_allocate_option" {
  description = "NAT IP allocation option"
  type        = string
}

variable "source_subnetwork_ip_ranges_to_nat" {
  description = "The subnets that will be used for NAT"
  type        = string
}

variable "enable_log_config" {
  description = "Enable NAT logging"
  type        = bool
}

variable "nat_ips" {
  description = "List of IP addresses to use for the NAT gateway"
  type        = list(string)
  default     = []
}

#variable "min_ports_per_vm" {
 # description = "Minimum ports per VM"
 # type        = number
#}

#variable "max_ports_per_vm" {
 # description = "Maximum ports per VM"
 # type        = number
#}

variable "filter" {
  type = string
}


