locals {
  environment_map = local.env_variables == null ? [] : [local.env_variables]
}

# Primeiro, adicionamos o recurso archive_file para criar o ZIP
data "archive_file" "this" {
  type             = "zip"
  source_file      = "${path.module}/${local.source_file}"
  output_file_mode = "0666"
  output_path      = "${path.module}/outputs/bin/${local.source_file}.zip"
}

# Agora, atualizamos o recurso aws_lambda_function
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

  dynamic "environment" {
    for_each = local.environment_map
    content {
      variables = environment.value
    }
  }
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/lambda/${aws_lambda_function.this.function_name}"
  retention_in_days = 3
}


# Política IAM para o Lambda
resource "aws_iam_role" "this" {
  name = "${local.environment}_transcribe_to_knowledg_base_lambda_role"

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


resource "aws_iam_role_policy" "athena_bedrock_policy" {
  name = "athena-bedrock-policy"
  role = aws_iam_role.this.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Action" : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:AssociateKmsKey"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : "bedrock:InvokeModel",
        "Resource" : "arn:aws:bedrock:us-east-1::foundation-model/anthropic.claude-3-5-sonnet-20240620-v1:0"
      }
    ]
  })
}

# S3 Bucket Notification para acionar o Lambda
resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = data.aws_s3_bucket.transcript_bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.this.arn
    events              = ["s3:ObjectCreated:*"]
    filter_suffix       = ".json"
  }

  depends_on = [aws_lambda_permission.allow_bucket]
}

# Permissão para S3 invocar o Lambda
resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = data.aws_s3_bucket.transcript_bucket.arn
}

# SNS Topic para notificações
resource "aws_sns_topic" "transcribe_notifications" {
  name = "${local.environment}-transcribe-to-knowledg-base-notifications"
}

resource "aws_s3_bucket" "chatia_bucket" {
  bucket = "${local.environment}-knowledge-base-bucket-chat-ia"
}
