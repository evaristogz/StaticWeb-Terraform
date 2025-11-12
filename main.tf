# Create an S3 bucket for static website hosting
resource "aws_s3_bucket" "s3taticweb" {
  bucket        = var.bucket_name
  force_destroy = true
}

# Enforce bucket ownership controls
resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.s3taticweb.id
  rule { object_ownership = "BucketOwnerEnforced" }
}

# Disable all public access restrictions
resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.s3taticweb.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Apply a bucket policy to allow public read access
resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.s3taticweb.id
  policy = data.aws_iam_policy_document.this.json

  depends_on = [aws_s3_bucket_public_access_block.this]
}

# Enable static website hosting
resource "aws_s3_bucket_website_configuration" "this" {
  bucket = aws_s3_bucket.s3taticweb.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# IAM policy document for the S3 bucket policy
data "aws_iam_policy_document" "this" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.s3taticweb.arn}/*"]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }

}
