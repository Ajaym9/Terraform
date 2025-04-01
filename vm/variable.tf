variable "instances" {
    type = map(object({
     machine_type=string
     project_id=string
     zone= string
     image= string
     network=string 
    }))
  
}


##############################################################################
            # VPC #
##############################################################################
variable "vpc" {
  type = map(object({
    project_id         = string
   network_name    = string
  description     = string
  routing_mode    = string
  auto_create_subnetworks = string
  delete_default_internet_gateway_routes = string
  mtu = string
  }))
}

variable "subnet_details" {
    type = map(object({
    vpc_name = string
    ip_range = string
    region = string
    private_ip_google_access = string
}))
}

variable "secipsubnet_details" {
    type = map(object({
    vpc_name = string
    ip_range = string
    region = string
    sec_ip_range = string
    range_name = string
    range_name_2 = string
    sec_ip_range_2 = string
}))
}


variable "svcacct_details" {
    type = map(object({
    display_name = string
}))
}


variable "enable_api" {
type = map(string)
}


##############################################################################
            # NAT #
##############################################################################

variable "nat_gateways" {
  description = "A map of NAT gateway configurations"
  type = map(object({
    router_name                        = string
    project                            = string
    region                             = string
    network                            = string
    nat_name                           = string
    nat_ip_allocate_option             = string
    source_subnetwork_ip_ranges_to_nat = string
    enable_log_config                  = bool
    nat_ips                            = list(string)
#    min_ports_per_vm                   = number
    filter                             = string
 #   max_ports_per_vm                   = number
  }))
}
