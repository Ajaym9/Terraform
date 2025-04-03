###############################################################
#              enables apis                                   #
###############################################################

service_api = ["container.googleapis.com"]

#############################################################
#    create service account iam and role binding            #
#############################################################

service_account_id = {
  "sa-scheduler" = {
    account_display_name = "sa-scheduler"
    roles                = ["roles/cloudscheduler.admin", "roles/cloudfunctions.invoker"]
  }
}

###########################################################
#       Creation of source code buckets                   #
###########################################################

buckets = {
  "buc-std-http-us-02" = {
    gcs_location = "US"
  }
}

############################################################
#          Http trigger functions                          #
############################################################

http_functions = {
  "func-http-01" = {
    runtime               = "java17"
    function_name         = "func-http-01"
    function_des          = "source-java-function"
    source_path           = "./func-http-trigger-code/java-source/"
    gcp_region            = "us-east1"
    entry_point           = "functions.helloone"
    cloud_scheduler       = "scheduler-func-trigger-one"
    scheduler_description = "scheduler triggering a cloud function"
    schedule              = "*/10 * * * *"
    time_zone             = "Asia/Calcutta"
    deadline              = "320s"
    http_method           = "GET"
  }

  "func-http-02" = {
    runtime               = "java17"
    function_name         = "func-http-02"
    function_des          = "source-java-test-function"
    source_path           = "./func-http-trigger-code/java-source-two/"
    gcp_region            = "us-central1"
    entry_point           = "functions.helloone"
    cloud_scheduler       = "scheduler-func-trigger-two"
    scheduler_description = "scheduler triggering a cloud function"
    schedule              = "*/10 * * * *"
    time_zone             = "Asia/Calcutta"
    deadline              = "320s"
    http_method           = "GET"

  }
}

memory             = 128
trigger_http       = true
cloud_func_role    = "roles/cloudfunctions.invoker"
cloud_func_member  = ["allUsers"]
