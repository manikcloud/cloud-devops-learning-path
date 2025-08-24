# Simple EC2 Instance Example

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

# Create a security group (firewall rules)
resource "aws_security_group" "web_sg" {
  name        = "terraform-web-sg"
  description = "Security group for web server"

  # Allow HTTP traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SSH traffic
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create EC2 instance
resource "aws_instance" "web_server" {
  ami           = "ami-0bbc328167dee8f3c"  # Amazon Linux 2 (latest)
  instance_type = "t2.micro"               # Free tier eligible
  
  # Attach security group
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  
  # Install web server on startup
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Hello from Terraform!</h1>" > /var/www/html/index.html
    echo "<p>This server was created with Terraform</p>" >> /var/www/html/index.html
  EOF

  tags = {
    Name = "terraform-web-server"
  }
}
