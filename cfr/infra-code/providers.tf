terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~>4.0"
    }
  }
}

provider "google" {
  credentials = "/home/manjusha_vennapusa_coniferhealth/cfr-dna-hrcm-dev-project.json" //path to be defined
  project     = "cfr-dna-hrcm-dev-project"
}

provider "google-beta" {
  credentials = "/home/manjusha_vennapusa_coniferhealth/cfr-dna-hrcm-dev-project.json"
  project     = "cfr-dev-network-host-project"
}
