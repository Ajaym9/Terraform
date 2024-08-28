resource "aws_iam_user" "example" {
  count = length(var.user_names)
  name  = var.user_names[count.index]
}



#############################GCS bucket############

resource "google_storage_bucket" "bucket" {
  count         = length(var.buckets)
  name          = var.buckets[count.index]              #"image-store.com"
  location      = var.location                          #"EU"
  force_destroy = var.force_destroy                     #true
}