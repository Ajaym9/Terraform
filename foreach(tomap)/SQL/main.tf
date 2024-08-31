/*resource "google_sql_database_instance" "main" {
  name             = "main-instance"
  project = "target-11695"
  instance_type    =  "CLOUD_SQL_INSTANCE"
  database_version = "POSTGRES_15"
  region           = "us-central1"
  root_password     = "ajay-cap"


  settings {
    tier = "db-f1-micro"
    edition = "ENTERPRISE"
    availability_type = "REGIONAL"
    disk_type = "PD_SSD"

     backup_configuration {
      enabled = true
      binary_log_enabled = true
     point_in_time_recovery_enabled = true
     start_time = "11:00"
     location = "us-central1"

    }
  }
}*/


resource "google_sql_database_instance" "main1" {
  for_each         = tomap(var.sql-instance)
  name             = each.key
  project          = each.value.project_id
  instance_type    = each.value.instance_type
  database_version = each.value.database_version
  region           = each.value.region
  deletion_protection=false
  settings {
    tier              = each.value.tier
    edition           = each.value.edition
    availability_type = each.value.availability_type
    disk_type         = each.value.disk_type
    backup_configuration {
      enabled                        = each.value.enabled
      binary_log_enabled             = each.value.binary_log_enabled
      point_in_time_recovery_enabled = each.value.point_in_time_recovery_enabled
      start_time                     = each.value.start_time
      location                       = each.value.location
    }
  }
}

