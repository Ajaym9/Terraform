terraform {
  backend "gcs" {
    bucket = "coba-lz-gcs-tfstate-01"
    prefix = "terraform-state/resources"
    impersonate_service_account = "sa-cf-vpc-coba-lab@gpi-coba-tcsla-pjnp-01nl159607.iam.gserviceaccount.com"
 
    #credentials="" //path to be defined
  }
}

