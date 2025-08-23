output "website_url" {
  description = "URL to access the website"
  value       = "http://${aws_instance.web_server.public_ip}"
}

output "ssh_command" {
  description = "SSH command to connect to the server"
  value       = "ssh -i ~/.ssh/id_rsa ec2-user@${aws_instance.web_server.public_ip}"
}

output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.web_server.id
}
