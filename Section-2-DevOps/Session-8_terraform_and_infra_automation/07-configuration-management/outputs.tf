# Outputs for configuration management example

output "instance_details" {
  description = "Details about the created instance"
  value = {
    id          = aws_instance.web_server.id
    public_ip   = aws_instance.web_server.public_ip
    private_ip  = aws_instance.web_server.private_ip
    instance_type = aws_instance.web_server.instance_type
  }
}

output "website_url" {
  description = "URL to access the website"
  value       = "http://${aws_instance.web_server.public_ip}"
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.web_sg.id
}

output "ami_used" {
  description = "AMI ID that was used"
  value       = data.aws_ami.amazon_linux.id
}
