############################GCS#############


resource "google_storage_bucket" "bucket" {
    for_each        =   toset(var.bucket_names)
    name            =   each.value
    location        =   var.location
    force_destroy   = var.force_destroy
}
