resource "google_vpc_access_connector" "connector" {
  name             = var.name				#"my-vpc-access-connector"
  ip_cidr_range    = var.ip_cidr_range			#"10.100.0.0/28" 
  network          = var.network
  project          = var.project			#"projects/<PROJECT_ID>/global/networks/<NETWORK_NAME>"
  region           = var.region				#"us-central1" 
  min_instances    = var.min_instances			
  max_instances    =  var.max_instances	
  machine_type     = var.machine_type
}
