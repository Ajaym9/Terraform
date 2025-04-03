/////////////////////////// creating notification channel//////////////////////////////

resource "google_monitoring_notification_channel" "basic"{
  display_name = var.notification_channel_name                 
  project_id      = data.google_project.current_project.project_id                            
   type         = "email"
  labels = {
    email_address = var.email_address                                    
    #number    =  var.number                                            
  }

}
