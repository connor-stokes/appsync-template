terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.11.0"
    }
  }
}

provider "aws" {
  profile = "connor_aws"
  region  = "eu-west-2"
}

locals {
  name = "botherdemo"
}
