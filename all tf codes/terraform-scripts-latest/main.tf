###################################################
#              Enable apis		          #
###################################################

module "enables-api" {
  source      = "./modules/enables-api"
  project_id  = var.project_id
  service_api = var.service_api
}

#############################################################
#    create service account iam and role binding            #
#############################################################

module "service-account-iam" {
  source               = "./modules/service-account-iam"
  for_each             = var.service_account_id
  project_id           = var.project_id
  service_account_id   = each.key
  account_display_name = each.value.account_display_name
  roles                = each.value.roles
  depends_on           = [module.enables-api]
}


###################################################
#              Cloud run		          #
###################################################

module "cloud_run_website" {
  source              = "./modules/cloud-run"
  for_each            = var.cloud_run
  run_name            = each.key
  run_location        = each.value.run_location
  project_id          = var.project_id
  run_container_image = each.value.run_container_image
  run_percent         = each.value.run_percent
  run_revision        = each.value.run_revision
  run_roles           = var.run_roles
  run_member          = var.run_member
  depends_on          = [module.enables-api]
}

###################################################
#              Kubernetes		          #
###################################################

module "gke-container" {

  source                = "./modules/gke-container"
  for_each              = var.clusters
  project_id            = var.project_id
  cluster_name          = each.key
  cluster_location      = each.value.cluster_location
  default_node_pool     = each.value.default_node_pool
  initial_node_count    = each.value.initial_node_count
  pool_name             = each.value.pool_name
  pool_location         = each.value.pool_location
  node_count            = each.value.node_count
  preemptible_config    = each.value.preemptible_config
  machine_type          = each.value.machine_type
  service_account_email = var.gke_sa_email
  scopes                = var.gke_scopes
  depends_on            = [module.enables-api, module.service-account-iam]
}

###################################################
#              Function generation2		  #
###################################################

module "cloud_function_v2" {

  source                 = "./modules/function_gen2"
  for_each               = var.cloud_functions_gentwo
  function_name          = each.key
  project_id             = var.project_id
  source_path            = each.value.source_path
  function_source_bucket = each.value.function_source_bucket
  bucket_location        = each.value.bucket_location
  object_name            = each.value.object_name
  function_location      = each.value.function_location
  function_description   = each.value.function_description
  runtime                = each.value.runtime
  entry_point            = each.value.entry_point
  instance_count         = each.value.instance_count
  available_memory       = each.value.available_memory
  timeout_seconds        = each.value.timeout_seconds
  function_roles         = var.function_roles_gentwo
  member                 = var.function_member_gentwo
  depends_on             = [module.enables-api]
}

###################################################
#          pubsub topics & Subscription	          #
###################################################

module "pubsub" {
  source                  = "./modules/pubsub"
  topics                  = var.pubsub_topics
  project_id              = var.project_id
  topic_message_retention = var.topic_message_retention
  subscriptions           = var.pubsub_subscriptions
  minimum_backoff         = var.minimum_backoff
  maximum_backoff         = var.maximum_backoff
  depends_on              = [module.enables-api]
}


###########################################################
#       	GCS BUCKETS	                          #
###########################################################

module "gcs-buckets" {
  for_each   = var.gcs_buckets
  source     = "./modules/gcs"
  name       = each.key
  location   = each.value.gcs_location
  project_id = var.project_id
  depends_on = [module.enables-api]
}

############################################################
#           HTTP trigger Cloud functions-v1                #
############################################################

module "http-functions-gen1" {
  source            = "./modules/cloud_functions_gen1"
  for_each          = var.functions_genone
  gcs_bucket        = module.gcs-buckets["gcs-bucket-std-us-01"].bucket_name
  function_name     = each.key
  function_des      = each.value.function_des
  source_path       = each.value.source_path
  runtime           = each.value.runtime
  project_id        = var.project_id
  memory            = each.value.memory
  trigger_http      = each.value.trigger_http
  entry_point       = each.value.entry_point
  gcp_region        = each.value.gcp_region
  cloud_func_role   = var.cloud_func_role_http
  cloud_func_member = var.cloud_func_member_http
  depends_on        = [module.gcs-buckets, module.enables-api]
}

##############################################################
#             GCS Event trigger Cloud functions-v1           #
##############################################################

module "gcs-event-trigger" {
  source             = "./modules/func-event-trigger"
  for_each           = var.event_functions
  source_path        = each.value.source_path
  source_code_bucket = module.gcs-buckets["gcs-bucket-std-us-02"].bucket_name
  trigger_bucket     = each.value.trigger_bucket
  function_name      = each.value.function_name
  function_des       = each.value.function_des
  runtime            = each.value.runtime
  project_id         = var.project_id
  memory             = each.value.memory
  event_type         = each.value.event_type
  event_resource     = each.value.event_resource
  entry_point        = each.value.entry_point
  gcp_region         = each.value.gcp_region
  cloud_func_role    = var.cloud_func_role_event
  cloud_func_member  = var.cloud_func_member_event
  depends_on         = [module.gcs-buckets]
}

