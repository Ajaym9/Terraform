resource "google_monitoring_alert_policy" "alert_policy" {
  notification_channels  = var.channel
  display_name          = var.alertname
  combiner              = var.combiner
  project               = var.project_id
  documentation {
       content = var.documentation
  }
  alert_strategy {
    auto_close  = var.auto_close
  }
  conditions {
    display_name = var.condition_name
  condition_monitoring_query_language {
  query =var.query
  duration=var.duration
trigger {
  count = var.trigger_count
    }
}
}
}
