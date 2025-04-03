variable "project_id" {
 type = string 
 description = "project id"
}

variable "snapshot_policy_name" {
 type = string 
 description = "snapshot policy name "
}

variable "snapshot_policy_region" {
 type = string 
 description = "snapshot policy region"
}

variable "policy_days" {
 type = number
 description = "policy days in cycle"
}

variable "disk_name" {
 type = string 
 description = "disk name"
}

variable "start_time" {
 type = string 
 description = "disk_name"
}


variable "disk_zone" {
 type = string 
 description = "disk zone"
}


/*
variable "day_of_snapshot" {
  type        = string
  description = "day on which snapshot will be taken"
}

variable "max_retention_days" {
  type        = number
  description = "number of days for which the snapshot is retained after creation"
}
*/
