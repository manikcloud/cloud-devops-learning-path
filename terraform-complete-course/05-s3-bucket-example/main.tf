# Simple S3 Bucket Example for Learning Terraform

# Configure AWS Provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

# Create a simple S3 bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-terraform-bucket-${random_id.bucket_suffix.hex}"
}

# Random suffix to make bucket name unique
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# Upload a simple file to the bucket
resource "aws_s3_object" "hello_file" {
  bucket  = aws_s3_bucket.my_bucket.id
  key     = "hello.txt"
  content = "Hello from Terraform! Created at ${timestamp()}"
}
