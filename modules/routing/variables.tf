variable "dfir_domain" {
    description = "The base domain name to be used for deployment (must have a hosted zone in Route53). A subdomain will be created pointing to the EC2 server"
    type = string
}