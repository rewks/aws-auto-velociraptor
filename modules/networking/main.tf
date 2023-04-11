##
# Creates a data source pointing to the DFIR VPC, matched by the Name tag
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc
##
data "aws_vpc" "dfir-vpc" {
    tags = {
        Name = "${var.vpc_name_tag}"
    }
}

##
# Creates a data source pointing to the DFIR Subnet, matched by the Name tag
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet
##
data "aws_subnet" "dfir-subnet" {
    tags = {
        Name = "${var.subnet_name_tag}"
    }
}