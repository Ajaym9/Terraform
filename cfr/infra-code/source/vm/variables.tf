variable "vm_name" {
  type = string
}

variable "machine_type" {
  type = string
}

variable "zone" {
  type = string
}

variable "image" {
  type = string
}

variable "disk_size" {
  type = string
}

variable "network" {
  type = string
}

variable "subnetwork" {
  type = string
}

variable "sa-email" {
  type = string
}

variable "project_id" {
  type = string
}

variable "tags" {
  type = list(string)
}
