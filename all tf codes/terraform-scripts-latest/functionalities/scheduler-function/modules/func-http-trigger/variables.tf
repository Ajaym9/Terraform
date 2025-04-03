variable "project_id" {
  type        = string
  description = "Project Id"
}

variable "source_path" {
  type        = string
  description = "Source path of function code"
}

variable "gcs_bucket" {
  description = "storage bucket"
  type        = string
}



###########scheduler
variable "cloud_scheduler" {
  description = "cloud scheduler name"
  type        = string
}

variable "scheduler_description" {
  description = "cloud scheduler description"
  type        = string
}

variable "schedule" {
  description = "schedule time frequency"
  type        = string
}

variable "time_zone" {
  description = "time zone"
  type        = string
}

variable "deadline" {
  description = "attempt deadline"
  type        = string
}

variable "http_method" {
  description = "http method"
  type        = string
}

variable "gcp_region" {
  description = "region"
  type        = string
}

variable "service_account_email" {
  description = "SA email"
  type        = string
}

###########cloud functions
variable "function_name" {
  description = "cloud function name"
  type        = string
}

variable "function_des" {
  description = "cloud function description"
  type        = string
}

variable "runtime" {
  description = "runtime environment"
  type        = string
}

variable "memory" {
  description = "available memory in mb"
  type        = number
}

variable "trigger_http" {
  description = "http trigger"
  type        = bool
}

variable "entry_point" {
  description = "entry point"
  type        = string
}



variable "cloud_func_role" {
  type        = string
  description = "Cloud function role"
}

variable "cloud_func_member" {
  type        = list(string)
  description = "cloud function member"
}
