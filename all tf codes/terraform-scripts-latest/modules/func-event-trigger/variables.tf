variable "project_id" {
  type        = string
  description = "Project Id"
}

variable "source_path" {
  type        = string
  description = "Source path of function code"
}

variable "source_code_bucket" {
  description = "storage bucket"
  type        = string
}

variable "trigger_bucket" {
 type = string
 description = "event trigger source bucket"
}

variable "gcp_region" {
  description = "region"
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

variable "event_type" {
 type = string
 description = "Event type"
}

variable "event_resource" {
 type = string 
 description = "event resource. pattern is projects/{project}/buckets/{bucket}"
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
  description = "cloud function members"
}



