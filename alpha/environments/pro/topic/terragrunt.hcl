terraform {
  source = "../../..//modules/topic/"
}

include {
  path = find_in_parent_folders()
}
