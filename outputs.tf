output "Velociraptor_Public_IP" {
    value = module.app.ec2_public_ip
}

output "Velociraptor_Server_Domain" {
    value = local.dfir_subdomain
}

output "EFS_Private_DNS_Name" {
    value = module.app.efs_dns_name
}