# Simple EC2 Creation with Terraform - First Class
# This creates an EC2 instance using default VPC and Security Group

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure AWS Provider
provider "aws" {
  region = "us-east-1"  # Change to your preferred region
}

# Get the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Get default VPC
data "aws_vpc" "default" {
  default = true
}

# Get default security group
data "aws_security_group" "default" {
  name   = "default"
  vpc_id = data.aws_vpc.default.id
}

# Create a new security group for web access
resource "aws_security_group" "web_sg" {
  name        = "terraform-web-sg"
  description = "Security group for web server"
  vpc_id      = data.aws_vpc.default.id

  # Allow SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTP
  ingress {
    from_port   = 80
    to_port     = 80
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
    Name = "terraform-web-sg"
  }
}

# Create EC2 Instance
resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  user_data              = <<-EOF
    #!/bin/bash
    yum update -y
    amazon-linux-extras install nginx1 -y
    systemctl start nginx
    systemctl enable nginx
    
    # Create simple website
    cat > /var/www/html/index.html << 'HTML'
    <!DOCTYPE html>
    <html>
    <head>
        <title>My First Terraform Website</title>
        <style>
            body { 
                font-family: Arial, sans-serif; 
                text-align: center; 
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 50px;
            }
            .container { 
                background: rgba(255,255,255,0.1); 
                padding: 30px; 
                border-radius: 15px; 
                max-width: 600px; 
                margin: 0 auto;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>🚀 Welcome to My Terraform Website!</h1>
            <p>This EC2 instance was created using Terraform</p>
            <p><strong>Instance Type:</strong> t2.micro</p>
            <p><strong>OS:</strong> Amazon Linux 2</p>
            <p><strong>Web Server:</strong> Nginx</p>
            <p><strong>Deployed by:</strong> Varun Kumar</p>
        </div>
    </body>
    </html>
HTML
    
    # Set permissions
    chown nginx:nginx /var/www/html/index.html
    systemctl restart nginx
  EOF

  tags = {
    Name = "terraform-web-server"
  }
}

# Output the public IP
output "public_ip" {
  value = aws_instance.web_server.public_ip
}

# Output the website URL
output "website_url" {
  value = "http://${aws_instance.web_server.public_ip}"
}
