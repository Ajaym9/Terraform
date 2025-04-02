##############################################################################
            # ALERT #
##############################################################################

module "notification_channels" {
  for_each = { for idx, channel in var.notification_channels : idx => channel }

  source         = "./modules/alert/source/notification_channel"
  display_name   = each.value.display_name
  email_address  = each.value.email_address
  project = var.project
}

# Create alert policies
module "alert_policies" {
  for_each = { for idx, policy in var.alert_policies : idx => policy }

  source                   = "./modules/alert/source/alert_policy"
  project                  = var.project
  display_name             = each.value.display_name
  notification_channel_ids = values(module.notification_channels)[*].notification_channel_id
  conditions               = each.value.conditions
}
##############################################################################
            # API #
##############################################################################
module "enableapi" {
  source     = "./modules/api/source"
  for_each   = tomap(var.enable_api1)
  apiname    = each.value.apiname
  project_id = each.value.project_id
}

##############################################################################
            # Firewall #
##############################################################################
module "firewall_rules" {
  source = "./modules/firewall/source"

  for_each = var.firewall_rules

  name                      = each.value.name
  network                   = each.value.network
 project = each.value.project
  direction                 = each.value.direction
  priority                  = each.value.priority
  disabled                  = each.value.disabled
  allowed                   = each.value.allowed
  denied                    = each.value.denied
  source_ranges             = each.value.source_ranges
  source_tags               = each.value.source_tags
  source_service_accounts   = each.value.source_service_accounts
  destination_ranges        = each.value.destination_ranges
  target_tags               = each.value.target_tags
  target_service_accounts   = each.value.target_service_accounts
  log_metadata              = each.value.log_metadata
}
##############################################################################
            # Bucket #
##############################################################################
module "bucket" {
    source = "./modules/gcs/source"
    for_each = tomap(var.bucket_details)
    bucket_name = each.value.bucket_name
    location = each.value.location
    project = each.value.project
}

##############################################################################
            # Logging #
##############################################################################
module "Logging" {
  source      = "./modules/logging/source"
  for_each    = tomap(var.sink_details)
  project     = each.value.project
  name        = each.value.name
  description = each.value.description
  #include_children = each.value.include_children
  destination = each.value.destination
  #filter =  each.value.filter
  unique_writer_identity = each.value.unique_writer_identity
  role                   = each.value.role


}

##############################################################################
            # NAT #
##############################################################################
module "cloud_nat_gateways" {
  for_each = var.nat_gateways

  source                             = "./modules/nat/source"
  project                            = each.value.project
  region                             = each.value.region
  network                            = each.value.network
  router_name                        = each.value.router_name
  nat_name                           = each.value.nat_name
  nat_ip_allocate_option             = each.value.nat_ip_allocate_option
  source_subnetwork_ip_ranges_to_nat = each.value.source_subnetwork_ip_ranges_to_nat
  enable_log_config                  = each.value.enable_log_config
  nat_ips                            = each.value.nat_ips
 # min_ports_per_vm                   = each.value.min_ports_per_vm
 # max_ports_per_vm                   = each.value.max_ports_per_vm
  filter                             = each.value.filter
}

##############################################################################
            # Project IAM #
##############################################################################
module "iam" {
    source = "./modules/projectiam/source"
    for_each = tomap(var.iam)
    project_id = each.value.project_id
    roles = each.value.roles
    members = each.value.members
}

##############################################################################
            # Subnets #
##############################################################################
module "subnet" {
  source = "./modules/subnets/source"

  subnets = var.subnets

  secondary_ranges = var.secondary_ranges

}

##############################################################################
            # VM #
##############################################################################
#module block for vm creation
module "vm" {
  source       = "./modules/vm/source"
  for_each     = tomap(var.instance_details)
  project_id   = each.value.project_id
  vm_name      = each.value.vm_name
  zone         = each.value.zone
  machine_type = each.value.machine_type
  network      = each.value.network
  subnetwork   = each.value.subnetwork
  network_ip   = each.value.network_ip
  sa-email     = each.value.service_account
  disk_size    = each.value.disk_size
  disk_type    = each.value.disk_type
  image        = each.value.image
  tags         = each.value.tags
  hostname     = each.value.hostname
}
##############################################################################
            # VPC #
##############################################################################
module "vpcs" {
  for_each = tomap(var.vpcs)

  source          = "./modules/vpc/source"
  project_id      = each.value.project_id
  network_name    = each.value.network_name
  description     = each.value.description
  routing_mode    = each.value.routing_mode
  auto_create_subnetworks = each.value.auto_create_subnetworks
  delete_default_internet_gateway_routes = each.value.delete_default_internet_gateway_routes
 mtu = each.value.mtu
}
##########################################################
                 #VPC Access Connecter#
##########################################################
module "vpc_access_connector" {
    source = "./modules/vpc_access_control"
    for_each = tomap(var.access_connector)
    name = each.value.name
    ip_cidr_range = each.value.ip_cidr_range
    network   = each.value.network
    region = each.value.region
    project = each.value.project
    min_instances = each.value.min_instances
    max_instances =each.value.max_instances
    machine_type = each.value.machine_type
}
######################################################
          ##postgress SQL##
######################################################
module "sql_instances" {
  source = "./modules/sql"

  for_each          = { for instance in var.sql_instances : instance.instance_name => instance }
  instance_name     = each.value.instance_name
  database_version  = each.value.database_version
  region            = each.value.region
  tier              = each.value.tier
  availability_type = each.value.availability_type
  disk_size         = each.value.disk_size
  enable_backup     = each.value.enable_backup
  backup_start_time = each.value.backup_start_time
  deletion_protection = each.value.deletion_protection
  vpc_network       = each.value.vpc_network
  database_users    = each.value.database_users
}





