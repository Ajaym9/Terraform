variable "condition_threshold" {
  description = "A condition that compares a time series against a threshold."
  type = object({
    filter               = string
    duration             = string
    threshold            = number
    comparison           = string
    alignment_period     = string
    aligner              = string
    #documentation = string
    count = number
    cross_series_reducer = string  
})
}
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
