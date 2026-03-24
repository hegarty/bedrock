locals {
  account_id = include.root.locals.account_id
}

include "root" {
  path= find_in_parent_folders("root.hcl")
  expose = true
}

dependency "agent" {
  config_path = "../zed-claude-agent"
}

terraform {
  source = format(include.root.locals.module_source, "bedrock/alias")
}

inputs = {
  alias_name  = "Zed-Claude-dev"
  agent_id    = dependency.agent.outputs.zed-claude-agent.agent_id
  description = "Interface between Zed and Claude via Bedrock"
}
