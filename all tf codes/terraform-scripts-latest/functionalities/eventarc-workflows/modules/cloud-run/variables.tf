variable "run_name" {
 type = string
 description = "cloud run name"
}

variable "run_location" {
 type = string
 description = "cloud run location"
}

variable "project_id" {
 type = string
 description = "project_id"
}

variable "run_container_image" {
 type = string
 description = "cloud run container image"
}

variable "run_percent" {
 type = number
 description = "cloud run traffic percent"
}

variable "run_revision" {
 type = bool
 description = "cloud run latest revision"
}

variable "run_roles" {
 type = list(string)
 description = "cloud run roles"
}

variable "run_member" {
 type = string
 description = "cloud run member"
}


