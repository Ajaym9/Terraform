##############################################################################
            # ALERT #
##############################################################################

notification_channels = [
  {
    display_name  = "Primary Email"
    email_address = "vamsi.narayana@tcs.com"
#    project = "gpi-coba-tcsla-pjnp-01nl159607"
  },
  {
    display_name  = "Secondary Email"
    email_address = "ajay.maddireddy@tcs.com"
 #   project = "gpi-coba-tcsla-pjnp-01nl159607"
  }
]

project = "gpi-coba-tcsla-pjnp-01nl159607"
alert_policies = [
{
    display_name = "High Disk I/O"
    conditions = [
{
      display_name   = "Disk I/O High"
      project = "gpi-coba-tcsla-pjnp-01nl159607"
      filter         = "metric.type=\"compute.googleapis.com/instance/disk/write_bytes_count\" AND resource.type=\"gce_instance\""
      comparison     = "COMPARISON_GT"
      threshold_value = 1000000000  # Disk I/O threshold in bytes
 }   
  ]
}
]


##############################################################################
            # API #
##############################################################################
enable_api1 ={
   "api1" ={
apiname = "iap.googleapis.com"
project_id = "gpi-coba-tcsla-pjnp-01nl159607"
}

"api2" ={
apiname = "monitoring.googleapis.com"
project_id = "gpi-coba-tcsla-pjnp-01nl159607"
}

"api3" ={
apiname = "logging.googleapis.com"
project_id ="gpi-coba-tcsla-pjnp-01nl159607"
}
}

##############################################################################
            # firewall #
##############################################################################
firewall_rules = {
  rule1 = {
    name                      = "coba-lz-iap-ingress-fw"
    network                   = "coba-lz-vpc-01"
    direction                 = "INGRESS"
    priority                  = 1000
    project = "gpi-coba-tcsla-pjnp-01nl159607"
    disabled                  = false
    allowed                   = [{ protocol = "tcp", ports = ["22"] }]
    denied                    = []
    source_ranges             = ["35.235.240.0/20"]
    source_tags               = []
    source_service_accounts   = []
    destination_ranges        = ["10.0.0.3/32"]
    target_tags               = ["allow-iap-ssh"]
    target_service_accounts   = []
    log_metadata              = "INCLUDE_ALL_METADATA"
  }
}

##############################################################################
            # gcs #
##############################################################################
bucket_details = {
  "bucket-1" = {
    bucket_name = "coba-lz--bkt-asia-projsink"
    location = "ASIA"
    project = "gpi-coba-tcsla-pjnp-01nl159607"
  }
/*
 "bucket-2" = {
    bucket_name = "coba-lz--bkt-asia-projsink1"
    location = "ASIA"
    project = "gpi-coba-tcsla-pjnp-01nl159607"
  }*/
}

##############################################################################
            # logging #
##############################################################################
sink_details = {
  "sink1" = {
    name                   = "coba-lz-dev-sink-01"
    description            = "coba-projectsink"
    project                = "gpi-coba-tcsla-pjnp-01nl159607"
    unique_writer_identity = true
    destination            = "storage.googleapis.com/coba-lz--bkt-asia-projsink"
    role                   = "roles/storage.objectCreator"
  }
}

##############################################################################
            # nat #
##############################################################################
nat_gateways = {
  nat_gateway_1 = {     
    router_name                        = "coba-lz-nat-rtr"
    nat_name                           = "coba-lz-nat-01"
    network                            = "coba-lz-vpc-01"
    project                            = "gpi-coba-tcsla-pjnp-01nl159607"
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

##############################################################################
            # projectiam #
##############################################################################
iam = {
    "iam1" = {
        project_id ="gpi-coba-tcsla-pjnp-01nl159607"
        roles ="roles/iap.tunnelResourceAccessor"
        members = "user:vamsi.narayana@tcs.com"
    }
}

##############################################################################
            # subnets #
##############################################################################



subnets= [
{
subnet_name                = "coba-lz-snet-01"
project_id                 = "gpi-coba-tcsla-pjnp-01nl159607"
network_name               = "coba-lz-vpc-01"
description                = "Mumbai subnet"
subnet_region              = "asia-south1"
subnet_ip                  = "10.0.0.0/24"
purpose                    = "PRIVATE"
}
]

secondary_ranges           = {}

##############################################################################
            # vm #
##############################################################################
#vm instance details
instance_details = {
  "instance-1" = {
    project_id      = "gpi-coba-tcsla-pjnp-01nl159607"
    vm_name         = "coba-lz-dev-vm-01"
    zone            = "asia-south1-a"
    machine_type    = "e2-medium"
    subnetwork      = "https://www.googleapis.com/compute/v1/projects/gpi-coba-tcsla-pjnp-01nl159607/regions/asia-south1/subnetworks/coba-lz-snet-01"
    network         = "https://www.googleapis.com/compute/v1/projects/gpi-coba-tcsla-pjnp-01nl159607/global/networks/coba-lz-vpc-01" //network name
    network_ip      = "10.0.0.3"
    service_account = "sa-cf-vpc-coba-lab@gpi-coba-tcsla-pjnp-01nl159607.iam.gserviceaccount.com"  //Service account principal to be added
    disk_size       = "20"
    disk_type       = "pd-ssd"
    image           = "debian-cloud/debian-11"
    tags            = ["http","https","allow-iap-ssh"]
    hostname        = "coba-dev"
  }
}
##############################################################################
            # vpc #
##############################################################################
vpcs = {
  "vpc-1" = {
   project_id         = "gpi-coba-tcsla-pjnp-01nl159607"
   network_name    = "coba-lz-vpc-01"
  description     = "lz foundation network"
  routing_mode    = "GLOBAL"
  auto_create_subnetworks = "false"
  delete_default_internet_gateway_routes = "true"
  mtu = "0"
    
  }
}
###############################################################################
           # VPC Serverless#
#############################################################################
access_connector = {
 "connector1" = {
    name          = "coba-lz-access-connector"
ip_cidr_range = "10.0.6.0/28"
network       = "coba-lz-vpc-01"
region        = "asia-south1"
project = "gpi-coba-tcsla-pjnp-01nl159607"
min_instances = 2
max_instances = 3
machine_type = "e2-micro"
 }
}

##############################################################################
         # sql #
#############################################################################

sql_instances = [
    {
      "instance_name": "postgres-db-1",
      "database_version": "POSTGRES_14",
      "region": "asia-south1",
      "tier": "db-custom-2-3840",
      "availability_type": "REGIONAL",
      "disk_size": 50,
      "enable_backup": true,
      "backup_start_time": "23:00",
      "deletion_protection": false,
      "vpc_network": "projects/gpi-coba-tcsla-pjnp-01nl159607/global/networks/coba-lz-vpc-01",
      "database_users": [
        {
          "name": "admin",
          "password": "securepassword123"
          "project": "gpi-coba-tcsla-pjnp-01nl159607"
        }
      ]
    }
  ]

