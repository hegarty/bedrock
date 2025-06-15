locals {
  account_name   = "ops-bedrock" #account-name + purpose
  aws_account_id = = get_env("OPS_BEDROCK_ACCOUNT_ID")
}
