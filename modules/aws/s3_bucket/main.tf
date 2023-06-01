resource "aws_s3_bucket" "bucket" {
  bucket = "codemke-${var.bucket_name}"

  tags = {
    environment = var.environment
  }
}
