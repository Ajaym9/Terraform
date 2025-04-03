#######################################################################
#              Enable a FIRESTORE Database			      #
#######################################################################

resource "google_firestore_document" "mydoc" {
  project     = var.project_id
  collection  = var.collection
  document_id = var.document_id
  fields      = var.fields
  provisioner "local-exec" {
    command = "gcloud beta firestore fields ttls update google_firestore_document.mydoc.document_id --collection-group=google_firestore_document.mydoc.collection --enable-ttl"
  }
}


