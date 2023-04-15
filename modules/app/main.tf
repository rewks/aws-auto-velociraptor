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
# Create security group and rules to restrict traffic to/from EC2 instance and EFS
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule
##
resource "aws_security_group" "dfir-ec2-secgrp" {
    vpc_id = var.dfir_vpc_id
    tags = {
        Name = "dfir-EC2-SG"
    }

    egress {
        description = "Allow all outbound traffic from EC2"
        protocol = "-1"
        from_port = 0
        to_port = 0
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    ingress {
        description = "Allow inbound SSH from admin IPs"
        protocol = "tcp"
        from_port = 22
        to_port = 22
        cidr_blocks = var.admin_ips
    }

    ingress {
        description = "Allow inbound GUI access from admin IPs"
        protocol = "tcp"
        from_port = 8080
        to_port = 8080
        cidr_blocks = var.admin_ips
    }

    ingress {
        description = "Allow inbound client connections from client IPs"
        protocol = "tcp"
        from_port = 8081
        to_port = 8081
        cidr_blocks = var.client_ips
    }
}

resource "aws_security_group" "dfir-efs-secgrp" {
    vpc_id = var.dfir_vpc_id
    tags = {
        Name = "dfir-EFS-SG"
    }

    ingress {
        description = "Allow inbound NFS traffic from members of the EC2 security group"
        protocol = "tcp"
        from_port = 2049
        to_port = 2049
        security_groups = [aws_security_group.dfir-ec2-secgrp.id]
    }
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
    file_system_id = aws_efs_file_system.dfir-efs.id
    subnet_id = var.dfir_subnet_id
    security_groups = [aws_security_group.dfir-efs-secgrp.id]
}