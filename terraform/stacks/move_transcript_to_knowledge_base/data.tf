# Bucket S3 de destino (para transcrições)
data "aws_s3_bucket" "transcript_bucket" {
  bucket = "${local.environment}-transcribe-job-mp4-transcriptions-bucket"
}
