variable "notificationdisplayname" {
  type    = string
  default = null
}
 
//email to be used as notification channel
variable "email" {
  type = string
}
 
//project id in which notification channel is created
variable "project_id" {
  type    = string
}
