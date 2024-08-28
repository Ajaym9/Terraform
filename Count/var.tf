variable "user_names" {
  description = "IAM usernames"
  type        = list(string)
  default     = ["user1", "user2", "user3"]
}



#######################GCS variable file#############

variable "buckets" {
    type = list(string)
}

variable"location"{
    type = string
}

variable"force_destroy"{
   type = bool
}