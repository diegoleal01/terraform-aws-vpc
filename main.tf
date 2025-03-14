provider "aws" {
  region  = var.region_id
  profile = var.cli_profile
}

terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket  = ""
    key     = ""
    region  = ""
    profile = ""
  }
}