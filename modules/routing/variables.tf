variable "dfir_domain" {
    description = "The base domain name to be used for deployment (must have a hosted zone in Route53). A subdomain will be created pointing to the EC2 server"
    type = string
}

variable "dfir_subdomain" {
    description = "The subdomain to point at the EC2"
    type = string
}

variable "ec2_public_ip" {
    description = "The public IPv4 address of the EC2"
    type = string
}