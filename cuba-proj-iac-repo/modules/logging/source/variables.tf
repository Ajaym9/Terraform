####################var.tf#################################
 
variable "name" {
  description = "name of sink"
  type        = string
}

variable "description" {
  description = "name of description"
  type        = string
}


variable "unique_writer_identity" {
  description = "ide"
  type        = bool
}

variable "project" {
  description = "id of the project"
  type        = string
}
/*
variable "include_children" {
  description = "includechildren"
  type        = bool
}*/

variable "destination" {
  description = "destination of sink"
  type        = string
}




variable "role" {
  description = "role forpubsub"
  type        = string
}



