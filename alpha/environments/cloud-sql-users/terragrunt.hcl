terraform {
  source = "../../..//modules/cloud-sql-users/"
}

include {
  path = find_in_parent_folders()
}

dependency "cloud-sql" {
  config_path = "../cloud-sql"
}

inputs = {
  instance_name          = dependency.cloud-sql.outputs.instance_name
}

