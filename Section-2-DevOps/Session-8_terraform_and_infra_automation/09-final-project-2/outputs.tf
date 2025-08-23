output "application_url" {
  description = "URL to access the application through ALB"
  value       = "http://${aws_lb.app_alb.dns_name}"
}

output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.app_assets.id
}

output "load_balancer_dns" {
  description = "DNS name of the load balancer"
  value       = aws_lb.app_alb.dns_name
}

output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.app_server.id
}
