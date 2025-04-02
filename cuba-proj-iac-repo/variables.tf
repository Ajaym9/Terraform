##############################################################################
            # ALERT #
##############################################################################

variable "notification_channels" {
  description = "List of notification channels"
  type = list(object({
    display_name  = string
    email_address = string
    #project = string
  }))
}

variable "alert_policies" {
  description = "List of alert policies with conditions"
  type = list(object({
    display_name = string
    conditions = list(object({
      display_name    = string
      filter          = string
      comparison      = string
      threshold_value = number
     # project = string
    }))
  }))
}

variable "project" {
type = string
}

##############################################################################
            # API #
##############################################################################

variable "enable_api1" {
    type = map(object({
    apiname = string
    project_id = string
}))
}

##############################################################################
            # Firewall #
##############################################################################

variable "firewall_rules" {
  description = "Map of firewall rules to be created"
  type = map(object({
    name                      = string
    network                   = string
    direction                 = string
    project = string
    priority                  = number
    disabled                  = bool
    allowed                   = list(object({
      protocol = string
      ports    = list(string)
    }))
    denied                    = list(object({
      protocol = string
      ports    = list(string)
    }))
    source_ranges             = list(string)
    source_tags               = list(string)
    source_service_accounts   = list(string)
    destination_ranges        = list(string)
    target_tags               = list(string)
    target_service_accounts   = list(string)
    log_metadata              = string
  }))
}

##############################################################################
            # GCS #
##############################################################################

variable "bucket_details" {
  type = map(object({
    bucket_name = string
    location = string
    project = string
}))
}

##############################################################################
            # logging #
##############################################################################
variable "sink_details" {
  type = map(object({
    project     = string
    name        = string
    description = string
    #include_children = bool
    destination            = string
    unique_writer_identity = bool
    #filter  = string 
    role = string
  }))
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

##############################################################################
            # ProjectIAM #
##############################################################################
variable "iam" {
    type = map(object({
    project_id = string
    roles = string
    members = string
}))
}

##############################################################################
            # Subnets #
##############################################################################

variable "secondary_ranges" {
  type        = map(list(object({ range_name = string, ip_cidr_range = string })))
  description = "Secondary ranges that will be used in some of the subnets"
  default     = {}
}

variable "subnets" {
  type = list(object({
    subnet_name                      = string
    subnet_ip                        = string
    subnet_region                    = string
    project_id = string
    network_name = string
    subnet_private_access            = optional(string, "false")
    subnet_private_ipv6_access       = optional(string)
    subnet_flow_logs                 = optional(string, "false")
    subnet_flow_logs_interval        = optional(string, "INTERVAL_5_SEC")
    subnet_flow_logs_sampling        = optional(string, "0.5")
    subnet_flow_logs_metadata        = optional(string, "INCLUDE_ALL_METADATA")
    subnet_flow_logs_filter          = optional(string, "true")
    subnet_flow_logs_metadata_fields = optional(list(string), [])
    description                      = optional(string)
    purpose                          = optional(string)
    role                             = optional(string)
    stack_type                       = optional(string)
    ipv6_access_type                 = optional(string)
  }))
  description = "The list of subnets being created"
}

##############################################################################
            # VM #
##############################################################################
variable "instance_details" {
  type = map(object({
    project_id      = string
    vm_name         = string
    zone            = string
    machine_type    = string
    network         = string
    subnetwork      = string
    network_ip      = string
    service_account = string
    disk_size       = string
    disk_type       = string
    image           = string
    tags            = list(string)
    hostname        = string
  }))
}

##############################################################################
            # VPC #
##############################################################################
variable "vpcs" {
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

############################################################################
          # VPC Serverless#
###########################################################################

variable "access_connector" {
    type = map(object({
    name = string
    ip_cidr_range = string
    network = string
    region = string
    project = string
    min_instances = number
    max_instances = number
    machine_type = string
}))
}
############################################################################
        # Sql instances #
###########################################################################

variable "sql_instances" {
  type = list(object({
    instance_name       = string
    database_version    = string
    region             = string
    tier               = string
    availability_type  = string
    disk_size         = number
    enable_backup     = bool
    backup_start_time = string
    deletion_protection = bool
    vpc_network       = string
    database_users    = list(object({
      name     = string
      password = string
    }))
  }))
}
