terraform {
  backend "remote" {
    organization = "honestbank"

    workspaces {
      name = "terraform-aws-eks"
    }
  }
  required_version = "~> 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.52.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.4.1"
    }
  }
}
