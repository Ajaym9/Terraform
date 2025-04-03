variable "folder_id" {
  type = string
}
variable "ip_version" {
  type = string
}
variable "billing_id" {
  type = string
}
variable "host-project" {
  type = string
}
variable "instance_details" {
  type = map(object({
    vm_name         = string
    zone            = string
    machine_type    = string
    network         = string
    subnetwork      = string
    service_account = string
    disk_size       = string
    image           = string
  }))
}

variable "sql_details" {
  type = map(object({
    sql_name         = string
    sql_region       = string
    sql_tier         = string
    database_version = string
    network          = string
  }))
}

variable "tags" {
  type = list(string)
}

variable "ip_name" {
  type = string
}

variable "ip_purpose" {
  type = string
}

variable "ip_type" {
  type = string
}

variable "name" {
  type = string
}

variable "password" {
  type = string
}

variable "subnet_details" {
    type = map(object({
    vpc_name = string
    ip_range = string
    region = string
    private_ip_google_access = string
}))
}

variable "secipsubnet_details" {
    type = map(object({
    vpc_name = string
    ip_range = string
    region = string
    sec_ip_range = string
    range_name = string
    range_name_2 = string
    sec_ip_range_2 = string
}))
}
variable "composer_config" {
    type = map(object({
    project_id = string
    region = string
    resilience_mode = string
    envsize = string
    network = string
    subnetwork = string
    service_account = string
    cluster_secrange_name = string
    servicessecrange_name = string
    connection_type = string
    privateendpoint = string
    image_version = string
    clouddatalineage = string
    scheduler_cpu  = string
    scheduler_mem = string
    scheduler_sto = string
    scheduler_count  = string
    web_server_cpu = string
    web_server_mem = string
    web_server_sto = string
    worker_cpu = string
    worker_mem = string
    worker_sto = string
    worker_mincount= string
    worker_maxcount = string
}))
}
variable "iam" {
    type = map(object({
    project_id = string
    roles = string
    members = string
}))
}
variable "sa_iam" {
    type = map(object({
    project_id = string
    roles = string
    members = string
}))
}
variable "folder_details" {
  type =list(string)
}

variable "folder_name1" {
  type = string
}

variable "org_id" {
  type = string
}
variable "dev_project_details" {
  type = map(string)
}
variable "serviceproject_id" {
  type = list(string)
}
variable "svcacct_details" {
    type = map(object({
    display_name = string
}))
}
variable "enable_api" {
type = map(string)
}
variable "test_project_details" {
  type = map(string)
}
variable "prod_project_details" {
  type = map(string)
}
variable "enable_api1" {
    type = map(object({
    apiname = string
    project_id = string
}))
}
variable "bucket_details" {
  type = map(object({
    bucket_name = string
    location = string
    project = string
}))
}
variable "org_sink" {
    type = map(object({
    org_sinkname = string
    description = string
    org_id = string
    filter = string
    log-projectid = string
    role = string
    destination = string
}))
}
variable "dashboard_file_name" {
  type = list(string)
}
variable "monitoring_project_id" {
type = string
}
variable "details" {
  type = map(object({
    display_name = string
    condition_name =string
    threshold = string
    filter =string
    duration =string
    comparison =string
    alignment_period = string
    per_series_aligner = string
   documentation = string
    count = number
    cross_series_reducer = string
    auto_close = string
}))
}
variable "channel_details" {
  type =  map(object({
      notificationdisplayname = string
      email = string
  }))
}
variable "project_sink" {
 type = map(object({
  destination = string
  role = string
  filter = string
  source-project-id = string
}))
}
variable "log-projectid" {
 type = string
}
variable "bq_dataset" {
    type = map(object({
       dataset_id = string
       location = string
       project = string
}))
}
variable "svc_acct_details" {
    type = map(object({
    display_name = string
}))
}
variable "project_sink1" {
type = map(object({
  destination = string
  role = string
  filter = string
  source-project-id = string
  exclusion_name = string
  exclusion_description = string
  exclusion_filter = string
}))
}
variable "alert_details" {
  type = map(object({
    alert_name = string
    condition_name =string
    query =string
    duration =string
    documentation = string
    count = string
    auto_close = string
}))
}
