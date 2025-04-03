
#####################################################################
#                     Create Pubsub Topic                           #
#####################################################################

resource "google_pubsub_topic" "default" {
  name                       = var.topic_name
  project                    = var.project_id
  labels                     = var.topic_labels
  message_retention_duration = var.topic_message_retention
  kms_key_name               = var.kms_key_name

  dynamic "message_storage_policy" {
    for_each = length(var.regions) > 0 ? [var.regions] : []
    content {
      allowed_persistence_regions = var.regions
    }
  }
}

#####################################################################
#                Create Pubsub Topic members                         #
#####################################################################

resource "google_pubsub_topic_iam_member" "member" {
for_each = toset(var.pubsub_roles)
  project  = var.project_id
  topic    = google_pubsub_topic.default.name
  role     = each.value
  member  = var.pubsub_members
}