##############################################################
#             	Snapshot disk policy                         #
##############################################################

module "snapshot-creation" {
  source                 = "./modules/snapshot-disk-policy"
  for_each               = var.snapshots_creation
  snapshot_policy_region = var.snapshot_policy_region
  snapshot_policy_name   = each.key
  project_id             = var.project_id
  policy_days            = var.policy_days
  start_time             = var.start_time
  disk_name              = each.value.disk_name
  disk_zone              = each.value.disk_zone
  #day_of_snapshot       = var.day_of_snapshot		# to create weekly snapshots
  #max_retention_days    = var.max_retention_days       # to create weekly snapshots
}


##############################################################
#          Network load balancer with GCE as backend         #
##############################################################

module "vm-instance" {
  source        = "./modules/compute-instance"
  project_id    = var.project_id
  for_each      = var.compute_instances
  instance_name = each.key
  machine_type  = each.value.machine_type
  zone          = each.value.zone
  image         = each.value.image
  vpc_network   = each.value.vpc_network
  depends_on    = [module.enables-api]
}

module "network-load-balancer" {
  source                = "./modules/network-load-balancer"
  for_each              = var.network_load_balancer
  project_id            = var.project_id
  dns_managed_zone_name = each.value.dns_managed_zone_name
  dns_name              = each.value.dns_name
  forwarding_rule       = each.key
  region                = each.value.region
  lbscheme              = each.value.lbscheme
  ip_protocol           = each.value.ip_protocol
  ports                 = each.value.ports
  target_pool           = each.value.target_pool
  instance_url          = [module.vm-instance["instance-02"].instance-url]
  depends_on            = [module.enables-api]
}

##############################################################
#      Monitoring - alert policies and notification channels #
##############################################################

module "notification_channels" {
  source                  = "./modules/notification-channel"
  for_each                = var.notification_channel
  project_id              = var.project_id
  notificationdisplayname = each.key
  type                    = each.value.notification_type
  labels                  = each.value.labels
}

module "alert-01" {
  source     = "./modules/alert-policies"
  project_id = var.project_id
  # pass the notification channel as lists
  notification_channel = [module.notification_channels["email-01"].notification-channel-name, module.notification_channels["email-02"].notification-channel-name]
  alertname            = "alert-01"
  combiner             = "OR"
  condition_name       = "cond-alert-01"
  condition_threshold = {
    filter             = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\" resource.type=\"gce_instance\""
    duration           = "300s"
    threshold          = 0.8
    comparison         = "COMPARISON_GT"
    alignment_period   = "60s"
    per_series_aligner = "ALIGN_MEAN"
  }
  depends_on = [module.notification_channels]
}

##############################################################
#      			API Gateways			     #
##############################################################

module "api-gateway" {
  source     = "./modules/api-gateway"
  for_each   = var.api_gateways
  project_id = var.project_id
  api_id     = each.key
  config_id  = each.value.config_id
  path       = each.value.path
  contents   = each.value.contents
  region     = each.value.region
  gateway_id = each.value.gateway_id
  depends_on = [module.http-functions-gen1, module.enables-api]
}


##############################################################
#      			App Engine			     #
##############################################################

module "app_versions" {
  source                    = "./modules/app-engine-version"
  for_each                  = var.app_engine_services
  project_id                = var.project_id
  auth_fail_action          = var.auth_fail_action
  login                     = var.login
  security_level            = var.security_level
  application_readable      = var.application_readable
  expiration                = var.expiration
  require_matching_file     = var.require_matching_file
  index_path                = var.index_path
  script_path               = var.script_path
  upload_index_path         = var.upload_index_path
  app_versions              = each.value.app_versions
  service                   = each.value.service
  runtime                   = each.value.runtime
  entrypoint_shell          = each.value.entrypoint
  source_url                = each.value.source_url
  env_variables             = each.value.env_variables
  max_concurrent_requests   = each.value.automatic_scaling.max_concurrent_requests
  min_idle_instances        = each.value.automatic_scaling.min_idle_instances
  max_idle_instances        = each.value.automatic_scaling.max_idle_instances
  min_pending_latency       = each.value.automatic_scaling.min_pending_latency
  max_pending_latency       = each.value.automatic_scaling.max_pending_latency
  cpu_utilization           = each.value.scheduler_settings.target_cpu_utilization
  throughput_utilization    = each.value.scheduler_settings.target_throughput_utilization
  min_instances             = each.value.scheduler_settings.min_instances
  max_instances             = each.value.scheduler_settings.max_instances
  delete_service_on_destroy = each.value.delete_service_on_destroy
  service_account_email     = each.value.service_account_email
  depends_on                = [module.service-account-iam, module.gcs-buckets]
}

