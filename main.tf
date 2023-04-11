terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 4.0"
        }
    }
}

provider "aws" {
    region = var.aws_region
}

module "networking" {
    source = "./modules/networking"
    vpc_name_tag = var.vpc_name_tag
    subnet_name_tag = var.subnet_name_tag
}