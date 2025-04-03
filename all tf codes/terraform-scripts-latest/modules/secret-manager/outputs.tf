output "secret_version_data" {
value =google_secret_manager_secret_version.secret_data[*]
sensitive = true
}
