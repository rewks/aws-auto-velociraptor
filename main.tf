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

module "app" {
    source = "./modules/app"
    ec2_size = var.ec2_size
    ec2_ami = var.ec2_ami
    dfir_vpc_id = module.networking.dfir_vpc_id
    dfir_subnet_id = module.networking.dfir_subnet_id
    deployment_name = var.deployment_name
    admin_ips = var.admin_ips
    client_ips = var.client_ips
}