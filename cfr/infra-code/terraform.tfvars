folder_id = "393275815066" //folderid

billing_id = "01D325-4988D3-BE2504" //billing id

#vm instance details
instance_details = {
  "instance-1" = {
    vm_name         = "cfr-dev-app-server"
    zone            = "us-central1-a"
    machine_type    = "e2-medium"
    subnetwork      = "https://www.googleapis.com/compute/v1/projects/cfr-dev-network-host-project/regions/us-central1/subnetworks/cfr-dev-host-uc1-dia-snet"
    network         = "https://www.googleapis.com/compute/v1/projects/cfr-dev-network-host-project/global/networks/cfr-dev-host-vpc" //network name
    service_account = "308891583850-compute@developer.gserviceaccount.com"  //Service account principal to be added
    disk_size       = "50"
    image           = "rhel-8-v20231115"
  }
"instance-2" = {
    vm_name         = "cfr-dev-infra-jumpbox-server"
    zone            = "us-central1-a"
    machine_type    = "e2-medium"
    subnetwork      = "https://www.googleapis.com/compute/v1/projects/cfr-dev-network-host-project/regions/us-central1/subnetworks/cfr-dev-host-uc1-main-snet"
    network         = "https://www.googleapis.com/compute/v1/projects/cfr-dev-network-host-project/global/networks/cfr-dev-host-vpc" //network name
    service_account = "308891583850-compute@developer.gserviceaccount.com" //Service account principal to be added
    disk_size       = "30"
    image           = "debian-11-bullseye-v20231115"
  }
}
tags = ["http-server", "https-server"] 

sql_details = {
  "sql-1" = {
    sql_name         = "cfr-dev-data-server" //sql instance name
    sql_region       = "us-central1" 
    sql_tier         = "db-custom-2-7680"
    database_version = "POSTGRES_14"
    network          = "cfr-dev-host-vpc" //network name
  }
}
ip_name      = "cfr-dia-private-ip-address"  //private service connection name
ip_purpose   = "VPC_PEERING"
ip_type      = "INTERNAL"
ip_version   = "IPV4"
name         = "integrator" //sql user name
password     = "Itg#Zo1i@H4s"
host-project = "cfr-dev-network-host-project" //host project-id

subnet_details = {
  "cfr-dna-dev-host-uc1-main-snet" = {   //subnet name to be added
    vpc_name = "cfr-dev-host-vpc"
    ip_range = "10.157.32.0/25"
    region = "us-central1"
    private_ip_google_access = false
  },
    "cfr-dna-dev-host-uc1-dataflow-snet" = {
    vpc_name = "cfr-dev-host-vpc"
    ip_range = "10.157.33.0/25"
    region = "us-central1"
    private_ip_google_access = true
    }
 }
secipsubnet_details = {
"cfr-dna-dev-host-uc1-serverless-snet" = {
    vpc_name = "cfr-dev-host-vpc"
    ip_range = "10.157.32.128/25"
    region = "us-central1"
    range_name = "cfr-dna-dev-host-uc1-serverless-snet-scrange"
    sec_ip_range = "10.157.34.0/23"
    range_name_2 = "cfr-dna-dev-host-uc1-serverless-snet-scrange2"
    sec_ip_range_2 = "10.157.33.128/26"
  }
}

composer_config = {
  "cfr-dna-hrcm-dev-composer" = {      //composer name
    region ="us-central1"
    project_id = "cfr-dna-hrcm-dev-project"
    resilience_mode = "STANDARD_RESILIENCE"
    envsize = "ENVIRONMENT_SIZE_MEDIUM"
    network = "cfr-dev-host-vpc"
    subnetwork = "cfr-dna-dev-host-uc1-serverless-snet"
    service_account = "svc-acct-dna-dev-composer@cfr-dna-hrcm-dev-project.iam.gserviceaccount.com"
    cluster_secrange_name = "cfr-dna-dev-host-uc1-serverless-snet-scrange"   //secondary ip range1 to be added
    servicessecrange_name = "cfr-dna-dev-host-uc1-serverless-snet-scrange2"  //secondary ip range2 to be added
    connection_type = "PRIVATE_SERVICE_CONNECT"
    privateendpoint = true
    image_version  = "composer-2.5.2-airflow-2.6.3"
    clouddatalineage = true
    scheduler_cpu  = 2     //cpu memory details to be added as per the requirement
    scheduler_mem = 7.5
    scheduler_sto = 5
    scheduler_count  = 2
    web_server_cpu = 2
    web_server_mem = 7.5
    web_server_sto = 5
    worker_cpu = 2
    worker_mem = 7.5
    worker_sto = 5
    worker_mincount= 2
    worker_maxcount = 6
  }
}

