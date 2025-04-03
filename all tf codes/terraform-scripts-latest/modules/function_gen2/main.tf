data "archive_file" "source" {
  type        = "zip"
  source_dir  = var.source_path
  output_path = "/tmp/${var.function_name}-sourcecode.zip"
}

resource "google_storage_bucket" "bucket" {
  name     = var.function_source_bucket 
  location = var.bucket_location 
 project = var.project_id
}

resource "google_storage_bucket_object" "object" {
  name   = var.object_name		
  bucket = google_storage_bucket.bucket.name
  source = data.archive_file.source.output_path		  
}

resource "google_cloudfunctions2_function" "function" {
  name = var.function_name		
  location = var.function_location		
  description = var.function_description	
  project = var.project_id	
  build_config {
    runtime = var.runtime	
    entry_point = var.entry_point	
    source {
      storage_source {
        bucket = google_storage_bucket.bucket.name
        object = google_storage_bucket_object.object.name
      }
    }
  }

  service_config {
    max_instance_count  = var.instance_count	
    available_memory    = var.available_memory 
    timeout_seconds     = var.timeout_seconds 		
  }
}


resource "google_cloud_run_service_iam_member" "member" {
  for_each = toset(var.function_roles)
  location = google_cloudfunctions2_function.function.location
  project = var.project_id
  service = google_cloudfunctions2_function.function.name
  role = each.value	
  member = var.member
}



