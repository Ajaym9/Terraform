resource "google_monitoring_alert_policy" "alert_policy" {
  notification_channels  = var.notification_channel
  display_name          = var.alertname
  combiner              = var.combiner
  project               = var.project_id
  conditions {
    display_name = var.condition_name
    dynamic "condition_threshold" {
      for_each = var.condition_threshold == null ? [] : [var.condition_threshold]
      content {
        filter          = var.condition_threshold.filter
        duration        = var.condition_threshold.duration
        threshold_value = var.condition_threshold.threshold
        comparison      = var.condition_threshold.comparison
        aggregations {
          alignment_period     = var.condition_threshold.alignment_period
          per_series_aligner   = var.condition_threshold.per_series_aligner
        }
      }
    }
  }
}


