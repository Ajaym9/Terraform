#module block for vm creation
module "vm" {
  source       = "./source/vm"
  for_each     = tomap(var.instance_details)
  project_id   = module.dev-project["dev-project6"].project_id
  vm_name      = each.value.vm_name
  zone         = each.value.zone
  machine_type = each.value.machine_type
  network      = each.value.network
  subnetwork   = each.value.subnetwork
  sa-email     = each.value.service_account
  disk_size    = each.value.disk_size
  image        = each.value.image
  tags         = var.tags
}

#creating sql instance
module "sql" {
  source           = "./source/sql"
  for_each         = tomap(var.sql_details)
  project_id       = module.dev-project["dev-project6"].project_id
  sql_name         = each.value.sql_name
  sql_region       = each.value.sql_region
  tier             = each.value.sql_tier
  database_version = each.value.database_version
  network          = each.value.network
  ip_name          = var.ip_name
  ip_purpose       = var.ip_purpose
  name             = var.name
  ip_type          = var.ip_type
  password         = var.password
  host-project     = var.host-project
  ip_version       = var.ip_version
}

#module block for subnet creation
module "subnet" {
  source  = "./source/subnet"
  network_project_id = var.host-project
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
  network_project_id = var.host-project
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

#module block for composer
module "composer" {
source = "./source/composer"
composer_config = var.composer_config
host-project = var.host-project
}

#module block for assigning iam roles to groups
module "iam" {
    source = "./source/iamroles/projectiam"
    for_each = tomap(var.iam)
    project_id = each.value.project_id
    roles = each.value.roles
    members = each.value.members
}

#module block for assigning roles to service accounts
module "sa-iam" {
    source = "./source/iamroles/projectiam"
    for_each = tomap(var.sa_iam)
    project_id = each.value.project_id
    roles = each.value.roles
    members = each.value.members
}

#module block for making project as serviceproject
module "enableserviceproject" {
  source            = "./source/serviceproject"
  host-project      = var.host-project
  for_each = toset(var.serviceproject_id)
  serviceproject-id = each.value
}

#module block for creating service account
module "service-account" {
source = "./source/serviceaccount"
for_each = tomap(var.svcacct_details)
account_id = each.key
display_name = each.value.display_name
project_id  = module.dev-project["dev-project6"].project_id
}

#module block for enablement of api
module "enableapi" {
  source     = "./source/api"
  for_each   = tomap(var.enable_api)
  apiname    = each.key
  project_id = each.value
}

#module block for enablement of same/different apis in different projects
module "enableapi1" {
  source     = "./source/api"
  for_each   = tomap(var.enable_api1)
  apiname    = each.value.apiname
  project_id = each.value.project_id
}
#module block for service account creation
module "service-account1" {
source = "./source/serviceaccount"
for_each = tomap(var.svc_acct_details)
account_id = each.key
display_name = each.value.display_name
project_id  = module.dev-project["dev-project2"].project_id
}
