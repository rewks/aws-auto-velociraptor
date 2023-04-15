output "ec2_public_ip" {
    value = aws_instance.dfir-ec2.public_ip
}

output "efs_dns_name" {
    value = aws_efs_file_system.dfir-efs.dns_name
}