#iam roles assignment to different groups in different projects
iam = {
    "iam1" = {
        project_id ="cfrdnahrcmdevdata"
        roles ="roles/bigquery.admin"
        members = "group:cfr-gcp-tcs-bigquery-admin-group@coniferhealth.com"
    }
    "iam2" = {
        project_id ="cfr-dna-hrcm-dev-project"
        roles ="roles/composer.admin"
        members = "group:cfr-gcp-tcs-composer-admin-group@coniferhealth.com"
    }
     "iam3" = {
        project_id ="cfr-dna-dev-gcs-project"
        roles ="roles/storage.admin"
        members = "group:cfr-gcp-tcs-storage-admin-group@coniferhealth.com"
    }
     "iam4" = {
        project_id ="cfr-dna-hrcm-dev-project"
        roles ="roles/dataflow.admin"
        members = "group:cfr-gcp-tcs-dataflow-admin-group@coniferhealth.com"
    }
    "iam5" = {
        project_id ="cfr-dna-hrcm-dev-project"
        roles ="roles/dataplex.admin"
        members = "group:cfr-gcp-tcs-dataplex-admin-group@coniferhealth.com"
    }  
    "iam6" = {
        project_id ="cfrdnahrcmdevdata"
        roles ="roles/bigquery.dataEditor"
        members = "group:cfr-gcp-tcs-bigquery-editor-group@coniferhealth.com"
    }
     "iam7" = {
        project_id ="cfr-dna-hrcm-dev-project"
        roles ="roles/iap.tunnelResourceAccessor"
        members = "group:cfr-gcp-tcs-cloud-engineer-group@coniferhealth.com"
    }
     "iam8"= {
       project_id = "cfr-dna-hrcm-dev-project"
       roles = "roles/iap.tunnelResourceAccessor"
        members = "group:cfr-gcp-tcs-editor-access-group@coniferhealth.com"
    }
    "iam9"= {
       project_id = "cfr-dna-hrcm-dev-project"
       roles = "roles/resourcemanager.projectIamAdmin"
        members = "group:cfr-gcp-tcs-iam-admin-group@coniferhealth.com"
    }
    "iam10" = {
        project_id ="cfr-dna-hrcm-dev-project"
        roles ="roles/storage.admin"
        members = "group:cfr-gcp-tcs-storage-admin-group@coniferhealth.com"
    }
    "iam11" = {
        project_id = "cfr-dna-hrcm-dev-project"
        roles = "roles/logging.viewer"
        members = "group:cfr-gcp-tcs-composer-admin-group@coniferhealth.com"
    }
    "iam12" = {
        project_id = "cfr-dna-hrcm-dev-project" 
        roles = "roles/iam.serviceAccountUser"
        members = "group:cfr-gcp-tcs-composer-admin-group@coniferhealth.com"
    }
    "iam13" = {
        project_id = "cfr-dna-hrcm-dev-project"
        roles = "roles/compute.instanceAdmin.v1"
        members = "group:cfr-gcp-tcs-cloud-engineer-group@coniferhealth.com"
    }
    "iam14" = {
        project_id = "cfr-dna-hrcm-dev-project"
        roles = "roles/iam.serviceAccountUser"
        members = "group:cfr-gcp-tcs-cloud-engineer-group@coniferhealth.com"
    }  
    "iam15"= {
       project_id = "cfr-dna-hrcm-dev-project"
       roles = "roles/editor"
       members = "group:cfr-gcp-tcs-editor-access-group@coniferhealth.com"
    }
   "iam16"= {
       project_id = "cfrdnahrcmdevdata"
       roles = "roles/viewer"
       members = "group:cfr-gcp-tcs-editor-access-group@coniferhealth.com"
    }
"iam17"= {
       project_id = "cfr-dna-dev-svc-acct-project"
       roles = "roles/viewer"
       members = "group:cfr-gcp-tcs-editor-access-group@coniferhealth.com"
    }
"iam18"= {
       project_id = "cfrdnahrcmdevdata"
       roles = "roles/viewer"
       members = "group:cfr-gcp-tcs-cloud-engineer-group@coniferhealth.com"
    }
"iam19"= {
       project_id = "cfr-dna-dev-svc-acct-project"
       roles = "roles/viewer"
       members = "group:cfr-gcp-tcs-cloud-engineer-group@coniferhealth.com"
    }
}

folder_details = ["cfr-dna-dev-folder","cfr-dna-test-folder","cfr-dna-prod-folder"] 
 
folder_name1 = "cfr-dna-folder"
 
