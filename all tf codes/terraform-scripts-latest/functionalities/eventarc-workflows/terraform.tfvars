project_id = "<project-id>"

##########enable apis

service_api = ["eventarc.googleapis.com", "pubsub.googleapis.com", "workflows.googleapis.com", "workflowexecutions.googleapis.com"]

############# storage bucket


gcs_bucket = {
  "buc-std-image-us-01" = {
    gcs_location  = "us-central1"
    storage_class = "STANDARD"
  }
}

############# cloud run 

cloud_run = {
  "cloudrun-srv-01" = {
    run_location        = "us-central1"
    run_container_image = "gcr.io/<PROJECT-ID>/<image-name>"
    run_percent         = 100
    run_revision        = true
  }
}

run_roles  = ["roles/run.admin"]
run_member = "allUsers"


############# storage notification

storage_notification = {
  "notification-01" = {
    pubsub_topic   = "projects/<PROJECT-ID>/topics/pub-notification-topic-01"
    bucket_name    = "buc-std-image-us-01"
    payload_format = "JSON_API_V1"
  }
}

############ pubsub topic and subscription

pubsub_topics = {
  "pub-notification-topic-01" = {
    topic_labels = { "dest" = "pubsub-topic" }
  }
  "pub-notification-topic-02" = {
    topic_labels = { "dest" = "pubsub-topic" }
  }
}

topic_message_retention = "604800s"

pubsub_subscriptions = {
  "pub-notification-sub-01" = {
    topic  = "projects/<PROJECT-ID>/topics/pub-notification-topic-01"
    labels = {}
    options = {
      ack_deadline_seconds         = 10
      message_retention_duration   = "604800s"
      enable_message_ordering      = false
      expiration_policy_ttl        = "2678400s"
      retain_acked_messages        = false
      enable_exactly_once_delivery = true
    }
  }
  "pub-notification-sub-02" = {
    topic  = "projects/<PROJECT-ID>/topics/pub-notification-topic-02"
    labels = {}
    options = {
      ack_deadline_seconds         = 10
      message_retention_duration   = "604800s"
      enable_message_ordering      = false
      expiration_policy_ttl        = "2678400s"
      retain_acked_messages        = false
      enable_exactly_once_delivery = true
    }
  }
}

minimum_backoff = "10s"
maximum_backoff = "600s"

pubsub_roles   = ["roles/pubsub.publisher"]
pubsub_members = "allUsers"


################## event arc and workflow 

eventarc_sa         = "sa-eventarc-workflows"
eventarc_sa_display = "Evenarc Workflows Service Account"
eventarc_roles      = ["roles/workflows.admin", "roles/logging.logWriter", "roles/batch.jobsEditor", "roles/batch.jobsAdmin", "roles/editor"]
event_arc = {
  "event-arc-01" = {
    eventarc_value       = "google.cloud.pubsub.topic.v1.messagePublished"
    eventarc_region      = "us-central1"
    eventarc_attribute   = "type"
    workflow_name        = "workflow-job-01"
    pubsub_topic         = "projects/<PROJECT-ID>/topics/pub-notification-topic-01"
    workflow_region      = "us-central1"
    workflow_description = "workflow trigger to perform batchjobs"
    source_contents      = "./workflow-templates/workflow.yaml"
  }
}
