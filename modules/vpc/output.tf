output "vpc_id" {
  value = aws_vpc.this.id
}

output "igw_id" {
  value = aws_internet_gateway.this.id
}

output "ngw_id" {
  value = aws_nat_gateway.this.id
}

output "public_subnet_id" {
  value = tomap({
    for i, public_subnet_id in aws_subnet.public_subnet : i => public_subnet_id.id
  })
}

output "private_subnet_id" {
  value = tomap({
    for i, private_subnet_id in aws_subnet.private_subnet : i => private_subnet_id.id
  })
}