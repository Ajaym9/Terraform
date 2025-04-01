terraform {
  backend "gcs" {
    bucket = "bkt-terraform-backend"
    prefix = "terraform-state"
    #credentials="" //path to be defined
  }
}