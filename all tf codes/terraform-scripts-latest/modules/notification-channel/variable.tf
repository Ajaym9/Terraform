variable "notificationdisplayname" {
  type    = string
  default = null
}

variable "type" {
  type = string
}

variable "labels" {
  type = map(string)
}

variable "project_id" {
  type    = string
}
