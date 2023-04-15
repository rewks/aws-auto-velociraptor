variable "ec2_size" {
    description = "The size of the EC2 instance to provision"
    type = string
}

variable "ec2_ami" {
    description = "The AMI to install on the EC2"
    type = string
}

variable "dfir_vpc_id" {
    description = "The id of the VPC to attach resources to"
    type = string
}

variable "dfir_subnet_id" {
    description = "The id of the Subnet to place resources in"
    type = string
}

variable "deployment_name" {
    description = "Unique name/id to use for this deployment"
    type = string
}

variable "admin_ips" {
    description = "IP ranges for administrative access"
    type = list(string)
}

variable "client_ips" {
    description = "IP ranges client connections will originate from"
    type = list(string)
}