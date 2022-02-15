remote_state {
  backend = "gcs"
  config  = {
    location = "us"
    project = "${get_env("TF_VAR_project_id", "")}"
    bucket = "${get_env("TF_VAR_project_id", "")}_terraform-state"
    prefix = "${path_relative_to_include()}/"
  }
}

inputs = {
  project_id                               = "gke-demo3-edwinrea"
}

skip = true