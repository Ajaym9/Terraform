variable "project_id" {
  type        = string
  description = "Project id"
}

variable "secret_service" {
  type        = string
  description = "secret manager API"
}

variable "secret_id" {
  type        = string
  description = "secret id"
}

variable "secret_location" {
  type        = string
  description = "secret manager location"
}

variable "secret_role" {
  type        = string
  description = "Secret manager permissions"
}

variable "secret_member" {
  type        = string
  description = "Service account for granting the required role"
}

variable "secret_data" {
  type        = map(any)
  description = "Secret data"
}