org_id = "11634262264"
dev_project_details = {
  "dev-project1" = "cfr-dna-dev-gcs-project"
  "dev-project2" = "cfr-dna-dev-svc-acct-project"
  "dev-project3" = "cfrdnahrcmdevdata"
  "dev-project4" = "cfrdnahrcmdevviews"
  "dev-project5" = "cfr-dna-dev-users-project"
  "dev-project6" = "cfr-dna-hrcm-dev-project"
}
test_project_details = {
  "test-project1" = "cfr-dna-test-gcs-project"
  "test-project2" = "cfr-dna-test-svc-acct-project"
  "test-project3" = "cfrdnahrcmtestdata"
  "test-project4" = "cfrdnahrcmtestviews"
  "test-project5" = "cfr-dna-test-users-project"
  "test-project6" = "cfr-dna-hrcm-test-project"
}
prod_project_details = {
  "prod-project1" = "cfr-dna-prod-gcs-project"
  "prod-project2" = "cfr-dna-prod-svc-acct-project"
  "prod-project3" = "cfrdnahrcmproddata"
  "prod-project4" = "cfrdnahrcmprodviews"
  "prod-project5" = "cfr-dna-prod-users-project"
  "prod-project6" = "cfr-dna-hrcm-prod-project"
}
serviceproject_id = ["cfr-dna-dev-gcs-project", "cfr-dna-dev-svc-acct-project","cfr-dna-dev-users-project","cfrdnahrcmdevdata","cfr-dna-hrcm-dev-project","cfrdnahrcmdevviews"] 
svcacct_details = {
  "svc-acct-dna-dev-composer" = {
    display_name = "svc-acct-dna-dev-composer"
  },
  "svc-acct-dna-dev-dataflow" = {
    display_name = "svc-acct-dna-dev-dataflow"
  },
 "svc-acct-dna-dev-infra-tf" = {
    display_name = "svc-acct-dna-dev-infra-tf"
  }
}
enable_api = {
"compute.googleapis.com" = "cfr-dna-hrcm-dev-project"
"servicenetworking.googleapis.com" ="cfr-dna-hrcm-dev-project"
"sql-component.googleapis.com" = "cfr-dna-hrcm-dev-project"
"sqladmin.googleapis.com" = "cfr-dna-hrcm-dev-project"
"dataflow.googleapis.com" = "cfr-dna-hrcm-dev-project"
"datalineage.googleapis.com" = "cfr-dna-hrcm-dev-project"
"datapipelines.googleapis.com" = "cfr-dna-hrcm-dev-project"
"cloudscheduler.googleapis.com" = "cfr-dna-hrcm-dev-project"
"bigquery.googleapis.com" = "cfrdnahrcmdevdata"
"storage.googleapis.com" = "cfr-dna-dev-gcs-project"
"iap.googleapis.com" = "cfr-dna-hrcm-dev-project"
"container.googleapis.com" = "cfr-dna-hrcm-dev-project"
"composer.googleapis.com" = "cfr-dna-hrcm-dev-project"
}

