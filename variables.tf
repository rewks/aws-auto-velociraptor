variable "aws_region" {
    description = "The region within AWS that resources are to be deployed to"
    type = string
    default = "eu-west-2"
}

##
# Networking module
##
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

##
# App module
##

# https://aws.amazon.com/ec2/instance-types/
variable "ec2_size" {
    description = "The size of the EC2 instance to provision"
    type = string
    default = "t3a.large"   # 2 core, 8gb ram, AMD EPYC 7000 series
}

# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html
variable "ec2_ami" {
    description = "The AMI to install on the EC2"
    type = string
    default = "ami-09744628bed84e434"   # Ubuntu 22.04 LTS amd64 (eu-west-2), 20230325
}