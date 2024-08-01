provider "aws" {
    region = "us-west-2"
  
}

module "mymodule" {
    source = "../modules/vpc"
    vpc_cidr = var.prodcidr
  
}