#iam roles assignment to service accounts
sa_iam  = {
      "role1" = {
  members = "serviceAccount:svc-acct-dna-dev-dataflow@cfr-dna-hrcm-dev-project.iam.gserviceaccount.com"
  project_id = "cfr-dna-hrcm-dev-project"
  roles = "roles/storage.objectAdmin"
}
     "role2"  = {
  members = "serviceAccount:svc-acct-dna-dev-dataflow@cfr-dna-hrcm-dev-project.iam.gserviceaccount.com"
  project_id = "cfr-dna-hrcm-dev-project"
  roles = "roles/dataflow.developer"
}
      "role3" = {
  members = "serviceAccount:svc-acct-dna-dev-dataflow@cfr-dna-hrcm-dev-project.iam.gserviceaccount.com"
        project_id = "cfr-dna-hrcm-dev-project"
  roles = "roles/dataflow.worker"
}
      "role4" = {
  members = "serviceAccount:svc-acct-dna-dev-dataflow@cfr-dna-hrcm-dev-project.iam.gserviceaccount.com"
  project_id = "cfrdnahrcmdevdata"
  roles = "roles/bigquery.jobUser"
}
     "role 5" = {
  members = "serviceAccount:svc-acct-dna-dev-dataflow@cfr-dna-hrcm-dev-project.iam.gserviceaccount.com"
  project_id = "cfr-dna-hrcm-dev-project"
  roles = "roles/composer.user"
}
     "role 6" = {
  members = "serviceAccount:svc-acct-dna-dev-dataflow@cfr-dna-hrcm-dev-project.iam.gserviceaccount.com"
  project_id = "cfrdnahrcmdevdata"
  roles = "roles/bigquery.dataEditor"
}
"role7" ={
  members = "serviceAccount:svc-acct-dna-dev-composer@cfr-dna-hrcm-dev-project.iam.gserviceaccount.com"
  project_id = "cfrdnahrcmdevdata"
  roles = "roles/bigquery.jobUser"
}
"role8" ={
  members = "serviceAccount:svc-acct-dna-dev-composer@cfr-dna-hrcm-dev-project.iam.gserviceaccount.com"
  project_id = "cfr-dna-hrcm-dev-project"
  roles = "roles/composer.worker"
}
"role9" ={
  members = "serviceAccount:svc-acct-dna-dev-composer@cfr-dna-hrcm-dev-project.iam.gserviceaccount.com"
  project_id = "cfr-dna-hrcm-dev-project"
  roles = "roles/iam.serviceAccountUser"
}
"role10" ={
  members = "serviceAccount:svc-acct-dna-dev-composer@cfr-dna-hrcm-dev-project.iam.gserviceaccount.com"
  project_id = "cfr-dna-hrcm-dev-project"
  roles = "roles/logging.logWriter"
}
"role11"={
  members = "serviceAccount:svc-acct-dna-dev-composer@cfr-dna-hrcm-dev-project.iam.gserviceaccount.com"
  project_id = "cfr-dna-hrcm-dev-project"
  roles = "roles/monitoring.metricWriter"
}
"role12"={
  members = "serviceAccount:svc-acct-dna-dev-composer@cfr-dna-hrcm-dev-project.iam.gserviceaccount.com"
  project_id = "cfr-dna-hrcm-dev-project"
  roles = "roles/composer.user"
}
"role13"={
  members = "serviceAccount:svc-acct-dna-dev-composer@cfr-dna-hrcm-dev-project.iam.gserviceaccount.com"
  project_id = "cfr-dna-hrcm-dev-project"
  roles = "roles/logging.admin"
}
"role14"={
  members = "serviceAccount:svc-acct-dna-dev-composer@cfr-dna-hrcm-dev-project.iam.gserviceaccount.com"
  project_id = "cfr-dna-hrcm-dev-project"
  roles = "roles/monitoring.admin"
}
"role15"={
  members = "serviceAccount:svc-acct-dna-dev-composer@cfr-dna-hrcm-dev-project.iam.gserviceaccount.com"
  project_id = "cfrdnahrcmdevdata"
  roles = "roles/bigquery.dataEditor"
}
"role16"={
  members = "serviceAccount:svc-acct-dna-dev-composer@cfr-dna-hrcm-dev-project.iam.gserviceaccount.com"
  project_id = "cfr-dna-hrcm-dev-project"
  roles = "roles/dataflow.admin"
}
"role17"={
  members = "serviceAccount:svc-acct-dna-dev-composer@cfr-dna-hrcm-dev-project.iam.gserviceaccount.com"
  project_id = "cfrdnahrcmdevdata"
  roles = "roles/bigquery.readSessionUser"
}
"role18"={
  members = "serviceAccount:svc-acct-dna-dev-composer@cfr-dna-hrcm-dev-project.iam.gserviceaccount.com"
  project_id = "cfr-dna-hrcm-dev-project"
  roles = "roles/bigquery.resourceViewer"
}
"role19"={
  members = "serviceAccount:svc-acct-dna-dev-composer@cfr-dna-hrcm-dev-project.iam.gserviceaccount.com"
  project_id = "cfr-dna-hrcm-dev-project"
  roles = "roles/compute.admin"
}
"role20"={
  members = "serviceAccount:svc-acct-dna-dev-composer@cfr-dna-hrcm-dev-project.iam.gserviceaccount.com"
  project_id = "cfr-dna-dev-svc-acct-project"
  roles = "roles/secretmanager.secretAccessor"
}
 
"role21"={
  members = "serviceAccount:svc-acct-dna-dev-composer@cfr-dna-hrcm-dev-project.iam.gserviceaccount.com"
  project_id = "cfr-dna-dev-svc-acct-project"
  roles = "roles/secretmanager.viewer"
}
"role22"={
  members = "serviceAccount:svc-acct-dna-dev-composer@cfr-dna-hrcm-dev-project.iam.gserviceaccount.com"
  project_id = "cfr-dna-hrcm-dev-project"
  roles = "roles/storage.objectAdmin"
}
"role23" = {
  members = "serviceAccount:svc-acct-dna-dev-dataflow@cfr-dna-hrcm-dev-project.iam.gserviceaccount.com"
  project_id = "cfr-dna-dev-gcs-project"
  roles = "roles/storage.objectAdmin"
}
"role24"={
  members = "serviceAccount:svc-acct-dna-dev-composer@cfr-dna-hrcm-dev-project.iam.gserviceaccount.com"
  project_id = "cfr-dev-network-host-project"
  roles = "roles/compute.networkUser"
}
"role25"={
  members = "serviceAccount:svc-acct-dna-dev-composer@cfr-dna-hrcm-dev-project.iam.gserviceaccount.com"
  project_id = "cfr-dna-hrcm-dev-project"
  roles = "roles/bigquery.jobUser"
}
"role26" = {
  members = "serviceAccount:svc-acct-dna-dev-composer@cfr-dna-hrcm-dev-project.iam.gserviceaccount.com"
  project_id = "cfr-dna-dev-gcs-project"
  roles = "roles/storage.objectAdmin"
}
"role27"={
  members = "serviceAccount:svc-acct-dna-dev-composer@cfr-dna-hrcm-dev-project.iam.gserviceaccount.com"
  project_id = "cfr-dna-hrcm-dev-project"
  roles = "roles/bigquery.dataEditor"
}
"role30" ={
  members = "serviceAccount:svc-acct-dna-dev-di-tool@cfr-dna-dev-svc-acct-project.iam.gserviceaccount.com"
  project_id = "cfr-dna-dev-gcs-project"
  roles = "roles/storage.admin"
}
"role31" ={
  members = "serviceAccount:svc-acct-dna-dev-di-tool@cfr-dna-dev-svc-acct-project.iam.gserviceaccount.com"
  project_id = "cfrdnahrcmdevdata"
  roles = "roles/bigquery.admin"
}
"role32" ={
  members = "serviceAccount:svc-acct-dna-dev-composer@cfr-dna-hrcm-dev-project.iam.gserviceaccount.com"
  project_id = "cfr-dna-hrcm-dev-project"
  roles = "roles/composer.ServiceAgentV2Ext"
}
"role33" ={
  members = "serviceAccount:svc-acct-dna-dev-composer@cfr-dna-hrcm-dev-project.iam.gserviceaccount.com"
  project_id = "cfr-dna-hrcm-dev-project"
  roles = "roles/composer.environmentAndStorageObjectAdmin"
}
"role36" = {
  members = "serviceAccount:svc-acct-dna-dev-composer@cfr-dna-hrcm-dev-project.iam.gserviceaccount.com"
  project_id = "cfr-dna-hrcm-dev-project"
  roles = "roles/bigquery.readSessionUser"
}
"role37" = {
  members = "serviceAccount:svc-acct-dna-dev-dataflow@cfr-dna-hrcm-dev-project.iam.gserviceaccount.com"
  project_id = "cfr-dna-hrcm-dev-project"
  roles = "roles/bigquery.readSessionUser"
}
}
enable_api1 ={
   "api1" ={
apiname = "bigquery.googleapis.com"
project_id = "cfr-dna-hrcm-dev-project"
}
"api2" ={
apiname = "monitoring.googleapis.com"
project_id = "cfr-org-monitoring-project"
}
"api3" = {
apiname = "bigquery.googleapis.com"
project_id = "cfr-org-logging-project"
}
"api4" ={
apiname = "logging.googleapis.com"
project_id ="cfrdnahrcmdevdata"
}
"api5" ={
apiname = "bigquery.googleapis.com"
project_id ="cfr-billing-project"//billing project id
}
"api6" ={
apiname = "bigquerydatatransfer.googleapis.com"
project_id ="cfr-billing-project"//billing project id
}
}
#bucket creation
bucket_details = {
  "bucket-1" = {
    bucket_name = "cfr-bkt-us-orgsink"
    location = "US"
    project = "cfr-org-logging-project"
  }
"bucket-2" = {
    bucket_name = "cfr-bkt-us-dataprocs-logs"
    location = "US"
    project = "cfr-org-logging-project"
  }
}
org_sink = {
  "sink1" = {
    org_sinkname ="cfr_org_sink_1"
    description ="organisation sink with audit logs"
    org_id="11634262264"
    filter ="logName:cloudaudit.googleapis.com%2Factivity"
    log-projectid = "cfr-org-logging-project"
    destination = "storage.googleapis.com/cfr-bkt-us-orgsink"
    role = "roles/storage.objectCreator"
  }
}
dashboard_file_name = ["bigquery.json","composer.json"]
monitoring_project_id = "cfr-org-monitoring-project"
details = {
    "alertpolicy-1" ={
        display_name       = "conifer dev - Dataflow Worker Count"
        condition_name     = "cfr-dna-dev-dataflow-worker-count"
        filter             = "resource.type = \"gce_instance\" AND resource.labels.project_id = \"cfr-dna-hrcm-dev-project\" AND metric.type = \"compute.googleapis.com/guest/system/uptime\"" 
        threshold          = 400
        duration           = "0s"
        comparison         = "COMPARISON_GT"
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_COUNT"
        count = 1
        cross_series_reducer = "REDUCE_SUM"
        auto_close = "604800s"
        documentation = "The number of concurrent Dataflow workers has risen above 400. Due to the size of the subnet, only 500 workers can run at any given time. This alert may indicate some jobs are about to fail due to IP space exhaustion."
    }
"alertpolicy-2" ={
        display_name       = "Failed_DAGS_in_last_1hour"
        condition_name     = "Cloud Composer Workflow - Workflow Runs"
        filter             = "resource.type = \"cloud_composer_workflow\" AND metric.type = \"composer.googleapis.com/workflow/run_count\" AND metric.labels.state = \"failed\""
        threshold          = 0
        duration           = "0s"
        comparison         = "COMPARISON_GT"
        alignment_period   = "3600s"
        per_series_aligner = "ALIGN_MEAN"
        count = 1
        cross_series_reducer = "REDUCE_MEAN"
        auto_close = "3600s"
        documentation = "Failed_DAGS_in_last_1hour"
    }
"alertpolicy-4" ={
        display_name       = "cfr-dna-dev-bigquery-slot-count"
        condition_name     = "Conifer dev - ETL Prod Project - Slots used by project"
       filter             = "resource.type = \"global\" AND resource.labels.project_id = \"cfr-dna-hrcm-dev-project\" AND metric.type = \"bigquery.googleapis.com/slots/allocated_for_project\"" 
        threshold          = 2000
        duration           = "0s"
        comparison         = "COMPARISON_GT"
        alignment_period   = "300s"
        per_series_aligner = "ALIGN_MEAN"
        count = 1
       cross_series_reducer = "REDUCE_SUM"
       auto_close = "604800s"
      documentation = "BQ slot count exceeds 2000. This is for informational and tracking purposes only.\n\nThis alert is for the reference of the Tenet DNA Support team."
    }
"alertpolicy-5" ={
        display_name       = "cfr-dna-dev-composer-healthcheck"
        condition_name     = "Cloud Composer Environment - Healthy"
        filter             = "resource.type = \"cloud_composer_environment\" AND (resource.labels.environment_name = \"cfr-dna-hrcm-dev-composer\" AND resource.labels.project_id = \"cfr-dna-hrcm-dev-project\") AND metric.type = \"composer.googleapis.com/environment/healthy\""
        threshold          = 1
        duration           = "300s"
        comparison         = "COMPARISON_LT"
        alignment_period   = "300s"
        per_series_aligner = "ALIGN_COUNT_TRUE"
        count = 1
        cross_series_reducer = "REDUCE_COUNT"
       auto_close = "604800s"
      documentation = "The Dev Cloud Composer environment has been marked as unhealthy. \n\nCheck for any airflow worker and/or scheduler pods that are not available, over-utilized or stuck in a crash loop.\n\nAdditionally, this alert can be generated if the \"airflow_monitoring\" DAG is not running."
    }
"alertpolicy-6" ={
        display_name       = "cfr-dna-dev-dataproc-no-jobs"
        condition_name     = "Conifer dev - Cloud Dataproc Cluster - No Running Jobs in the past 1 hour"
        filter             = "resource.type = \"cloud_dataproc_cluster\" AND metric.type = \"dataproc.googleapis.com/cluster/job/running_count\""
        threshold          = 1
        duration           = "3600s"
        comparison         = "COMPARISON_LT"
        alignment_period   = "3600s"
        per_series_aligner = "ALIGN_MAX"
        count = 1
        cross_series_reducer = "REDUCE_MAX"
       auto_close = "43200s"
      documentation = "The Dataproc cluster has no jobs running on it \nIf not in use please proceed to shut down the Cluster"
    }
 
"alertpolicy-7" ={
        display_name       = "cfr-dna-dev-etl-bucket-size"
        condition_name     = "conifer dev - ETL Bucket - Total bytes"
        filter             = "resource.type = \"gcs_bucket\" AND resource.labels.project_id = \"cfr-dna-hrcm-dev-project\" AND metric.type = \"storage.googleapis.com/storage/total_bytes\""
        threshold          = 50000000000
        duration           = "0s"
        comparison         = "COMPARISON_GT"
        alignment_period   = "300s"
        per_series_aligner = "ALIGN_MEAN"
        count = 1
        cross_series_reducer = "REDUCE_MEAN"
       auto_close = "604800s"
      documentation = "The bucket has exceeded 50GB in size. This can lead to unnecessary monthly charges.\n\nCheck and confirm if there are any files that can be removed."
    }
 
"alertpolicy-8" ={
        display_name       = "cfr-dna-dev-task-duration-exceeds-2hrs"
        condition_name     = "Conifer dev - Cloud Composer Workflow - Task Duration"
        filter             = "resource.type = \"cloud_composer_workflow\" AND metric.type = \"composer.googleapis.com/workflow/task/run_duration\""
        threshold          = 7200
        duration           = "60s"
        comparison         = "COMPARISON_GT"
        alignment_period   = "300s"
        per_series_aligner = "ALIGN_MEAN"
        count = 1
        cross_series_reducer = "REDUCE_MEAN"
       auto_close = "43200s"
      documentation = "On the dev composer there is a task executing from more than 4 hour \nPlease check it and terminate if the task is going in infinite loop or if the task is stuck"
    }
"alertpolicy-9" ={
        display_name       = "cfr-dna-dev-cpu-util"
        condition_name     = "Conifer dev - Compute Engine CPU Utilization"
        filter             = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\" resource.type=\"gce_instance\" metric.label.\"instance_name\"=\"cfr-dev-app-server\""
        threshold          = 80
        duration           = "60s"
        comparison         = "COMPARISON_GT"
        alignment_period   = "300s"
        per_series_aligner = "ALIGN_MEAN"
        count = 1
        cross_series_reducer = "REDUCE_NONE"
       auto_close = "604800s"
      documentation = "CPU Utilization for cfr-dev-app-server in dev project"
}
"alertpolicy-10" ={
        display_name       = "cfr-dna-dev-memory-usage"
        condition_name     = "Conifer dev - Compute Engine Memory Usage"
        filter             = "metric.type=\"compute.googleapis.com/instance/memory/balloon/ram_used\" resource.type=\"gce_instance\" metric.label.\"instance_name\"=\"cfr-dev-app-server\""
        threshold          = 12884901888
        duration           = "60s"
        comparison         = "COMPARISON_GT"
        alignment_period   = "300s"
        per_series_aligner = "ALIGN_MEAN"
        count = 1
       cross_series_reducer = "REDUCE_SUM"
       auto_close = "604800s"
      documentation = "Memory Usage for cfr-dev-app-server in dev project"
}
"alertpolicy-11" ={
        display_name       = "cfr-dna-dev-database-cpu-util"
        condition_name     = "Conifer dev - Cloud SQL database CPU Util"
        filter             = "metric.type=\"cloudsql.googleapis.com/database/cpu/utilization\" resource.type=\"cloudsql_database\" resource.label.\"project_id\"=\"cfr-dna-hrcm-dev-project\" resource.label.\"database_id\"=\"cfr-dna-hrcm-dev-project:cfr-dev-data-server\""
        threshold          = 80
        duration           = "60s"
        comparison         = "COMPARISON_GT"
        alignment_period   = "300s"
        per_series_aligner = "ALIGN_MEAN"
        count = 1
       cross_series_reducer = "REDUCE_NONE"
       auto_close = "604800s"
      documentation = "CPU Utilization for cloud sql database in dev project"
}
"alertpolicy-12" ={
        display_name       = "cfr-dna-dev-database-disk-usage"
        condition_name     = "Conifer dev - Cloud SQL database disk usage"
        filter             = "metric.type=\"cloudsql.googleapis.com/database/disk/bytes_used\" resource.type=\"cloudsql_database\" resource.label.\"project_id\"=\"cfr-dna-hrcm-dev-project\" resource.label.\"database_id\"=\"cfr-dna-hrcm-dev-project:cfr-dev-data-server\""
        threshold          = 209715200
        duration           = "60s"
        comparison         = "COMPARISON_GT"
        alignment_period   = "300s"
        per_series_aligner = "ALIGN_MEAN"
        count = 1
       cross_series_reducer = "REDUCE_SUM"
       auto_close = "604800s"
      documentation = "Disk Bytes used for cloud sql database in dev project"
}
"alertpolicy-13" ={
        display_name       = "cfr-dna-dev-database-memory-util"
        condition_name     = "Conifer dev - Cloud SQL database memory util"
        filter             = "metric.type=\"cloudsql.googleapis.com/database/memory/utilization\" resource.type=\"cloudsql_database\" resource.label.\"project_id\"=\"cfr-dna-hrcm-dev-project\" resource.label.\"database_id\"=\"cfr-dna-hrcm-dev-project:cfr-dev-data-server\""
        threshold          = 62914560
        duration           = "60s"
        comparison         = "COMPARISON_GT"
        alignment_period   = "300s"
        per_series_aligner = "ALIGN_MEAN"
        count = 1
       cross_series_reducer = "REDUCE_NONE"
       auto_close = "604800s"
      documentation = "Memory Utilization for cloud sql database in dev project"
}
}
channel_details = {
   "email1" ={
   notificationdisplayname = "cfr-test-alert-email1"
   email = "charles.gamkong@tenethealth.com"
    }
}

