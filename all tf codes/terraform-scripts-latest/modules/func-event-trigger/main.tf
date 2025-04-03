data "archive_file" "source" {
  type        = "zip"
  source_dir  = var.source_path
  output_path = "/tmp/${var.function_name}-sourcecode.zip"
}


#######################################################################
#  Create a storage bucket object to store the source code zip file   #
#######################################################################

resource "google_storage_bucket_object" "source-code" {
  name   = "${var.function_name}-${data.archive_file.source.output_md5}"
  bucket = var.source_code_bucket
  source = data.archive_file.source.output_path
}

######################################################################
#    Create a Cloud storage event resource bucket and cloud function #
######################################################################

resource "google_storage_bucket" "bucket" {
  name     = var.trigger_bucket	
  location = var.gcp_region	
  project  = var.project_id
}

resource "google_cloudfunctions_function" "function" {
  name                  = var.function_name
  description           = var.function_des
  runtime               = var.runtime
  project               = var.project_id
  available_memory_mb   = var.memory
  source_archive_bucket = var.source_code_bucket
  source_archive_object = google_storage_bucket_object.source-code.name
  entry_point           = var.entry_point
 event_trigger {
    event_type = var.event_type 
    resource   = var.event_resource 
  }
  region                = var.gcp_region
  depends_on            = [google_storage_bucket_object.source-code, google_storage_bucket.bucket]
}

# IAM entry for all users to invoke the function

resource "google_cloudfunctions_function_iam_member" "invoker" {
for_each = toset(var.cloud_func_member)  
project        = var.project_id
  region         = var.gcp_region
  cloud_function = google_cloudfunctions_function.function.name

  role       = var.cloud_func_role   #"roles/cloudfunctions.invoker"
  member     = each.value #"allUsers"
  depends_on = [google_cloudfunctions_function.function]
}
