data "google_projects" "cfrproject" {
  # Specify your organization ID
  filter = "parent.type:folder lifecycleState:ACTIVE"
}
output "project_id" {
value = local.project_ids
}
 
locals{
project_ids = {
      for proj in data.google_projects.cfrproject.projects : proj.name => proj.project_id
     }
}

#module block for adding projects under scoping project
module "monitoringscope" {
source = "./source/monitoring/scope"
for_each = toset([for k, v in local.project_ids :v if k != "cfr-org-monitoring-project"])
monitored_projects = each.value
scoping-project = local.project_ids["cfr-org-monitoring-project"]
}

#module block for creating dashboards
module "dashboards" {
  source = "./source/monitoring/dashboards"
  project_id     = var.monitoring_project_id
  for_each = toset(var.dashboard_file_name)
  dashboard_json = file("${each.value}")
}

#module block for creating alerts
module "alerting" {
  source         = "./source/monitoring/alerts"
  channel        = [module.notification_channels["email1"].name]
  for_each       = var.details
  alertname      = each.value.display_name
  project_id     = var.monitoring_project_id
  documentation  = each.value.documentation
  auto_close     = each.value.auto_close
  combiner       = "OR"
  condition_name = each.value.condition_name
  condition_threshold = {
    filter               = each.value.filter
    duration             = each.value.duration
    threshold            = each.value.threshold
    comparison           = each.value.comparison
    alignment_period     = each.value.alignment_period
    aligner              = each.value.per_series_aligner
   # documentation        = each.value.documentation
    count = each.value.count
    cross_series_reducer = each.value.cross_series_reducer
 }
depends_on = [
  module.notification_channels
]
}

#module block for including of notification channel
module "notification_channels" {
  source                  = "./source/monitoring/notification_channel"
  project_id              = var.monitoring_project_id
  for_each = var.channel_details
  notificationdisplayname = each.value.notificationdisplayname
  email                   = each.value.email
}

#module block for creation of alerts with query
module "alerting1" {
  source         = "./source/monitoring/alerts_with_query"
  channel        = [module.notification_channels["email1"].name]
  for_each       = tomap(var.alert_details)
  project_id     = var.monitoring_project_id
  combiner       = "OR"
  alertname      = each.value.alert_name
  documentation  = each.value.documentation
  auto_close     = each.value.auto_close
  condition_name = each.value.condition_name
  query = each.value.query
  duration= each.value.duration
  trigger_count = each.value.count
}
