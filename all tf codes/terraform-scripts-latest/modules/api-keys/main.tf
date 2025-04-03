resource "google_apikeys_key" "maps" {
name         = var.api_keys_name        
  display_name = var.api_display_name        
  project	= var.project_id
  
restrictions {
        api_targets {
            service = var.api_target_one
        }
        api_targets {
            service = var.api_target_two
        }

}
}
