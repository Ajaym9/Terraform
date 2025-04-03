variable "project_id" {
  description = "The project ID to create the resources in."
  type        = string
}

variable "dns_managed_zone_name" {
  type        = string
  description = "dns managed zone name"
}

variable "dns_name" {
  type        = string
  description = "dns name"
}

variable "region" {
  description = "All resources will be launched in this region."
  type        = string
}

variable "forwarding_rule" {
 type = string
 description = "forwarding rule name"
}

variable "ip_protocol" {
 type = string
 description = "ip protocol"
}

variable "lbscheme" {
 type = string
 description = "llb scheme"
}


variable "ports" {
type = string
description = "ip ports"
}


variable "target_pool" {
  description = "Name for the target pool"
  type        = string
}

variable "session_affinity" {
  description = "The session affinity for the backends, e.g.: NONE, CLIENT_IP. Default is NONE."
  type        = string
  default     = "NONE"
}

variable "instance_url" {
type = list(string)
 description = "instance url"
}




