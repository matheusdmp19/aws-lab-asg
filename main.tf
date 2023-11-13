terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.25.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      owner      = "matheus.pinho"
      managed-by = "terraform"
      app        = "lab-asg"
    }
  }
}
