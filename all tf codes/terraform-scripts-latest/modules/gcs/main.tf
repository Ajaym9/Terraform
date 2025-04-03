#multiple lifecycle blocks wth dynamic####
#########################################


locals {
  prefix = (
    var.prefix == null || var.prefix == "" # keep "" for backward compatibility
    ? ""
    : "${var.prefix}-"
  )
  notification = try(var.notification_config.enabled, false)
}

resource "google_storage_bucket" "bucket" {
  name                        = "${local.prefix}${lower(var.name)}"
  project                     = var.project_id
  location                    = var.location
  storage_class               = var.storage_class
  force_destroy               = var.force_destroy
  uniform_bucket_level_access = var.uniform_bucket_level_access
  labels                      = var.labels
  versioning {
    enabled = var.versioning
  }

  dynamic "website" {
    for_each = var.website == null ? [] : [""]

    content {
      main_page_suffix = var.website.main_page_suffix
      not_found_page   = var.website.not_found_page
    }
  }

  dynamic "encryption" {
    for_each = var.encryption_key == null ? [] : [""]

    content {
      default_kms_key_name = var.encryption_key
    }
  }

  dynamic "retention_policy" {
    for_each = var.retention_policy == null ? [] : [""]
    content {
      retention_period = var.retention_policy.retention_period
      is_locked        = var.retention_policy.is_locked
    }
  }

  dynamic "logging" {
    for_each = var.logging_config == null ? [] : [""]
    content {
      log_bucket        = var.logging_config.log_bucket
      log_object_prefix = var.logging_config.log_object_prefix
    }
  }

  dynamic "cors" {
    for_each = var.cors == null ? [] : [""]
    content {
      origin          = var.cors.origin
      method          = var.cors.method
      response_header = var.cors.response_header
      max_age_seconds = max(3600, var.cors.max_age_seconds)
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rule #== null ? [] : [""]
    content {
      action {
        type          = lifecycle_rule.value.action["type"]
        storage_class = lifecycle_rule.value.action["storage_class"]
      }
      condition {
        age                        = lifecycle_rule.value.condition["age"]
        created_before             = lifecycle_rule.value.condition["created_before"]
        with_state                 = lifecycle_rule.value.condition["with_state"]
        matches_storage_class      = lifecycle_rule.value.condition["matches_storage_class"]
        num_newer_versions         = lifecycle_rule.value.condition["num_newer_versions"]
        custom_time_before         = lifecycle_rule.value.condition["custom_time_before"]
        days_since_custom_time     = lifecycle_rule.value.condition["days_since_custom_time"]
        days_since_noncurrent_time = lifecycle_rule.value.condition["days_since_noncurrent_time"]
        noncurrent_time_before     = lifecycle_rule.value.condition["noncurrent_time_before"]
      }
    }
  }
}

resource "google_storage_bucket_iam_member" "bindings" {
  for_each = var.iam
  bucket   = google_storage_bucket.bucket.name
  role     = each.key
  member   = each.value
}

resource "google_storage_bucket_object" "object" {
count = var.object_name ==null ? 0 : 1  
name   = var.object_name
  bucket = google_storage_bucket.bucket.name
  source = var.bucket_source
}

