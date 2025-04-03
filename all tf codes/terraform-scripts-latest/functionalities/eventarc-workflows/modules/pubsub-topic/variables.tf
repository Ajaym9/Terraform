variable "project_id" {
  description = "Project id"
  type        = string
}
variable "kms_key_name" {
  description = "KMS key name"
  type        = string
  default     = ""
}
variable "topic_name" {
  description = "PubSub topic name."
  type        = string
}

variable "topic_labels" {
  description = "Labels."
  type        = map(string)
  default     = {}
}

variable "topic_message_retention" {
  description = "pubsub topic message retention"
  type        = string
}

variable "regions" {
  description = "List of regions used to set persistence policy."
  type        = list(string)
  default     = []
}

variable "pubsub_roles" {
type = list(string)
description = "pubsub roles"
}

variable "pubsub_members" {
type = string
description = "pubsub members"
}
