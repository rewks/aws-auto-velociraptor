##
# Get a handle to the hosted zone in Route53
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone
##
data "aws_route53_zone" "dfir-zone" {
    name = "${var.dfir_domain}"
}

##
# Create a DNS record
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record
##
resource "aws_route53_record" "dfir-dns" {
    zone_id = data.aws_route53_zone.dfir-zone.zone_id
    name = "${var.dfir_subdomain}"
    type = "A"
    ttl = "300"
    records = [var.ec2_public_ip]
}