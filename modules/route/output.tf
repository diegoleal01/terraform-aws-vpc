output "private_rtb_id" {
  value       = aws_route_table.private_rtb.id
  description = "The ID of the private route table"
}

output "public_rtb_id" {
  value       = aws_route_table.public_rtb.id
  description = "The ID of the public route table"
}