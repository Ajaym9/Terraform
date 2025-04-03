variable "display_name" {
type = string
description = "name of the alert policy"
}

variable "combiner" {
type = string
description = "combiner"
}

variable "condition_name" {
type = string
description = "name of the condition"
}

variable "filter" {
type = string
description = "filter to be applied"
}

variable "duration" {
type = string
description = "duration"
}

variable "threshold_value" {
type = string
description = "threshold_value"
}

variable "comparison" {
type = string
description = "comparison"
}

variable "alignment_period" {
type = string
description = "alignment_period"
}

variable "per_series_aligner" {
type = string
description = "per_series_aligner"
}

variable "notification_channel_name" {
type = string
description = "name of the notification channnel"
}

variable "email_address" {
type = string
description = "email to which alert has to be sent"
}

/*
variable "number" {
type = string
description = "number to which alert has to be sent "
}*/