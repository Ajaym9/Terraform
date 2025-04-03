variable "project_id" {
  description = "Bucket project id."
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


variable "record_type" {
  type        = string
  description = "record type"
}

variable "ttl" {
  type        = number
  description = "ttl"
}

variable "rrdatas" {
  type        = list(string)
  description = "rrdatas"
}

variable "dns_authname" {
  type        = string
  description = "dns authorization name"
}

variable "dns_description" {
  type        = string
  description = "dns description"
}

variable "domain" {
  type        = string
  description = "domain"
}


variable "ssl_certificate_name" {
  type        = string
  description = "ssl certificate name"
}

variable "ssl_domain_name" {
  type        = list(string)
  description = "ssl certificate domain name"
}


#### Global forwarding rule
variable "global_address" {
  type = string
}

variable "global_forwarding_rule_name" {
  type        = string
  description = "global forwarding rule name"
}

variable "forwarding_ip_protocol" {
  type        = string
  description = "ip protocol"
}

variable "lb_balancing_scheme" {
  type = string
}

variable "port_range" {
  type = string
}

variable "target_proxy_name" {
  type = string
}

variable "url_map_name" {
  type = string
}

####
variable "backend_service" {
  type = string
}

variable "backend_protocol" {
  type = string
}

variable "enable_cdn" {
  type    = bool
  default = true
}

variable "backend_balancing_scheme" {
  type = string
}

variable "balancing_mode" {
  type = string
}

####
variable "neg_name" {
  type = string
}

variable "endpoint_type" {
  type = string
}

variable "region" {
  type = string
}

variable "app_service" {
  type = string
}

variable "app_version_id" {
  type = string
}

##certificate manager
variable "appid" {
  type = string
}
variable "certificate_map" {
  type = string
}

variable "map_entry" {
  type = string
}


variable "matcher" {
  type = string
}

variable "ip_version" {
  type = string
}










