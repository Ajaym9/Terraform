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
  bucket = var.gcs_bucket
  source = data.archive_file.source.output_path
}


#######################################################################
#     Create a cloud function to export billing data to csv file      #
#######################################################################

resource "google_cloudfunctions_function" "function" {
  name                  = var.function_name
  description           = var.function_des
  runtime               = var.runtime
  project               = var.project_id
  available_memory_mb   = var.memory
  source_archive_bucket = var.gcs_bucket
  source_archive_object = google_storage_bucket_object.source-code.name
  trigger_http          = var.trigger_http
  entry_point           = var.entry_point
  region                = var.gcp_region
  depends_on            = [google_storage_bucket_object.source-code]
}

# IAM entry for all users to invoke the function

resource "google_cloudfunctions_function_iam_member" "invoker" {
  project        = var.project_id
  region         = var.gcp_region
  cloud_function = google_cloudfunctions_function.function.name

  role       = var.cloud_func_role   #"roles/cloudfunctions.invoker"
  member     = var.cloud_func_member #"allUsers"
  depends_on = [google_cloudfunctions_function.function]
}
