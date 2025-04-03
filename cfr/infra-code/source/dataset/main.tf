//creating a bigquery dataset
 
resource "google_bigquery_dataset" "dataset" {
    dataset_id                  = var.dataset_id
    location                    = var.location
    project                     = var.project
}
