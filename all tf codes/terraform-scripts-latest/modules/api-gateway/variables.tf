variable "project_id" {
  type        = string
  description = "project id"
}

variable "api_id" {
  type        = string
  description = "api id"
}

variable "config_id" {
  type        = string
  description = "config id"
  default     = null
}

variable "path" {
  type        = string
  description = "document path"
  default     = ""
}

variable "contents" {
  type        = string
  description = "document contents"
  default     = null
}

variable "region" {
  type        = string
  description = "Gateway region"
  default     = null
}

variable "gateway_id" {
  type        = string
  description = "Gateway id"
  default     = null
}