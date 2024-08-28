module "vm"{
    source = "./modules"
    for_each = var.instances
    instance_name = each.key
    machine_type = each.value.machine_type
    project_id = each.value.project_id
    zone = each.value.zone
    image=each.value.image
    network = each.value.network   
}