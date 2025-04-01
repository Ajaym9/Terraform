module "vm"{
    source = "./source/vm"
    for_each = var.instances
    instance_name = each.key
    machine_type = each.value.machine_type
    project_id = each.value.project_id
    zone = each.value.zone
    image=each.value.image
    network = each.value.network   
}



#######################################VPC#############################

module "vpc" {
  for_each = tomap(var.vpc)

  source          = "./modules/vpc/source"
  project_id      = each.value.project_id
  network_name    = each.value.network_name
  description     = each.value.description
  routing_mode    = each.value.routing_mode
  auto_create_subnetworks = each.value.auto_create_subnetworks
  delete_default_internet_gateway_routes = each.value.delete_default_internet_gateway_routes
 mtu = each.value.mtu
}



######## module block for subnet creation ###########
module "subnet" {
  source  = "./source/subnet"
  network_project_id = each.value.project_id
  for_each = tomap(var.subnet_details)
  vpc_name = each.value.vpc_name
  subnet_name = each.key
  ip_range = each.value.ip_range
  subnet_region = each.value.region
  private_ip_google_access = each.value.private_ip_google_access
}



#module block for secondary ip subnet creation
module "secipsubnet" {
  source  = "./source/secipsubnet"
  network_project_id = each.value.project_id
  for_each = tomap(var.secipsubnet_details)
  vpc_name = each.value.vpc_name
  subnet_name = each.key
  ip_range = each.value.ip_range
  subnet_region = each.value.region
  range_name = each.value.range_name
  sec_ip_range = each.value.sec_ip_range
  range_name_2 = each.value.range_name_2
  sec_ip_range_2 = each.value.sec_ip_range_2
}




#module block for creating service account
module "service-account" {
source = "./source/serviceaccount"
for_each = tomap(var.svcacct_details)
account_id = each.key
display_name = each.value.display_name
project_id  = each.value.project_id
}


#module block for enablement of api
module "enableapi" {
  source     = "./source/api"
  for_each   = tomap(var.enable_api)
  apiname    = each.key
  project_id = each.value
}




##############################################################################
            # NAT #
##############################################################################
module "cloud_nat_gateways" {
  for_each = var.nat_gateways

  source                             = "./source/nat"
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