##############################################################
#      			Firestore			     #
##############################################################

module "firestore" {
  source      = "./modules/firestore"
  for_each    = var.firestore
  project_id  = var.project_id
  collection  = each.value.collection
  document_id = each.value.document_id
  fields      = each.value.fields
  depends_on  = [module.enables-api]
}


##############################################################
#      			API Keys			     #
##############################################################

module "api_keys" {
  project_id       = var.project_id
  source           = "./modules/api-keys"
  for_each         = var.api_keys
  api_keys_name    = each.key
  api_display_name = each.value.api_display_name
  api_target_one   = each.value.api_target_one
  api_target_two   = each.value.api_target_two
}


##############################################################
#      			Secret Manager			     #
##############################################################

module "secret_manager_security" {
  source          = "./modules/secret-manager"
  for_each        = var.secret_datas
  project_id      = var.project_id
  secret_service  = var.secret_service
  secret_id       = each.key
  secret_location = each.value.secret_location
  secret_role     = each.value.secret_role
  secret_member   = each.value.secret_member
  secret_data     = each.value.secret_data #{ v1 = "${module.api_keys["api-keys-01"].api_key_string}" }use this to store api keys in secret manager
  depends_on      = [module.api_keys, module.enables-api, module.service-account-iam]
}


##############################################################
#      Global load balancer with backend bucket		     #
##############################################################

module "https-bucket-backend" {
  source                      = "./modules/global-lb-backend-buc"
  for_each                    = var.glb_backend_buc
  static_project_id           = var.project_id
  global_address              = each.value.global_address
  ip_version                  = var.ip_version
  project_id                  = var.project_id
  dns_authname                = each.value.dns_authname
  dns_description             = each.value.dns_description
  domain                      = each.value.domain
  certificate_manager         = each.value.certificate_manager
  certificate_map             = each.value.certificate_map
  map_entry                   = each.value.map_entry
  host_name                   = each.value.host_name
  global_forwarding_rule_name = each.value.global_forwarding_rule_name
  forwarding_ip_protocol      = each.value.forwarding_ip_protocol
  lb_balancing_scheme         = var.lb_balancing_scheme
  port_range                  = each.value.port_range
  target_proxy_name           = each.value.target_proxy_name
  url_map_name                = each.value.url_map_name
  backend_name                = each.value.backend_name
  enable_cdn                  = each.value.enable_cdn
  cache_mode                  = each.value.cache_mode
  client_ttl                  = each.value.client_ttl
  default_ttl                 = each.value.default_ttl
  max_ttl                     = each.value.max_ttl
  negative_caching            = each.value.negative_caching
  serve_while_stale           = each.value.serve_while_stale
  name                        = each.value.gcs_bucket_name
  location                    = each.value.location
  versioning                  = each.value.versioning
  iam                         = each.value.iam
  storage_class               = each.value.storage_class
  depends_on                  = [module.enables-api, module.service-account-iam]
}

##############################################################
#      		Static website with NEG as Backend	     #
##############################################################

module "static-website-neg" {
  source                      = "./modules/static_website"
  for_each                    = var.neg_forwarding_rule_name
  global_forwarding_rule_name = each.key
  project_id                  = var.project_id
  dns_managed_zone_name       = each.value.dns_managed_zone_name
  dns_name                    = each.value.dns_name
  record_type                 = each.value.record_type
  ttl                         = each.value.ttl
  rrdatas                     = each.value.rrdatas
  dns_authname                = each.value.dns_authname
  dns_description             = each.value.dns_description
  domain                      = each.value.domain
  ssl_certificate_name        = each.value.ssl_certificate_name
  ssl_domain_name             = each.value.ssl_domain_name
  global_address              = each.value.global_address
  forwarding_ip_protocol      = each.value.forwarding_ip_protocol
  lb_balancing_scheme         = each.value.lb_balancing_scheme
  port_range                  = each.value.port_range
  target_proxy_name           = each.value.target_proxy_name
  url_map_name                = each.value.url_map_name
  backend_service             = each.value.backend_service
  backend_protocol            = each.value.backend_protocol
  enable_cdn                  = each.value.enable_cdn
  backend_balancing_scheme    = each.value.backend_balancing_scheme
  balancing_mode              = each.value.backend_balancing_mode
  neg_name                    = each.value.neg_name
  endpoint_type               = each.value.endpoint_type
  region                      = each.value.region
  app_service                 = each.value.app_service
  app_version_id              = each.value.app_version_id
  appid                       = each.value.appid
  certificate_map             = each.value.certificate_map
  map_entry                   = each.value.map_entry
  matcher                     = each.value.matcher
  ip_version                  = each.value.ip_version
  depends_on                  = [module.app_versions, module.enables-api]
}

