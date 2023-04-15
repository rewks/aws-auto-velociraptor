##
# Create SSH key pair
# https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair
# https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file
##
resource "tls_private_key" "dfir-priv-key" {
    algorithm = "ECDSA"
    ecdsa_curve = "P521"
}

resource "aws_key_pair" "dfir-pub_key" {
    key_name_prefix = "dfir-"
    public_key = tls_private_key.dfir-priv-key.public_key_openssh
}

resource "local_sensitive_file" "priv-key-out" {
    filename = "./.ssh/dfir.pem"
    file_permission = "0600"
    content = tls_private_key.dfir-priv-key.private_key_openssh
}

##
# Create EFS data store and mount point
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target
##
resource "aws_efs_file_system" "dfir-efs" {
    encrypted = true
    tags = {
        Name = "dfir-EFS"
    }
}

resource "aws_efs_mount_target" "dfir-efs-mount" {
    file_system_id = aws_efs_file_system.dfir-efs
    subnet_id = var.dfir_subnet_id
    security_groups = [aws_security_group.dfir-efs-secgrp.id]
}