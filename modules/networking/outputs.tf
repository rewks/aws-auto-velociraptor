output "dfir_vpc_id" {
    value = data.aws_vpc.dfir-vpc.id
}

output "dfir_subnet_id" {
    value = data.aws_subnet.dfir-subnet.id
}