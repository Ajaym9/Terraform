project_id = ""

###################################################
#              Enable apis		          #
###################################################

service_api = ["container.googleapis.com"]


#############################################################
#    create service account iam and role binding            #
#############################################################

service_account_id = {
  "sa-test" = {
    account_display_name = "sa-test"
    roles                = ["roles/container.admin", "roles/iam.serviceAccountUser"]
  }
}
###################################################
#              Cloud run		          #
###################################################


cloud_run = {
  "cloudrun-srv-01" = {
    run_location        = "us-central1"
    run_container_image = "gcr.io/<PROJECT-ID>/hello-test-1"
    run_percent         = 100
    run_revision        = true
  }
  "cloudrun-srv-02" = {
    run_location        = "us-central1"
    run_container_image = "gcr.io/<PROJECT-ID>/hello-test-2"
    run_percent         = 100
    run_revision        = true
  }

}

run_roles  = ["roles/run.admin"]
run_member = "allUsers"


###################################################
#              Kubernetes		          #
###################################################

clusters = {
  "test-gke-cluster-one" = {
    default_node_pool  = true
    cluster_location   = "us-central1"
    initial_node_count = 1
    pool_name          = "my-node-pool-n"
    pool_location      = "us-central1"
    node_count         = 1
    preemptible_config = true
    machine_type       = "e2-micro"
  }

  "test-gke-cluster-two" = {
    default_node_pool  = true
    cluster_location   = "us-central1"
    initial_node_count = 1
    pool_name          = "my-node-pool-n"
    pool_location      = "us-central1"
    node_count         = 1
    preemptible_config = true
    machine_type       = "e2-micro"
  }
}

gke_sa_email = "xxxxxxxx"
gke_scopes   = ["https://www.googleapis.com/auth/cloud-platform"]


###################################################
#              Function generation2		  #
###################################################

cloud_functions_gentwo = {
  "func-gen2-test" = {
    source_path            = "./source-codes/function-gen2/"
    function_source_bucket = "func2-source-bucket"
    bucket_location        = "us-central1"
    object_name            = "function-v2-source"
    function_location      = "us-central1"
    function_description   = "a gen 2 function"
    runtime                = "python38"
    entry_point            = "hello_http"
    instance_count         = 1
    available_memory       = "256M"
    timeout_seconds        = 60
  }
}


function_roles_gentwo  = ["roles/run.invoker"]
function_member_gentwo = "allUsers"


###################################################
#          pubsub topics & Subscription	          #
###################################################

pubsub_topics = {
  "pubsub-topic-01" = {
    topic_labels = { "dest" = "pubsub topic" }
  }
  "pubsub-topic-02" = {
    topic_labels = { "dest" = "pubsub topic" }
  }
}

topic_message_retention = "604800s"
pubsub_subscriptions = {
  "test-sub-01" = {
    topic  = "projects/<PROJECTID>/topics/pubsub-topic-01"
    labels = {}
    options = {
      ack_deadline_seconds         = 10
      message_retention_duration   = "604800s"
      enable_message_ordering      = false
      expiration_policy_ttl        = "2678400s"
      retain_acked_messages        = false
      enable_exactly_once_delivery = true
    }
  }
  "test-sub-02" = {
    topic  = "projects/<PROJECTID>/topics/pubsub-topic-02"
    labels = {}
    options = {
      ack_deadline_seconds         = 10
      message_retention_duration   = "604800s"
      enable_message_ordering      = false
      expiration_policy_ttl        = "2678400s"
      retain_acked_messages        = false
      enable_exactly_once_delivery = true
    }
  }
}

minimum_backoff = "10s"
maximum_backoff = "600s"


###########################################################
#       	GCS BUCKETS	                          #
###########################################################

gcs_buckets = {
  "gcs-bucket-std-us-01" = {
    gcs_location = "US"
  }
  "gcs-bucket-std-us-02" = {
    gcs_location = "US"
  }
}

############################################################
#           HTTP trigger Cloud functions-v1                #
############################################################

functions_genone = {
  "func-genone-01" = {
    function_des = "source function"
    source_path  = "./source-codes/http-functions/source-code-01/"
    runtime      = "java17"
    memory       = 256
    trigger_http = true
    entry_point  = "functions.helloone"
    gcp_region   = "us-east1"
  }

  "func-genone-02" = {
    function_des = "source function"
    source_path  = "./source-codes/http-functions/source-code-02/"
    runtime      = "java17"
    memory       = 256
    trigger_http = true
    entry_point  = "functions.helloone"
    gcp_region   = "us-east1"
  }
}

cloud_func_role_http   = "roles/cloudfunctions.invoker"
cloud_func_member_http = "allUsers"


