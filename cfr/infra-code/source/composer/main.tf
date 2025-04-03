  resource "google_composer_environment" "composer2" {
  provider = google-beta
  for_each = tomap(var.composer_config)
  project = each.value.project_id 
  name = each.key 
  region = each.value.region 
  labels ={
   "env" = "dev"
}
  config {
    resilience_mode = each.value.resilience_mode 
    environment_size = each.value.envsize
    workloads_config {
      scheduler {
        cpu        = each.value.scheduler_cpu      
        memory_gb  = each.value.scheduler_mem      
        storage_gb = each.value.scheduler_sto        
        count      = each.value.scheduler_count      
      }
      web_server {
        cpu        = each.value.web_server_cpu
        memory_gb  = each.value.web_server_mem
        storage_gb = each.value.web_server_sto  
      }
      worker {
        cpu = each.value.worker_cpu
        memory_gb  = each.value.worker_mem
        storage_gb = each.value.worker_sto
        min_count  =each.value.worker_mincount
        max_count  = each.value.worker_maxcount  
      }
    }
    node_config {
      network    = "projects/${var.host-project}/global/networks/${each.value.network}" 
      subnetwork = "projects/${var.host-project}/regions/us-central1/subnetworks/${each.value.subnetwork}"
      service_account = each.value.service_account 
      ip_allocation_policy {
        cluster_secondary_range_name = each.value.cluster_secrange_name 
        services_secondary_range_name = each.value.servicessecrange_name 
      }
    }
    private_environment_config {
      connection_type  = each.value.connection_type 
      enable_private_endpoint = each.value.privateendpoint 
      }
    software_config {
        image_version = each.value.image_version 
        cloud_data_lineage_integration {
                enabled = each.value.clouddatalineage 
}     
      pypi_packages = {
          numpy             = ">=1.23.2"  
          pandas            = ">=1.4.3"
          openpyxl          = ">=3.0.10"
          python-dateutil   = ">=2.8.2"
          pytz              = ">=2022.2.1"
      }
    }
}
}
