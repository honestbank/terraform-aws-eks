terraform {
  backend "remote" {
    organization = "honestbank"

    workspaces {
      name = "terraform-aws-eks"
    }
  }
}
