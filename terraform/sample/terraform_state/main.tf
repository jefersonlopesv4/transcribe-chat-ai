terraform {
  required_version = ">= 0.14"

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

locals {
  environment  = "development"
  stack        = "sample-chat-ai"
  account_name = "sample-chat-ai"
  default_tags = {
    terraform   = "true"
    environment = local.environment
    stack       = local.stack
  }
}

provider "aws" {
  region = "us-east-1"
}
