output "vpc_id" {
  value       = aws_vpc.this.id
  description = "The ID of the VPC"
}

output "igw_id" {
  value       = aws_internet_gateway.this.id
  description = "The ID of the Internet Gateway"
}

output "ngw_id" {
  value       = aws_nat_gateway.this.id
  description = "The ID of the NAT Gateway"
}

output "public_subnet_ids" {
  value = {
    for i, public_subnet_id in aws_subnet.public_subnet : i => public_subnet_id.id
  }
  description = "Map of Availability Zone name to public subnet ID"
}

output "private_subnet_ids" {
  value = {
    for i, private_subnet_id in aws_subnet.private_subnet : i => private_subnet_id.id
  }
  description = "Map of Availability Zone name to private subnet ID"
}