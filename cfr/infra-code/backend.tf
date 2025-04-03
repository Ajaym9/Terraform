terraform {
  backend "gcs" {
    bucket = "bkt-cfr-app-terraform-backend-dev"
    prefix = "terraform-state-a360-dia/a360-dia"
    #credentials="" //path to be defined
  }
}