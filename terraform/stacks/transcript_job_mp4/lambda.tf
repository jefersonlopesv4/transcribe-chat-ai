data "archive_file" "this" {
  type             = "zip"
  source_file      = "${path.module}/${local.source_file}"
  output_file_mode = "0666"
  output_path      = "${path.module}/outputs/bin/${local.source_file}.zip"
}

resource "aws_lambda_function" "this" {
  filename         = data.archive_file.this.output_path
  function_name    = local.function_name
  description      = local.function_description
  handler          = local.lambda_handler
  source_code_hash = data.archive_file.this.output_base64sha256
  role             = aws_iam_role.this.arn
  runtime          = local.runtime
  timeout          = local.timeout
  memory_size      = local.memory_size
  publish          = local.enable_lambda_version

  environment {
    variables = {
      OUTPUT_BUCKET = aws_s3_bucket.transcript_bucket.id
    }
  }
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/lambda/${aws_lambda_function.this.function_name}"
  retention_in_days = 3
}

# Bucket S3 de origem (para vídeos)
resource "aws_s3_bucket" "video_bucket" {
  bucket = "${local.environment}-transcribe-job-mp4-video-bucket"
  force_destroy = true
}

# Bucket S3 de destino (para transcrições)
resource "aws_s3_bucket" "transcript_bucket" {
  bucket = "${local.environment}-transcribe-job-mp4-transcriptions-bucket"
  force_destroy = true
}

# Política IAM para o Lambda
resource "aws_iam_role" "this" {
  name = "${local.environment}_transcribe_job_mp4_lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Anexar políticas necessárias à role do Lambda
resource "aws_iam_role_policy_attachment" "lambda_transcribe_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonTranscribeFullAccess"
  role       = aws_iam_role.this.name
}

resource "aws_iam_role_policy_attachment" "lambda_s3_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role       = aws_iam_role.this.name
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.this.name
}

# S3 Bucket Notification para acionar o Lambda
resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.video_bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.this.arn
    events              = ["s3:ObjectCreated:*"]
    filter_suffix       = ".mp4"
  }
}

# Permissão para S3 invocar o Lambda
resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.video_bucket.arn
}

# SNS Topic para notificações
resource "aws_sns_topic" "transcribe_notifications" {
  name = "${local.environment}-transcribe-job-mp4-notifications"
}
