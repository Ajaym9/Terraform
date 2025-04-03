###############################################################
#              enables apis                                   #
###############################################################
module "enables-api" {
  source      = "./modules/enables-api"
  project_id  = var.project_id
  service_api = var.service_api
}

#############################################################
#    create service account iam and role binding            #
#############################################################

module "service-account-iam" {
  for_each             = var.service_account_id
  source               = "./modules/service-account-iam"
  project_id           = var.project_id
  service_account_id   = each.key
  account_display_name = each.value.account_display_name
  roles                = each.value.roles
  depends_on           = [module.enables-api]
}

###########################################################
#       Creation of source code buckets                   #
###########################################################

module "source-code-buckets" {
  for_each   = var.buckets
  source     = "./modules/gcs"
  name       = each.key
  location   = each.value.gcs_location
  project_id = var.project_id
}

############################################################
#          Http trigger functions                          #
############################################################

module "http-functions" {
  source                = "./modules/func-http-trigger"
  for_each              = var.http_functions
  cloud_scheduler       = each.value.cloud_scheduler
  scheduler_description = each.value.scheduler_description
  schedule              = each.value.schedule
  time_zone             = each.value.time_zone
  deadline              = each.value.deadline
  http_method           = each.value.http_method
  service_account_email = module.service-account-iam["sa-scheduler"].service-account-email
  gcs_bucket            = module.source-code-buckets["buc-std-http-us-02"].bucket_name
  function_name         = each.value.function_name
  function_des          = each.value.function_des
  source_path           = each.value.source_path
  runtime               = each.value.runtime
  project_id            = var.project_id
  memory                = var.memory
  trigger_http          = var.trigger_http
  entry_point           = each.value.entry_point
  gcp_region            = each.value.gcp_region
  cloud_func_role       = var.cloud_func_role 
  cloud_func_member     = var.cloud_func_member
  depends_on            = [module.source-code-buckets, module.service-account-iam]
}