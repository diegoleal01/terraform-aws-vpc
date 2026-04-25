output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The ID of the VPC"
}

output "igw_id" {
  value       = module.vpc.igw_id
  description = "The ID of the Internet Gateway"
}

output "ngw_id" {
  value       = module.vpc.ngw_id
  description = "The ID of the NAT Gateway"
}

output "public_subnet_ids" {
  value       = module.vpc.public_subnet_ids
  description = "Map of Availability Zone name to public subnet ID"
}

output "private_subnet_ids" {
  value       = module.vpc.private_subnet_ids
  description = "Map of Availability Zone name to private subnet ID"
}