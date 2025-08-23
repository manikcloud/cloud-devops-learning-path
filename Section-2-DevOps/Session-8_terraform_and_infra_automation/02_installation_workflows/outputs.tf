# Output values for the Terraform configuration

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.web_server.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_eip.web_eip.public_ip
}

output "instance_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.web_server.private_ip
}

output "instance_public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = aws_instance.web_server.public_dns
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.web_sg.id
}

output "web_url" {
  description = "URL to access the web server"
  value       = "http://${aws_eip.web_eip.public_ip}"
}

output "ssh_command" {
  description = "SSH command to connect to the instance (if key pair is configured)"
  value       = var.key_pair_name != null ? "ssh -i ~/.ssh/${var.key_pair_name}.pem ec2-user@${aws_eip.web_eip.public_ip}" : "SSH not configured (no key pair specified)"
}

# Summary output for easy reference
output "deployment_summary" {
  description = "Summary of the deployed infrastructure"
  value = {
    instance_id     = aws_instance.web_server.id
    instance_type   = aws_instance.web_server.instance_type
    public_ip       = aws_eip.web_eip.public_ip
    web_url         = "http://${aws_eip.web_eip.public_ip}"
    security_group  = aws_security_group.web_sg.id
    region          = var.aws_region
    environment     = var.environment
  }
}
