# Static website endpoint output
output "website_endpoint" {
  description = "S3 bucket website endpoint"
  value       = aws_s3_bucket_website_configuration.this.website_endpoint
}

# S3 bucket name output
output "bucket_name" {
  description = "S3 bucket name"
  value       = aws_s3_bucket.s3taticweb.bucket
}

# Complete website URL output
output "website_url" {
  description = "Complete static website URL"
  value       = "http://${aws_s3_bucket_website_configuration.this.website_endpoint}"
}

# Deployment summary
output "deployment_summary" {
  description = "Complete deployment information"
  value       = <<-EOF
  
  🎉 Static website successfully deployed! 🎉
  ═══════════════════════════════════════════
  
  📍 Region:        ${var.aws_region}
  🪣 Bucket:        ${aws_s3_bucket.s3taticweb.bucket}
  🌐 Website URL:   http://${aws_s3_bucket_website_configuration.this.website_endpoint}
  
  💡 Tip: Use an incognito browser for testing.
  ‼️ Remember to destroy the deployment when you're done to avoid unnecessary costs.
  
  EOF
}