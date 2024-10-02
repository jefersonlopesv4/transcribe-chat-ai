output "bucket_arn" {
  description = "Terraform State Bucket ARN"
  value       = module.state.bucket_arn
}

output "bucket_name" {
  description = "Terraform State Bucket Name"
  value       = module.state.bucket_name
}

output "table_arn" {
  description = "Terraform Locks Table ARN"
  value       = module.state.table_arn
}

output "table_name" {
  description = "Terraform Locks Table Name"
  value       = module.state.table_name
}
