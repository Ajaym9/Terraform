variable "project_id" {
  type        = string
  description = "project_id"
}

###################################################
#              Enable apis		          #
###################################################

variable "service_api" {
  type        = list(string)
  description = "apis"
}

#############################################################
#    create service account iam and role binding            #
#############################################################

variable "service_account_id" {
  description = "service account id"
  type = map(object({
    account_display_name = string
    roles                = list(string)
  }))
}

###################################################
#              Cloud run		          #
###################################################

variable "cloud_run" {
  type = map(object({
    run_location        = string
    run_container_image = string
    run_percent         = number
    run_revision        = bool
  }))
}

variable "run_roles" {
  type        = list(string)
  description = "cloud run roles"
}

variable "run_member" {
  type        = string
  description = "cloud run member"
}

###################################################
#              Kubernetes		          #
###################################################

variable "clusters" {
  description = "gke containers"
  type = map(object({
    cluster_location   = string
    default_node_pool  = bool
    initial_node_count = number
    pool_name          = string
    pool_location      = string
    node_count         = number
    preemptible_config = string
    machine_type       = string
  }))
}

variable "gke_sa_email" {
  type        = string
  description = "sa email"
}

variable "gke_scopes" {
  type        = list(string)
  description = "oauth scopes"
}

###################################################
#              Function generation2		  #
###################################################

variable "cloud_functions_gentwo" {
  type = map(object({
    source_path            = string
    function_source_bucket = string
    bucket_location        = string
    object_name            = string
    function_location      = string
    function_description   = string
    runtime                = string
    entry_point            = string
    instance_count         = number
    available_memory       = string
    timeout_seconds        = number
  }))
}

variable "function_roles_gentwo" {
  type        = list(string)
  description = "function generation two iam roles"
}


variable "function_member_gentwo" {
  type        = string
  description = "function generation two iam members"
}


###################################################
#          pubsub topics & Subscription	          #
###################################################

variable "pubsub_topics" {
  description = "pubsub topic"
  type = map(object({
    topic_labels = map(string)
  }))
}

variable "topic_message_retention" {
  description = "pubsub topic message retention duration"
  type        = string
}


variable "pubsub_subscriptions" {
  description = "Topic subscriptions. Also define push configs for push subscriptions. If options is set to null subscription defaults will be used. Labels default to topic labels if set to null."
  type = map(object({
    topic  = string
    labels = map(string)
    options = object({
      ack_deadline_seconds         = number
      message_retention_duration   = string
      retain_acked_messages        = bool
      expiration_policy_ttl        = string
      enable_message_ordering      = bool
      enable_exactly_once_delivery = bool
    })
  }))
  default = {}
}

variable "minimum_backoff" {
  description = "The minimum delay between consecutive deliveries of a given message."
  type        = string
}

variable "maximum_backoff" {
  description = "The maximum delay between consecutive deliveries of a given message."
  type        = string
}


###########################################################
#       	GCS BUCKETS	                          #
###########################################################

variable "gcs_buckets" {
  description = "gcs buckets"
  type = map(object({
    gcs_location = string
  }))
}

############################################################
#           HTTP trigger Cloud functions-v1                #
############################################################

variable "functions_genone" {
  description = "source function"
  type = map(object({
    function_des = string
    source_path  = string
    runtime      = string
    memory       = number
    trigger_http = bool
    entry_point  = string
    gcp_region   = string
  }))
}

variable "cloud_func_role_http" {
  type        = string
  description = "Cloud function role"
}

variable "cloud_func_member_http" {
  type        = string
  description = "cloud function member"
}


##############################################################
#             GCS Event trigger Cloud functions-v1           #
##############################################################

variable "event_functions" {
  description = "creates functions based on runtime"
  type = map(object({
    source_path    = string
    trigger_bucket = string
    function_name  = string
    function_des   = string
    runtime        = string
    memory         = string
    event_type     = string
    event_resource = string
    entry_point    = string
    gcp_region     = string
  }))
}

variable "cloud_func_role_event" {
  type        = string
  description = "Cloud function role"
}

variable "cloud_func_member_event" {
  type        = list(string)
  description = "cloud function member"
}

##############################################################
#             	Snapshot disk policy                         #
##############################################################

variable "snapshot_policy_region" {
  type        = string
  description = "snapshot policy region"
}

variable "snapshots_creation" {
  type = map(object({
    disk_name = string
    disk_zone = string
  }))
}

variable "policy_days" {
  type        = number
  description = "policy days in cycle"
}

variable "start_time" {
  type        = string
  description = "disk_name"
}

/*

variable "day_of_snapshot" {
  type        = string
  description = "day on which snapshot will be taken"
}

variable "max_retention_days" {
  type        = number
  description = "number of days for which the snapshot is retained after creation"
}

*/

