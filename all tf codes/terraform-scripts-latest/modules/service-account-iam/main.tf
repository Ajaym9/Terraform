#######################################################################
#       create service account with roles                             #
#######################################################################


resource "google_service_account" "custom_service_account" {
  account_id   = var.service_account_id
  display_name = var.account_display_name
  project      = var.project_id
}

resource "google_project_iam_member" "gae_api" {
  for_each = toset(var.roles)
  project  = var.project_id
  role     = each.value
  member   = "serviceAccount:${google_service_account.custom_service_account.email}"
}
