output "Velociraptor_Public_IP" {
    value = module.app.ec2_public_ip
}

output "Velociraptor_Server_Domain" {
    value = local.dfir_subdomain
}