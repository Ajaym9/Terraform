resource "google_monitoring_monitored_project" "projects_monitored" {
    name = var.monitored_projects
    metrics_scope = join("", ["locations/global/metricsScopes/", var.scoping-project]) 
}