##############################################################
#             GCS Event trigger Cloud functions-v1           #
##############################################################

event_functions = {
  "func-event-01" = {
    source_path    = "./func-event-trigger/event-source-01/"
    trigger_bucket = "event-trigger-bucket-01"
    function_name  = "func-event-01"
    function_des   = "test event trigger function"
    runtime        = "python310"
    memory         = 256
    event_type     = "google.storage.object.finalize"
    event_resource = "projects/<PROJECTID>/buckets/event-trigger-bucket-01"
    entry_point    = "hello_gcs"
    gcp_region     = "us-east1"
  }

  "func-event-01" = {
    source_path    = "./func-event-trigger/event-source-02/"
    trigger_bucket = "event-trigger-bucket-02"
    function_name  = "func-event-02"
    function_des   = "test event trigger function"
    runtime        = "python310"
    memory         = 256
    function_name  = "func-event-02"
    function_des   = "test event trigger function"
    event_type     = "google.storage.object.finalize"
    event_resource = "projects/<PROJECTID>/buckets/event-trigger-bucket-02"
    entry_point    = "hello_gcs"
    gcp_region     = "us-central1"
  }
}

cloud_func_role_event   = "roles/cloudfunctions.invoker"
cloud_func_member_event = ["allUsers"]


##############################################################
#             	Snapshot disk policy                         #
##############################################################

snapshot_policy_region = "us-east4"

snapshots_creation = {
  "my-windows-snapshot-policy-01" = {
    disk_name = "windows-native-instance"
    disk_zone = "us-east4-a"
  }

  "my-windows-snapshot-policy-02" = {
    disk_name = "additional-disk"
    disk_zone = "us-east4-a"
  }
}

policy_days = 1
start_time  = "16:00"

/*
day_of_snapshot        = "SUNDAY"
max_retention_days     = 30
*/


##############################################################
#          Network load balancer with GCE as backend         #
##############################################################

compute_instances = {
  "instance-01" = {
    machine_type = "e2-medium"
    zone         = "us-central1-a"
    image        = "centos-7-v20230203"
    vpc_network  = "default"
  }
  "instance-02" = {
    machine_type = "e2-medium"
    zone         = "europe-west4-a"
    image        = "debian-cloud/debian-11"
    vpc_network  = "default"

  }
}

network_load_balancer = {
  "test-frontend-01" = {
    region                = "europe-west4"
    dns_managed_zone_name = "prod-ge-zone5"
    dns_name              = "test.com."
    lbscheme              = "EXTERNAL"
    ip_protocol           = "TCP"
    ports                 = "27000"
    target_pool           = "targetpool-01"
  }
  "test-frontend-02" = {
    region                = "europe-west4"
    dns_managed_zone_name = "prod-ge-zone6"
    dns_name              = "testone.com."
    lbscheme              = "EXTERNAL"
    ip_protocol           = "TCP"
    ports                 = "54085"
    target_pool           = "targetpool-02"

  }
}


##############################################################
#      Monitoring - notification channels                    #
##############################################################

notification_channel = {
  "email-01" = {
    notification_type = "email" #sample email service as notification channel
    labels            = { email_address = "test1@gmail.com" }
  }
  "email-02" = {
    notification_type = "email"
    labels            = { email_address = "test2@gmail.com" }
  }
  /*
 #samples for pubsub topic , webhook and sms 
  "sms-notification-channel" = {
    notification_type = "sms" 
    labels            = { number = "+917XXXXXXXXXX" }
  }
  "pubsub-notification-channel" = {
    notification_type = "pubsub" 
    labels            = { topic = "projects/<PROJECT-ID>/topics/test-topic" }
  }
 "webhook-notification-channel" = {
  notification_type 	= "webhook"
  labels	= { url = "https://test.com" }
 }
*/
}


##############################################################
#      			API Gateways			     #
##############################################################

api_gateways = {
  "api-01" = {
    config_id  = "api-config-01"
    path       = "./config-files/config-01.yaml"
    contents   = "./config-files/config-01.yaml"
    region     = "us-east1"
    gateway_id = "gateway-01"
  }

  "api-02" = {
    config_id  = "api-config-02"
    path       = "./config-files/config-02.yaml"
    contents   = "./config-files/config-02.yaml"
    region     = "us-east1"
    gateway_id = "gateway-02"
  }

}


##############################################################
#      			App Engine			     #
##############################################################

auth_fail_action      = "AUTH_FAIL_ACTION_REDIRECT"
login                 = "LOGIN_OPTIONAL"
security_level        = "SECURE_OPTIONAL"
application_readable  = false
expiration            = "0s"
require_matching_file = false
script_path           = "auto"
upload_index_path     = "" # file path
index_path            = "" # file name

