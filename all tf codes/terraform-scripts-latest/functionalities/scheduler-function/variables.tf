variable "project_id" {
  type        = string
  description = "project id"
}

###############################################################
#              enables apis                                   #
###############################################################

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

###########################################################
#       Creation of source code buckets                   #
###########################################################

variable "buckets" {
  description = "gcs bucket name"
  type = map(object({
    gcs_location = string
  }))
}

############################################################
#          Http trigger functions                          #
############################################################

variable "http_functions" {
  description = "creates functions based on runtime"
  type = map(object({
    runtime               = string
    function_name         = string
    function_des          = string
    source_path           = string
    entry_point           = string
    gcp_region            = string
    cloud_scheduler       = string
    scheduler_description = string
    schedule              = string
    time_zone             = string
    deadline              = string
    http_method           = string
  }))
}

variable "memory" {
  description = "available memory in mb"
  type        = number
}

variable "trigger_http" {
  description = "http trigger"
  type        = bool
}

variable "cloud_func_role" {
  type        = string
  description = "Cloud function role"
}

variable "cloud_func_member" {
  type        = list(string)
  description = "cloud function member"
}

