#######################################################################
#            create Service account with required permissions         #
#######################################################################
resource "google_service_account" "eventarc_workflows_service_account" {
  account_id   = var.eventarc_sa	
  display_name = var.eventarc_sa_display	
}

resource "google_project_iam_member" "project_binding_eventarc" {
  for_each = toset(var.eventarc_roles)
  project = var.project_id
  role    = each.value		
  member = "serviceAccount:${google_service_account.eventarc_workflows_service_account.account_id}@${var.project_id}.iam.gserviceaccount.com"
  depends_on = [google_service_account.eventarc_workflows_service_account]

}

#######################################################################
#               create event arc trigger                              #
#######################################################################

resource "google_eventarc_trigger" "primary" {
    name = var.eventarc_name
 project = var.project_id
 service_account = google_service_account.eventarc_workflows_service_account.id
 transport {
        pubsub {
            topic        = var.pubsub_topic
        }
    }     
location = var.eventarc_region
    matching_criteria {
        attribute = var.eventarc_attribute	
        value = var.eventarc_value	
    }
    destination {
        workflow = google_workflows_workflow.default.id
    }
}

#######################################################################
#                create workflow                                      #
#######################################################################

resource "google_workflows_workflow" "default" {
  name          = var.workflow_name 	
 project = var.project_id
  region        = var.workflow_region	
 service_account = google_service_account.eventarc_workflows_service_account.id
  description   = var.workflow_description
  source_contents  = templatefile("${var.source_contents}", {})	#templatefile("${path.module}/${var.source_contents}",{}) 	
}

