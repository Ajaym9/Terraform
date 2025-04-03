data "google_project" "current_project" {
  project_id = "kits-competency-343612" #"plywksdl-polyworks-datalp-d-1"
}

module "alert_policy" {
  source                =  "./modules/alert-policies"
  display_name          = var.display_name                                  
  project_id              = data.google_project.current_project.project_id                                                       
  notification_channels = google_monitoring_notification_channel.basic.*.id
  combiner              = var.combiner                                              
  conditions {
    display_name = var.condition_name                                                
    condition_threshold {
      #filter  = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\""
      filter  =   var.filter
      duration        = var.duration                 
      threshold_value =  var. threshold_value                     
      comparison = var.comparison                          
      aggregations {
        alignment_period   =  var.alignment_period                                
        per_series_aligner = var. per_series_aligner                                       
      }
    }
  }
}

/////////////////////////// creating notification channel//////////////////////////////

module "notification-channel" {
  source      ="./modules/notification"
  display_name = var.notification_channel_name                 
  project_id      = data.google_project.current_project.project_id                            
   type         = "email"
  labels = {
    email_address = var.email_address                                    
    #number    =  var.number                                            
  }

}
