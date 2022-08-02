terraform {
  source = "../../..//modules/bucket/"
}

inputs = {
  bucket_name              = "${get_env("BUCKET_NAME", "")}"
}