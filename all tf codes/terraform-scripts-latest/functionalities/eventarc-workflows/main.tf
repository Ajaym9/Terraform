#######################################################################
#     Enable apis required to create and manage resources             #
#######################################################################

module "enables-api" {
  source      = "./modules/enable-apis"
  project_id  = var.project_id
  service_api = var.service_api
}


#######################################################################
#               Create a cloud storage bucket                         #
#######################################################################

module "source_code_bucket" {
  source        = "./modules/gcs"
  for_each      = var.gcs_bucket
  name          = each.key
  project_id    = var.project_id
  location      = each.value.gcs_location
  storage_class = each.value.storage_class
}



#######################################################################
#               create cloud run	                              #
#######################################################################

module "cloud_run_website" {
  source              = "./modules/cloud-run"
  for_each            = var.cloud_run
  run_name            = each.key
  run_location        = each.value.run_location
  project_id          = var.project_id
  run_container_image = each.value.run_container_image
  run_percent         = each.value.run_percent
  run_revision        = each.value.run_revision
  run_roles           = var.run_roles
  run_member          = var.run_member
}

#######################################################################
#          create storage notifications			              #
#######################################################################

module "storage_notification" {
  source      = "./modules/storage_notification"
  for_each    = var.storage_notification
  bucket_name = each.value.bucket_name

  payload_format = each.value.payload_format
  pubsub_topic   = each.value.pubsub_topic
  depends_on     = [module.pubsub-topic, module.pubsub-subscription]

}

##########################################################
#     create pubsub topics and subscritpions              #
##########################################################

module "pubsub-topic" {
  source                  = "./modules/pubsub-topic"
  for_each                = var.pubsub_topics
  topic_name              = each.key
  topic_labels            = each.value.topic_labels
  project_id              = var.project_id
  topic_message_retention = var.topic_message_retention
  pubsub_roles            = var.pubsub_roles
  pubsub_members          = var.pubsub_members
  depends_on              = [module.cloud_run_website, module.enables-api]
}

module "pubsub-subscription" {
  source          = "./modules/pubsub-subscription"
  subscriptions   = var.pubsub_subscriptions
  project_id      = var.project_id
  minimum_backoff = var.minimum_backoff
  maximum_backoff = var.maximum_backoff
  depends_on      = [module.cloud_run_website, module.enables-api, module.pubsub-topic]
}

#######################################################################
#           create event arc and workflow                             #
#######################################################################

module "event-arc-workflow" {
  source               = "./modules/event-arc"
  for_each             = var.event_arc
  eventarc_name        = each.key
  project_id           = var.project_id
  eventarc_sa          = var.eventarc_sa
  eventarc_sa_display  = var.eventarc_sa_display
  eventarc_roles       = var.eventarc_roles
  pubsub_topic         = each.value.pubsub_topic
  eventarc_value       = each.value.eventarc_value
  eventarc_region      = each.value.eventarc_region
  source_contents      = each.value.source_contents
  eventarc_attribute   = each.value.eventarc_attribute
  workflow_name        = each.value.workflow_name
  workflow_region      = each.value.workflow_region
  workflow_description = each.value.workflow_description
  depends_on           = [module.pubsub-topic, module.pubsub-subscription, module.enables-api]
}
