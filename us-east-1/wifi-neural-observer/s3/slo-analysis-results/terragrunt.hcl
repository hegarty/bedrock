include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = format(include.root.locals.module_source, "s3")
}

inputs = {
  bucket_name        = "edge-monitor-slo-analyses-${include.root.locals.account_vars.locals.aws_account_id}"
  versioning_enabled = true
  force_destroy      = false
  tags = {
    project     = "wifi-neural-observer"
    environment = "dev"
    managed-by  = "terragrunt"
  }
}
