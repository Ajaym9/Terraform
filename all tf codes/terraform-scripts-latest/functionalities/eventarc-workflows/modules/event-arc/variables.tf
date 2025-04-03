variable "project_id" {
 type = string 
 description = "project id"
}

variable "eventarc_sa" {
 type = string
 description = "event arc service account"
}

variable "eventarc_sa_display" {
 type = string
 description = "event arc sa display name"
}

variable "pubsub_topic" {
 type = string
}

variable "eventarc_roles" {
 type = list(string)
 description = "event arc and workflow roles"
}

variable "eventarc_name" {
 type = string 
 description = "eventarc name"
}

variable "eventarc_region" {
 type = string 
 description = "eventarc_region"
}

variable "eventarc_attribute" {
 type = string 
 description = "eventarc_attribute"
}

variable "eventarc_value" {
 type = string 
 description = "eventarc_value"
}

variable "workflow_name" {
 type = string 
 description = "workflow_name"
}

variable "workflow_region" {
 type = string 
 description = "workflow_region"
}

variable "workflow_description" {
 type = string 
 description = "workflow_description"
}

variable "source_contents" {
 type = string 
 description = "source_contents"
}


