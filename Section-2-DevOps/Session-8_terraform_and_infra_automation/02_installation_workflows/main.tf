# Terraform Configuration for Basic Web Server
# This creates an EC2 instance with Apache web server

# Configure the AWS Provider
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure AWS Provider
provider "aws" {
  region = var.aws_region
}

# Data source to get the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Create a security group for the web server
resource "aws_security_group" "web_sg" {
  name_prefix = "terraform-web-sg"
  description = "Security group for Terraform web server"

  # Allow HTTP traffic
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SSH traffic (optional, for debugging)
  ingress {
    description = "SSH"
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

  tags = {
    Name        = "terraform-web-sg"
    Environment = "learning"
    Project     = "terraform-basics"
  }
}

# Create EC2 instance
resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name              = var.key_pair_name

  # User data script to install and configure Apache
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              
              # Create a simple HTML page
              cat > /var/www/html/index.html << 'HTML'
              <!DOCTYPE html>
              <html>
              <head>
                  <title>Terraform Web Server</title>
                  <style>
                      body {
                          font-family: Arial, sans-serif;
                          max-width: 800px;
                          margin: 50px auto;
                          padding: 20px;
                          background-color: #f4f4f4;
                      }
                      .container {
                          background: white;
                          padding: 30px;
                          border-radius: 10px;
                          box-shadow: 0 0 10px rgba(0,0,0,0.1);
                      }
                      h1 {
                          color: #623CE4;
                          text-align: center;
                      }
                      .info {
                          background: #e7f3ff;
                          padding: 15px;
                          border-left: 4px solid #2196F3;
                          margin: 20px 0;
                      }
                  </style>
              </head>
              <body>
                  <div class="container">
                      <h1>🏗️ Hello from Terraform!</h1>
                      
                      <div class="info">
                          <h3>Infrastructure as Code Success!</h3>
                          <p><strong>Instance ID:</strong> $(curl -s http://169.254.169.254/latest/meta-data/instance-id)</p>
                          <p><strong>Availability Zone:</strong> $(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)</p>
                          <p><strong>Instance Type:</strong> $(curl -s http://169.254.169.254/latest/meta-data/instance-type)</p>
                      </div>
                      
                      <h3>What was created:</h3>
                      <ul>
                          <li>✅ EC2 Instance with Apache web server</li>
                          <li>✅ Security Group with HTTP and SSH access</li>
                          <li>✅ Automated web server configuration</li>
                          <li>✅ This custom HTML page</li>
                      </ul>
                      
                      <h3>Terraform Commands Used:</h3>
                      <pre><code>terraform init
terraform plan
terraform apply
terraform show</code></pre>
                      
                      <p><em>This infrastructure was created entirely with code!</em></p>
                  </div>
              </body>
              </html>
HTML
              EOF

  tags = {
    Name        = "terraform-web-server"
    Environment = "learning"
    Project     = "terraform-basics"
    CreatedBy   = "terraform"
  }
}

# Create an Elastic IP (optional, for static IP)
resource "aws_eip" "web_eip" {
  instance = aws_instance.web_server.id
  domain   = "vpc"

  tags = {
    Name        = "terraform-web-eip"
    Environment = "learning"
    Project     = "terraform-basics"
  }

  # Ensure the instance is created before the EIP
  depends_on = [aws_instance.web_server]
}
