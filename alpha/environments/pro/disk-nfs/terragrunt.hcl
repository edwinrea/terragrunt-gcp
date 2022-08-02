terraform {
  source = "../../..//modules/disk-nfs/"
}

include {
  path = find_in_parent_folders()
}
