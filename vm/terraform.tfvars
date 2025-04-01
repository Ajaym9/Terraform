instances = {
  "test-instance1" = {
    machine_type= "e2-meduim"
    project_id ="s"
    zone="us-central1-a"
    image="debian-cloud/debian-11"
    network="my-vpc"
  }

#second instance
   "test-instance2" = {
    machine_type= "e2-micro"
    project_id ="4"
    zone="us-central1-b"
    image="debian-cloud/debian-11"
    network="my-vpc"
  }
}



##############################################################################
            # vpc #
##############################################################################
vpc = {
  "vpc-1" = {
   project_id         = ""
   network_name    = "test-vpc"
  description     = "lz foundation network"
  routing_mode    = "GLOBAL"
  auto_create_subnetworks = "false"
  delete_default_internet_gateway_routes = "true"
  mtu = "0"
    
  }
}


subnet_details = {
  "test-subnet-01" = {   //subnet name to be added
    vpc_name = "test-range-01"
    ip_range = "10.157.32.0/25"
    region = "us-central1"
    private_ip_google_access = false
  },
    "test-subnet-02" = {
    vpc_name = "test-range-01"
    ip_range = "10.157.33.0/25"
    region = "us-central1"
    private_ip_google_access = true
    }
 }
secipsubnet_details = {
"sec-subnet-rage" = {
    vpc_name = "test-range-01"
    ip_range = "10.157.32.128/25"
    region = "us-central1"
    range_name = "test-range-01"
    sec_ip_range = "10.168.34.0/23"
    range_name_2 = "test-range-02"
    sec_ip_range_2 = "10.172.33.128/26"
  }
}


#serviceproject_id = ["", ] 
svcacct_details = {
  "svc-acct" = {
    display_name = "svc-acct"
  }
}


enable_api = {
"compute.googleapis.com" = ""
"servicenetworking.googleapis.com" =""
# "sql-component.googleapis.com" = ""
# "sqladmin.googleapis.com" = ""
# "dataflow.googleapis.com" = ""
# "datalineage.googleapis.com" = ""
# "datapipelines.googleapis.com" = ""
# "cloudscheduler.googleapis.com" = ""
# "bigquery.googleapis.com" = ""
# "storage.googleapis.com" = ""
# "iap.googleapis.com" = ""
# "container.googleapis.com" = ""
# "composer.googleapis.com" = ""
}


##############################################################################
            # nat #
##############################################################################
nat_gateways = {
  nat_gateway_1 = {
    router_name                        = "test-rtr"
    nat_name                           = "test-nat-01"
    network                            = "test-vpc"
    project                            = ""
    region                             = "asia-south1"
    nat_ip_allocate_option             = "AUTO_ONLY"
    source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
    enable_log_config                  = true
    nat_ips                            = []
    #min_ports_per_vm                   = 2048
    #max_ports_per_vm                   = 65535
    filter                             = "ERRORS_ONLY"
  }

}
