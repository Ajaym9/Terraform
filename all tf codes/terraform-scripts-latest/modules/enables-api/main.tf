#######################################################################
#     Enable apis required to create and manage resources             #
#######################################################################

resource "google_project_service" "enable_apis" {
  for_each = toset(var.service_api)
  project  = var.project_id
  service  = each.value
}
