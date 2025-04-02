resource "google_sql_database_instance" "default" {
  name             = var.instance_name
  database_version = var.database_version
  region           = var.region

  settings {
    tier                  = var.tier
    availability_type      = var.availability_type
    disk_size             = var.disk_size
    disk_autoresize       = true
    disk_type             = "PD_SSD"

    ip_configuration {
      ipv4_enabled                                  = false
      private_network                               = var.vpc_network
      enable_private_path_for_google_cloud_services = true
    }

    backup_configuration {
      enabled                        = var.enable_backup
      binary_log_enabled             = false
      start_time                     = var.backup_start_time
    }
  }

  deletion_protection = var.deletion_protection
}

resource "google_sql_user" "users" {
  for_each = { for user in var.database_users : user.name => user }

  instance = google_sql_database_instance.default.name
  name     = each.value.name
  password = each.value.password
}
