variable "aws_region" {
    description = "The region within AWS that resources are to be deployed to"
    type = string
    default = "eu-west-2"
}

variable "vpc_name_tag" {
    description = "The name tag of the VPC"
    type = string
    default = "dfir-vpc"
}

variable "subnet_name_tag" {
    description = "The name tag of the Subnet"
    type = string
    default = "dfir-subnet-public1-eu-west-2a"
}