#bq dataset creation
bq_dataset = {
     "dataset-1" = {
        dataset_id = "cfr_dna_dev_bq_logging"
        location = "US"
        project  = "cfr-org-logging-project"
    }
"dataset-2" = {
        dataset_id = "conifer_billing_export"
        location = "US"
        project  = "cfr-billing-project"//billing project id
    }
}
project_sink = {
  "cfr-dna-dev-bq-sink" = {
    destination = "bigquery.googleapis.com/projects/cfr-org-logging-project/datasets/cfr_dna_dev_bq_logging"
    filter = "resource.type = bigquery_resource"
    role = "roles/bigquery.dataEditor"
    source-project-id = "cfrdnahrcmdevdata"
  }
  "cfr-dna-dev-failed-worker-sink" = {
   destination = "bigquery.googleapis.com/projects/cfr-org-logging-project/datasets/cfr_dna_dev_bq_logging"
    filter = "resource.type=\"cloud_composer_environment\" AND log_name=\"projects/cfrdnahrcmdevproject/logs/airflow-worker\" textPayload=~\"Marking task as FAILED\" OR textPayload=~\"ERROR\" OR textPayload=~\"Failed to execute job\""
    role = "roles/bigquery.dataEditor"
    source-project-id = "cfr-dna-hrcm-dev-project"
}
}
project_sink1 = {
  "cfr-dna-dev-dataproc-sink" = {
    destination = "storage.googleapis.com/cfr-bkt-us-dataprocs-logs"
    filter = "resource.type=cloud_dataproc_cluster"
    role = "roles/storage.objectCreator"
    source-project-id = "cfr-dna-hrcm-dev-project"
    exclusion_name = "kill-job"
    exclusion_description = "Attempt to clean up jobs whose master is dead/invalid? For now, don't kill a job we don't own."
    exclusion_filter = "jsonPayload.message:\" Attempt to clean up jobs whose master is dead/invalid? For now, don't kill a job we don't own.\""
  }
}
log-projectid = "cfr-org-logging-project"
svc_acct_details = {
  "svc-acct-dna-dev-di-tool" = {
    display_name = "svc-acct-dna-dev-di-tool"
  }
}
alert_details = {
    "alertpolicy-1" ={
        alert_name       = "Quota usage - BigQuery API - Query usage per day - bigquery.googleapis.com/quota/query/usage"
        condition_name     = "Quota usage reached defined threshold"
        query             = "fetch consumer_quota|filter resource.project_id=='cfr-dna-hrcm-dev-project'|{metric serviceruntime.googleapis.com/quota/rate/net_usage|filter metric.quota_metric=='bigquery.googleapis.com/quota/query/usage'|map add [metric.limit_name: 'QueryUsagePerDay']|map add [day: end().timestamp_to_string('%Y%m%d', 'America/Los_Angeles').string_to_int64]|group_by 1d,.sum|map add [current_day: end().timestamp_to_string('%Y%m%d', 'America/Los_Angeles').string_to_int64]|group_by [resource.project_id,resource.service,metric.quota_metric,metric.limit_name];metric serviceruntime.googleapis.com/quota/limit|filter metric.quota_metric=='bigquery.googleapis.com/quota/query/usage'&&metric.limit_name=='QueryUsagePerDay'|group_by [resource.project_id,resource.service,metric.quota_metric,metric.limit_name],.min}|ratio|window 1d|every 30s|condition gt(val(), 0.8 '1')"
        duration           = "60s"
        count = 1
       auto_close = "604800s"
      documentation = "Quota usage - BigQuery API - Query usage per day."
    }
"alertpolicy-2" ={
        alert_name       = "cfr-dna-hrcm-dev-bigquery-high-query-cost"
        condition_name     = "conifer dev - ETL dev Project - Scanned Bytes Billed"
        query             = "fetch bigquery_project\n| metric 'bigquery.googleapis.com/query/statement_scanned_bytes_billed'\n| filter resource.project_id == 'cfrdnahrcmdevdata'\n| group_by 5m,\n    [value_statement_scanned_bytes_billed_aggregate:\n       aggregate(value.statement_scanned_bytes_billed)]\n| every 5m\n| group_by [metric.priority],\n    [value_statement_scanned_bytes_billed_aggregate_aggregate:\n       aggregate(value_statement_scanned_bytes_billed_aggregate)]\n| condition val() > 2.2e+13 'By'",
        duration           = "0s"
        count = 1
       auto_close = "604800s"
      documentation = "conifer dev - ETL dev Project - Scanned Bytes Billed"
    }
}
