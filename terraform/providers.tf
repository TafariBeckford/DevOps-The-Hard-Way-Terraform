terraform {
  cloud {
    organization = "tafari"

    workspaces {

      name = "DevOps-The-Hard-Way-ArgoCD"

    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region

}

