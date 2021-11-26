provider "aws" {
  region = var.region
}
#------------------------------------------------------------------------------
# Terraform settings
#------------------------------------------------------------------------------
terraform {
  required_providers {
    aws = "<= 3.53.0"
  }
  backend "s3" {}   
  #backend "local" {}
}
module "networking" {
  source  = "./modules/networking"
  name    = local.name
  owner   = local.owner
  enabled = local.enabled
}
