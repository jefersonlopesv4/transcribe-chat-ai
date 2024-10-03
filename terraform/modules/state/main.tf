resource "aws_kms_key" "terraform_state_bucket_key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

resource "aws_kms_alias" "key-alias" {
  name          = "alias/terraform-state-bucket-key"
  target_key_id = aws_kms_key.terraform_state_bucket_key.key_id
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "${var.name}-${var.environment}-terraform-up-and-running-state"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.terraform_state.bucket
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.terraform_state_bucket_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "block" {
  bucket                  = aws_s3_bucket.terraform_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_acl" "terraform_state_acl" {
  bucket     = aws_s3_bucket.terraform_state.id
  acl        = "private"
  depends_on = [aws_s3_bucket.terraform_state]
}

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.terraform_state.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "${var.name}-${var.environment}-terraform-up-and-running-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
