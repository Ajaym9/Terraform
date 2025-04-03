#######################################################################
#               Create a API and API Gateways                         #
#######################################################################

resource "google_api_gateway_api" "api_gw" {
  provider = google-beta
  project  = var.project_id
  api_id   = var.api_id
}


resource "google_api_gateway_api_config" "api_gw" {
  provider = google-beta
  api           = google_api_gateway_api.api_gw.api_id
  api_config_id = var.config_id             
  project       = var.project_id
  openapi_documents {
    document {
      path     = var.path
      contents = filebase64(var.contents)
    }
  }
  lifecycle {
    create_before_destroy = false
  }
}


resource "google_api_gateway_gateway" "api_gw" {

  provider   = google-beta
  project    = var.project_id
  region     = var.region
  api_config = google_api_gateway_api_config.api_gw.id
  gateway_id = var.gateway_id 
}
