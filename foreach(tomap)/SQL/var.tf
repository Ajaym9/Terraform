variable "sql-instance" {
  type = map(object({
    instance_type                  = string
    project_id                     = string
    database_version               = string
    region                         = string
    tier                           = string
    edition                        = string
    availability_type              = string
    disk_type                      = string
    enabled                        = bool
    binary_log_enabled             = bool
    point_in_time_recovery_enabled = bool
    start_time                     = string
    location                       = string

  }))
}

