variable "project_id" {
  type        = string
  description = "Project Id"
}

variable "source_path" {
  type        = string
  description = "Source path of function code"
}


variable "function_source_bucket" {
 type = string
 description = "gcs bucket name"
}

variable "bucket_location" {
 type = string
 description = "gcs bucket location"
}

variable "object_name" {
 type = string
 description = "object_name"
}


variable "function_name" {
  description = "cloud function name"
  type        = string
}

variable "function_description" {
  description = "cloud function description"
  type        = string
}

variable "function_location" {
 type = string
 description = "function location"
}

variable "runtime" {
  description = "runtime environment"
  type        = string
}

variable "entry_point" {
  description = "entry point"
  type        = string
}

variable "instance_count" {
 type = number
 description = "instance count"
}


variable "available_memory" {
 type = string
 description = "available memory"
}


variable "timeout_seconds" {
 type = number
 description = "timeout seconds"
}

variable "function_roles" {
 type = list(string)
 description = "function iam roles"
}


variable "member" {
 type = string
 description = "iam members"
}



