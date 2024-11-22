provider "aws" {
  region = "us-east-1"
}

# Define the module call with variables
module "vpc" {
  source       = "./modules/vpc"
  vpc_name     = var.vpc_name
  cidr_block   = var.cidr_block
  enable_dns   = true
}

output "vpc_id" {
  value = module.vpc.vpc_id
}
