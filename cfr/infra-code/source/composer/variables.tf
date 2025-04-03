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
    #allowed_iprange1 = string
    #allowed_ipdesc1 = string
    #allowed_iprange2 = string
    #allowed_ipdesc2 = string
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
variable "host-project" {
type = string
}
