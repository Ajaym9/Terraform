
variable "project_id" {
  type        = string
  description = "project_id"
}

######### apis
variable "service_api" {
  type        = list(string)
  description = "apis"
}

############# gcs
/*
variable "gcs_bucket" {
  description = "gcs buckets"
  type = map(object({
    gcs_location  = string
    storage_class = string
  }))
}*/

variable "cloud_run" {
  type = map(object({
    run_location        = string
    run_container_image = string
    run_percent         = number
    run_revision        = bool
  }))
}
variable "run_roles" {
  type        = list(string)
  description = "cloud run roles"
}

variable "run_member" {
  type        = string
  description = "cloud run member"
}



#######pubsub
variable "pubsub_topics" {
  description = "pubsub topic"
  type = map(object({
    topic_labels = map(string)
  }))
}

variable "topic_message_retention" {
  description = "pubsub topic message retention duration"
  type        = string
}


variable "pubsub_subscriptions" {
  description = "Topic subscriptions. Also define push configs for push subscriptions. If options is set to null subscription defaults will be used. Labels default to topic labels if set to null."
  type = map(object({
    topic  = string
    labels = map(string)
    options = object({
      ack_deadline_seconds         = number
      message_retention_duration   = string
      retain_acked_messages        = bool
      expiration_policy_ttl        = string
      enable_message_ordering      = bool
      enable_exactly_once_delivery = bool
    })
  }))
  default = {}
}

variable "minimum_backoff" {
  description = "The minimum delay between consecutive deliveries of a given message."
  type        = string
}

variable "maximum_backoff" {
  description = "The maximum delay between consecutive deliveries of a given message."
  type        = string
}

variable "storage_notification" {
  description = "storage notifications"
  type = map(object({
    bucket_name    = string
    payload_format = string
    pubsub_topic   = string
  }))
}



variable "pubsub_roles" {
  type        = list(string)
  description = "pubsub roles"
}

variable "pubsub_members" {
  type        = string
  description = "pubsub members"
}

############event arc and workflow
variable "eventarc_sa" {
  type        = string
  description = "event arc service account"
}

variable "eventarc_sa_display" {
  type        = string
  description = "event arc sa display name"
}


variable "eventarc_roles" {
  type        = list(string)
  description = "event arc and workflow roles"
}

variable "event_arc" {
  type = map(object({
    eventarc_value       = string
    eventarc_region      = string
    eventarc_attribute   = string
    pubsub_topic         = string
    workflow_name        = string
    workflow_region      = string
    workflow_description = string
    source_contents      = string
  }))
}

