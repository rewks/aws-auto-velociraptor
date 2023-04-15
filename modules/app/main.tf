##
# Create SSH key pair
# https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair
# https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file
##
resource "tls_private_key" "dfir-priv-key" {
    algorithm = "ECDSA"
    ecdsa_curve = "P521"
}

resource "aws_key_pair" "dfir-pub_key" {
    key_name_prefix = "dfir-"
    public_key = tls_private_key.dfir-priv-key.public_key_openssh
}

resource "local_file" "priv-key-out" {
    filename = "./.ssh/dfir.pem"
    file_permission = "0600"
    content = tls_private_key.dfir-priv-key.private_key_openssh
}