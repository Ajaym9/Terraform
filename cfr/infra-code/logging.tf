#module block for bucket creation
module "bucket" {
    source = "./source/gcs"
    for_each = tomap(var.bucket_details)
    bucket_name = each.value.bucket_name
    location = each.value.location
    project = each.value.project
}

#module block for org level sink creation
module "org-sink" {
    source = "./source/logging/orgsink"
    for_each = tomap(var.org_sink)
    org_sinkname = each.value.org_sinkname
    description = each.value.description
    org_id = each.value.org_id
    destination = each.value.destination
    filter = each.value.filter
    log-projectid = each.value.log-projectid
    role = each.value.role
}

#module block for project level sink creation
module "project-logging-sink" {
    source      ="./source/logging/project-sink"
    for_each   = tomap(var.project_sink)
    sink_name = each.key
    source-project-id = each.value.source-project-id
    #destination = "bigquery.googleapis.com/projects/${var.log-projectid}/datasets/${each.value.datasetid}"
    destination = each.value.destination
    filter = each.value.filter
    role = each.value.role
    log-projectid = var.log-projectid
}

#module block for bigquery dataset creation
module "bigquery" {
    source        = "./source/dataset"
    for_each      = tomap(var.bq_dataset)
    dataset_id    = each.value.dataset_id
    location      = each.value.location
    project       = each.value.project
}

#module block for project level sink creation with exclusion filter
module "project-logging-sink1" {
    source      ="./source/logging/project-sink-with-exclusion"
    for_each   = tomap(var.project_sink1)
    sink_name = each.key
    source-project-id = each.value.source-project-id
    destination = each.value.destination
    filter = each.value.filter
    role = each.value.role
    exclusion_name = each.value.exclusion_name
    exclusion_description = each.value.exclusion_description
    exclusion_filter = each.value.exclusion_filter
    log-projectid = var.log-projectid
}
