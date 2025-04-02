provider "google" {
 alias = "impersonation"
 scopes = [
   "https://www.googleapis.com/auth/cloud-platform",
   "https://www.googleapis.com/auth/userinfo.email",
 ]
}

data "google_service_account_access_token" "default" {
 provider               	= google.impersonation
 target_service_account 	= "sa-cf-vpc-coba-lab@gpi-coba-tcsla-pjnp-01nl159607.iam.gserviceaccount.com"
 scopes                 	= ["userinfo-email", "cloud-platform"]
 lifetime               	= "1200s"
}

provider "google" {
 project 		= "gpi-coba-tcsla-pjnp-01nl159607"
 access_token	= data.google_service_account_access_token.default.access_token
 request_timeout 	= "60s"
}

