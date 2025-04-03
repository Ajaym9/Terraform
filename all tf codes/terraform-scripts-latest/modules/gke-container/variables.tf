variable "project_id" {
 type = string 
 description = "project id"
}

variable "cluster_name" {
 type = string 
 description = "GKE cluster name"
}

variable "cluster_location" {
 type = string 
 description = "GKE cluster  location"
}

variable "default_node_pool" {
 type = bool
 description = "default node pool"
 default = true
}

variable "initial_node_count" {
 type = number
 description = "initial node count"
 default = 1
}

variable "pool_name" {
 type = string 
 description = "container pool name"
}


variable "pool_location" {
 type = string 
 description = "container pool location"
}


variable "node_count" {
 type = number
 description = "GKE node count"
}

variable "preemptible_config" {
 type = bool 
 description = "preemptible config"
}

variable "machine_type" {
 type = string 
 description = "machine type"
}

variable "service_account_email" {
 type = string 
 description = "machine type"
}

variable "scopes" {
 type = list(string)
 description = "oauth scopes"
}
