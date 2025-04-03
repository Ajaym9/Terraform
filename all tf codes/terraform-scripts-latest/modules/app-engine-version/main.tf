##############################################################
#              Create App engine service                     #
##############################################################

resource "google_app_engine_standard_app_version" "myapp_v1" {
  project    = var.project_id
  version_id = var.app_versions
  service    = var.service
  runtime    = var.runtime
  entrypoint {
    shell = var.entrypoint_shell
  }

  deployment {
    zip {
      source_url = var.source_url
    }
}
handlers {
     auth_fail_action = var.auth_fail_action
        login            = var.login		
        security_level   = var.security_level
    url_regex = "/"
    static_files {
      application_readable  = var.application_readable	
            expiration            = var.expiration 
            http_headers          = {}
      require_matching_file = var.require_matching_file
      path              = var.index_path	
      upload_path_regex = var.upload_index_path		
    }
  }
  handlers {
   auth_fail_action = var.auth_fail_action
        login            = var.login
        security_level   = var.security_level
    url_regex = "/(.*)"
    static_files {
     application_readable  = var.application_readable	
            expiration            =  var.expiration 
            http_headers          = {}
      path              = "\\1"
      require_matching_file = var.require_matching_file
      upload_path_regex = ".*"
    }

  }
 handlers {
        auth_fail_action = var.auth_fail_action
        login            = var.login
        security_level   = var.security_level
        url_regex        = ".*"

        script {
            script_path = var.script_path	
        }
}
  
env_variables = var.env_variables

  automatic_scaling {
    max_concurrent_requests = var.max_concurrent_requests
    min_idle_instances      = var.min_idle_instances
    max_idle_instances      = var.max_idle_instances
    min_pending_latency     = var.min_pending_latency
    max_pending_latency     = var.max_pending_latency
    standard_scheduler_settings {
      target_cpu_utilization        = var.cpu_utilization
      target_throughput_utilization = var.throughput_utilization
      min_instances                 = var.min_instances
      max_instances                 = var.max_instances
    }
  }

  delete_service_on_destroy = var.delete_service_on_destroy
  noop_on_destroy           = var.noop_on_destroy
  service_account           = var.service_account_email
}

