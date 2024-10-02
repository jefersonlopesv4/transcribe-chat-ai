output "bucket_arn" {
  description = "Terraform State Bucket ARN"
  value       = aws_s3_bucket.terraform_state.arn
}

output "bucket_name" {
  description = "Terraform State Bucket ARN"
  value       = aws_s3_bucket.terraform_state.bucket
}

output "table_arn" {
  description = "Terraform Locks Table ARN"
  value       = aws_dynamodb_table.terraform_locks.arn
}

output "table_name" {
  description = "Terraform Locks Table ARN"
  value       = aws_dynamodb_table.terraform_locks.name
}
