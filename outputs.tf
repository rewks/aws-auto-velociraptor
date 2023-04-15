output "Velociraptor Public IP" {
    value = module.app.ec2_public_ip
}

output "Velociraptor Server Domain" {
    value = local.dfir_subdomain
}

output "EFS Private DNS Name" {
    value = module.app.efs_dns_name
}