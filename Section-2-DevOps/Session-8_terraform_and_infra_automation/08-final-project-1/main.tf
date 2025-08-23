# Final Project 1: Complete Web Server Stack
# EC2 + Security Group + Key Pair + Simple Website

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

# Key pair using your existing SSH public key
resource "aws_key_pair" "web_key" {
  key_name   = "terraform-web-key"
  public_key = file("~/.ssh/id_rsa.pub")  # Uses your existing SSH key
}

# Security group
resource "aws_security_group" "web_sg" {
  name = "terraform-web-stack-sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 instance
resource "aws_instance" "web_server" {
  ami           = "ami-0bbc328167dee8f3c"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.web_key.key_name
  
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  
  user_data = file("${path.module}/user-data.sh")

  tags = {
    Name = "terraform-web-stack"
  }
}