app_engine_services = {
  "app-01" = {
    service      = "app-01"
    runtime      = "nodejs14"
    app_versions = "v1"
    entrypoint   = "node -v"
    source_url   = "" #provide the gcs bucket source url
    env_variables = {
      port = "443"
    }
    automatic_scaling = {
      max_concurrent_requests = 10
      min_idle_instances      = 1
      max_idle_instances      = 3
      min_pending_latency     = "1s"
      max_pending_latency     = "5s"
    }
    scheduler_settings = {
      target_cpu_utilization        = 0.5
      target_throughput_utilization = 0.75
      min_instances                 = 1
      max_instances                 = 1
    }
    delete_service_on_destroy = true
    service_account_email     = ""
  }
}

##############################################################
#      			Firestore			     #
##############################################################

firestore = {
  "firestore-collection-01" = {
    collection  = "newcollection"
    document_id = "my-doc"
    fields      = "{\"something\":{\"mapValue\":{\"fields\":{\"akey\":{\"stringValue\":\"avalue\"}}}}}"
  }
}


##############################################################
#      			API Keys			     #
##############################################################

api_keys = {
  "maps-api-key-01" = {
    api_display_name = "maps-api-key-test-ee"
    api_target_one   = "maps-backend.googleapis.com"
    api_target_two   = "places-backend.googleapis.com"
  }
}

##############################################################
#      			Secret Manager			     #
##############################################################

secret_service = "secretmanager.googleapis.com"

secret_datas = {
  "test-secret" = {
    secret_location = "europe-west2"
    secret_role     = "roles/secretmanager.secretAccessor"
    secret_data		= { v1 = "secrets"}
    secret_member   = "serviceAccount:xxxxxxx"
  }
}

##############################################################
#      Global load balancer with backend bucket		     #
##############################################################

ip_version          = "IPV4"
lb_balancing_scheme = "EXTERNAL_MANAGED"
glb_backend_buc = {
  "http-lb-gcs" = {
    global_address              = "global-ip-01"
    dns_authname                = "dns-auth-01"
    dns_description             = "dns auth"
    domain                      = "test1.com"
    certificate_manager         = "xlb7-certificate-test-cm-cert-01"
    certificate_map             = "xlb7-cert-map-01"
    map_entry                   = "xlb7-cert-map-entry-01"
    host_name                   = "test1.com"
    global_forwarding_rule_name = "forwardingrule-01"
    forwarding_ip_protocol      = "TCP"
    port_range                  = "443"
    target_proxy_name           = "targetproxy-01"
    url_map_name                = "llb-map-01"
    backend_name                = "backend-bucket2"
    enable_cdn                  = true
    cache_mode                  = "CACHE_ALL_STATIC"
    client_ttl                  = 3600
    default_ttl                 = 3600
    max_ttl                     = 86400
    negative_caching            = true
    serve_while_stale           = 86400
    storage_class               = "STANDARD"
    gcs_bucket_name             = "https-backend-bucket"
    location                    = "us-east1"
    versioning                  = true
    iam = {
      "roles/storage.objectViewer" = "serviceAccount:XXXXXXXXXXXXXX"
    }
  }
}




neg_forwarding_rule_name = {
  "global-rule" = {
    dns_managed_zone_name    = "prod-ge-zone1"
    dns_name                 = "test.com."
    record_type              = "A"
    ttl                      = 300
    rrdatas                  = [""]
    dns_authname             = "dns-auth1"
    lb_balancing_scheme      = "EXTERNAL_MANAGED"
    backend_balancing_scheme = "EXTERNAL_MANAGED"
    backend_balancing_mode   = "UTILIZATION"
    enable_cdn               = true
    ip_version               = "IPV4"
    dns_description          = "The default dns"
    domain                   = "test.com"
    port_range               = "443"
    ssl_certificate_name     = "ge-cert-01"
    ssl_domain_name          = ["test.com."]
    global_address           = "global-psconnect-ip"
    forwarding_ip_protocol   = "TCP"
    port_range               = "443"
    target_proxy_name        = "target-proxy-01"
    url_map_name             = "url-map-01"
    backend_service          = "backend-service-01"
    backend_protocol         = "HTTPS"
    neg_name                 = "neg-02"
    endpoint_type            = "SERVERLESS"
    region                   = "us-east4"
    app_service              = "app-01"
    app_version_id           = "v1"
    appid                    = "app-01"
    certificate_map          = "certificate-map-01"
    map_entry                = "certificate-map-entry-01"
    matcher                  = "PRIMARY"

  }
}

