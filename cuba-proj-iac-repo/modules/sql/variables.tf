variable "instance_name" {
    type = string
}
variable "database_version" {
    type = string
}
variable "region" {
    type = string
}
variable "tier" {
    type = string
}
variable "availability_type" {
    type = string
}
variable "disk_size" { 
    type = string
    }
variable "enable_backup" {
    type = string
}
variable "backup_start_time" {
    type = string
}
variable "deletion_protection" {
    type = string
}
variable "vpc_network" {
    type = string
}
variable "database_users" {
  type = list(object({
    name     = string
    password = string
  }))
}
