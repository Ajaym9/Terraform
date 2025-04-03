//name of the alert
variable "alertname" {
  type = string
}
 
//name of the notification channel
variable "channel" {
  type = list(string)
}
 
//name of the combiner
variable "combiner" {
  type = string
}
 
//condition
variable "condition_name" {
  type = string
}
 
//project in which alert is created
variable "project_id" {
  type = string
}
variable "documentation" {
  type = string
}
variable "auto_close" {
  type = string
}
variable "query" {
  type = string
}
 
variable "duration" {
type =string
}
variable "trigger_count" {
type =string
}
