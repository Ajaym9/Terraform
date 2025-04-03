#module block for folder level-1 creation
module "folder-1"{
    source ="./source/tenancy/folder"
    folder_name = var.folder_name1
    parent = "organizations/${var.org_id}"
}

#module block for folder level-2 creation
module "folder-2"{
    source ="./source/tenancy/folder"
    for_each = toset(var.folder_details)
    folder_name = each.value
    parent = "folders/${module.folder-1.folder_id}"
    depends_on = [ module.folder-1 ]
}

#module block for dev projects creation
module "dev-project" {
  source       = "./source/tenancy/projects"
  for_each     = tomap(var.dev_project_details)
  project_name = each.value
  billing_id = var.billing_id
  folder_id  = module.folder-2["cfr-dna-dev-folder"].folder_id
  depends_on = [ module.folder-2 ]
}

#module block for test projects creation
module "test-project" {
  source       = "./source/tenancy/projects"
  for_each     = tomap(var.test_project_details)
  project_name = each.value
  billing_id = var.billing_id
  folder_id  = module.folder-2["cfr-dna-test-folder"].folder_id
  depends_on = [ module.folder-2 ]
}

#module block for prod projects creation
module "prod-project" {
  source       = "./source/tenancy/projects"
  for_each     = tomap(var.prod_project_details)
  project_name = each.value
  billing_id = var.billing_id
  folder_id  = module.folder-2["cfr-dna-prod-folder"].folder_id
  depends_on = [ module.folder-2 ]
}
