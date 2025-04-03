variable "project_id" {
 type = string 
 description = "project id"
}

variable "service_account_id" {
 type = string 
 description = "gke service account id"
 default     = null
}

variable "account_display_name" {
 type = string 
 description = "account display name"
 default     = null
}

variable "roles" {
 type = list(string) 
 description = "kubernetes roles"
}
