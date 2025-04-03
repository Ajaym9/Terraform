
######################alert_policy###########################
resource "google_monitoring_alert_policy" "alert_policy" {
  display_name          = var.display_name                                  
  project               =   var.project                                                              
  notification_channels = google_monitoring_notification_channel.basic.*.id
  combiner              = var.combiner                                              
  conditions {
    display_name = var.condition_name                                                
    condition_threshold {
      #filter  = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\""
      filter  =   var.filter
      duration        = var.duration                 
      threshold_value =  var.threshold_value                     
      comparison = var.comparison                          
      aggregations {
        alignment_period   =  var.alignment_period                                
        per_series_aligner = var. per_series_aligner                                       
      }
    }
  }
}
