##################################################################
#          create a storage notification                         #
##################################################################

resource "google_storage_notification" "notification" {
  provider       = google-beta
  bucket         = var.bucket_name
  payload_format = var.payload_format   
  topic          = var.pubsub_topic 
}