##############################################################
#          Network load balancer with GCE as backend         #
##############################################################

variable "compute_instances" {
  type = map(object({
    machine_type = string
    zone         = string
    image        = string
    vpc_network  = string
  }))
}

variable "network_load_balancer" {
  description = "Network load balancer"
  type = map(object({
    region                = string
    dns_managed_zone_name = string
    dns_name              = string
    lbscheme              = string
    ip_protocol           = string
    ports                 = string
    target_pool           = string
  }))
}

##############################################################
#      Monitoring - notification channels                    #
##############################################################

variable "notification_channel" {
  type = map(object({
    notification_type = string
    labels            = map(string)
  }))
}


##############################################################
#      			API Gateways			     #
##############################################################

variable "api_gateways" {
  description = "API  IDs"
  type = map(object({
    config_id  = string
    path       = string
    contents   = string
    region     = string
    gateway_id = string
  }))
}

##############################################################
#      			App Engine			     #
##############################################################

variable "auth_fail_action" {
  type = string
}

variable "login" {
  type = string
}

variable "security_level" {
  type = string
}

variable "application_readable" {
  type = string
}

variable "index_path" {
  type = string
}

variable "upload_index_path" {
  type = string
}


variable "expiration" {
  type = string
}

variable "require_matching_file" {
  type = bool
}

variable "script_path" {
  type = string
}


variable "app_engine_services" {
  type = map(object({
    app_versions  = string
    service       = string
    runtime       = string
    entrypoint    = string
    source_url    = string
    env_variables = map(string)
    automatic_scaling = object({
      max_concurrent_requests = string
      min_idle_instances      = string
      max_idle_instances      = string
      min_pending_latency     = string
      max_pending_latency     = string
    })
    scheduler_settings = object({
      target_cpu_utilization        = string
      target_throughput_utilization = string
      min_instances                 = string
      max_instances                 = string
    })
    delete_service_on_destroy = string
    service_account_email     = string
  }))
}

##############################################################
#      			Firestore			     #
##############################################################

variable "firestore" {
  type = map(object({
    collection  = string
    document_id = string
    fields      = string
  }))
}

##############################################################
#      			API Keys			     #
##############################################################

variable "api_keys" {
  type = map(object({
    api_display_name = string
    api_target_one   = string
    api_target_two   = string
  }))
}

##############################################################
#      			Secret Manager			     #
##############################################################

variable "secret_service" {
  type        = string
  description = "secret manager API"
}

variable "secret_datas" {
  type = map(object({
    secret_location = string
    secret_role     = string
    secret_member   = string
    secret_data     = map(string)
  }))
}


##############################################################
#      Global load balancer with backend bucket		     #
##############################################################

variable "lb_balancing_scheme" {
  type = string
}

variable "ip_version" {
  type = string
}

variable "glb_backend_buc" {
  description = "global load balancer with backend bucket"
  type = map(object({
    global_address              = string
    dns_authname                = string
    dns_description             = string
    domain                      = string
    certificate_manager         = string
    certificate_map             = string
    map_entry                   = string
    host_name                   = string
    global_forwarding_rule_name = string
    forwarding_ip_protocol      = string
    port_range                  = string
    target_proxy_name           = string
    url_map_name                = string
    backend_name                = string
    enable_cdn                  = bool
    cache_mode                  = string
    client_ttl                  = number
    default_ttl                 = number
    max_ttl                     = number
    negative_caching            = bool
    storage_class               = string
    serve_while_stale           = number
    gcs_bucket_name             = string
    location                    = string
    versioning                  = bool
    iam                         = map(string)
  }))
}

##############################################################
#      		Static website with NEG as Backend	     #
##############################################################

variable "neg_forwarding_rule_name" {
  type = map(object({
    dns_managed_zone_name    = string
    dns_name                 = string
    record_type              = string
    ttl                      = number
    rrdatas                  = list(string)
    dns_authname             = string
    dns_description          = string
    domain                   = string
    ssl_certificate_name     = string
    ssl_domain_name          = list(string)
    global_address           = string
    forwarding_ip_protocol   = string
    port_range               = number
    ip_version               = string
    lb_balancing_scheme      = string
    backend_balancing_scheme = string
    backend_balancing_mode   = string
    target_proxy_name        = string
    enable_cdn               = bool
    url_map_name             = string
    backend_service          = string
    backend_protocol         = string
    neg_name                 = string
    endpoint_type            = string
    region                   = string
    app_service              = string
    app_version_id           = string
    appid                    = string
    certificate_map          = string
    map_entry                = string
    matcher                  = string
  }))
}


