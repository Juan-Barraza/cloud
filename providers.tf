terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~>4.36.0"
    }
    random = {
      source = "hashicorp/random"
      version = "~>3.4.3"
    }
  }
  required_version = "~>1.15.0"
}

provider "aws" {
  region = var.aws_region_virginia
  access_key = var.access_key
  secret_key = var.secret_key
  default_tags {
    tags = var.tags
  }
}

