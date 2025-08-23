# Simple outputs for S3 bucket example

output "bucket_name" {
  description = "Name of the created S3 bucket"
  value       = aws_s3_bucket.my_bucket.id
}

output "bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = aws_s3_bucket.my_bucket.arn
}

output "uploaded_file" {
  description = "The file we uploaded"
  value       = aws_s3_object.hello_file.key
}
