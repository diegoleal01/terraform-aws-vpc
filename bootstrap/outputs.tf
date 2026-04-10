output "bucket_name" {
  description = "Name of the S3 bucket created to store Terraform remote states"
  value       = aws_s3_bucket.terraform_state.bucket
}

output "dynamodb_table" {
  description = "Name of the DynamoDB table created for Terraform state locking"
  value       = aws_dynamodb_table.terraform_locks.name
}

output "bucket_region" {
  description = "AWS region where the Terraform state bucket is deployed"
  value       = aws_s3_bucket.terraform_state.region
}