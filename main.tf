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

locals {
    dfir_subdomain = "dfir-${var.deployment_name}.${var.dfir_domain}"
}

module "routing" {
    source = "./modules/routing"
    dfir_domain = var.dfir_domain
    dfir_subdomain = local.dfir_subdomain
    ec2_public_ip = module.app.ec2_public_ip
}

resource "local_file" "ansible-vars" {
    filename = "./ansible/vars/from_terraform.yaml"
    file_permission = "0664"
    content = "domain: ${local.dfir_subdomain}\nefs_dns_name: ${module.app.efs_dns_name}"
}