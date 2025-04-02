resource "google_monitoring_alert_policy" "alert_policy" {
  display_name = var.display_name
  project      = var.project
  combiner     = "OR"

  notification_channels = var.notification_channel_ids

  dynamic "conditions" {
    for_each = var.conditions
    content {
      display_name = conditions.value.display_name
      condition_threshold {
        filter          = conditions.value.filter
        comparison      = conditions.value.comparison
        threshold_value = conditions.value.threshold_value

        aggregations {
          alignment_period   = "300s"
          per_series_aligner = "ALIGN_RATE"
        }

        duration = "60s"
      }
    }
  }
}


