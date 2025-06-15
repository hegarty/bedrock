locals {
account_id = include.root.locals.account_id
}

include "root" {
  path= find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = format(include.root.locals.module_source, "iam")
}

inputs = {
  role_name= "bedrock"
  policy_name= "bedrock_policy"
  policy_description= "Grants permissions to interact with Amazon Bedrock services, including invoking foundation models and agents, if the principal (user or service) is authenticated"

  assume_role_policy = {
    Version = "2012-10-17",
    Statement = [
    {
      Effect = "Allow",
      Principal = {
        Service = "codebuild.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  }

  policy = {
    "Version" = "2012-10-17"
    "Statement" = [
      {
        "Sid" = "AllowBedrockModelInvocation"
        "Effect" = "Allow"
        "Action" = [
          "bedrock:InvokeModel",
          "bedrock:InvokeModelWithResponseStream"
        ]
        "Resource" = "*"
      },
      {
        "Sid" = "AllowFoundationModelAccess"
        "Effect" = "Allow"
        "Action" = [
          "bedrock:ListFoundationModels",
          "bedrock:GetFoundationModel"
        ]
        "Resource" = "*"
      },
      {
        "Sid" = "AllowBedrockAgentAccess"
        "Effect" = "Allow"
        "Action" = [
          "bedrock:ListAgents",
          "bedrock:GetAgent",
          "bedrock:InvokeAgent"
        ]
        "Resource" = "*"
      }
    ]
  }
}
