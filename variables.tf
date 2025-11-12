# You can override these variables in a terraform.tfvars file
# or via environment variables with -var="key=value"

variable "aws_region" {
  description = "AWS region to create resources"
  type        = string
  default     = "eu-west-1"
}

variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "KeepCoding"
}

variable "environment" {
  description = "The environment for the infrastructure"
  type        = string
  default     = "dev"
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "s3taticweb"
}
