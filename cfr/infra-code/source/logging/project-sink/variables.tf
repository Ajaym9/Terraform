//name of the sink
variable "sink_name" {
 type = string
}
 
//description of the sink
variable "filter" {
 type = string
}
 
//folder id in which sink is created
variable "source-project-id" {
 type = string
}
 
//destination of sink
variable "destination" {
 type = string
}
 
//project id of dataset
variable "log-projectid" {
 type = string
}
 
//role
variable "role" {
type = string
}
