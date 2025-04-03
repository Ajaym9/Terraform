variable "project_id" {
  type        = string
  description = "project id"
}

variable "app_versions" {
  type        = string
  description = "version_id"
}

variable "service" {
  type        = string
  description = "AppEngine service resource"
}

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

variable "expiration" {
 type = string
}

variable "require_matching_file" {
 type = bool
}

variable "script_path" {
 type = string
}

variable "index_path" {
 type = string
}

variable "upload_index_path" {
 type = string
}

variable "runtime" {
  type        = string
  description = "runtime"
}

variable "entrypoint_shell" {
  type        = string
  description = "entrypoint"
}

variable "source_url" {
  type        = string
  description = "source_url"
}

variable "env_variables" {
  type        = map(string)
  description = "env variables"
}

variable "max_concurrent_requests" {
  type        = number
  description = "max_concurrent_requests"
}

variable "min_idle_instances" {
  type        = number
  description = "min_idle_instances"
}

variable "max_idle_instances" {
  type        = number
  description = "max_idle_instances"
}

variable "min_pending_latency" {
  type        = string
  description = "min_pending_latency"
}

variable "max_pending_latency" {
  type        = string
  description = "entrypoint"
}

variable "cpu_utilization" {
  type        = number
  description = "cpu_utilization"
}

variable "throughput_utilization" {
  type        = number
  description = "throughput_utilization"
}

variable "min_instances" {
  type        = number
  description = "min_instances"
}

variable "max_instances" {
  type        = number
  description = "max_instances"
}

variable "delete_service_on_destroy" {
  type        = bool
  description = "delete_service_on_destroy"
  default     = false
}

variable "noop_on_destroy" {
  type        = bool
  description = "noop_on_destroy"
  default     = true
}

variable "service_account_email" {
  type        = string
  description = "service account email"
}







