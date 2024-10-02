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
  stack        = "sample-chatia"
  account_name = "sample-chatia"
  default_tags = {
    terraform   = "true"
    environment = local.environment
    stack       = local.stack
  }
}

provider "aws" {
  region = "us-east-1"
}
