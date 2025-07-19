# Simple EC2 Website Deployment with Terraform
# This creates an EC2 instance with Nginx and a custom website

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
  region = "us-east-1"
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

# Create Security Group for web access
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
  
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    amazon-linux-extras install nginx1 -y
    systemctl start nginx
    systemctl enable nginx
    
    # Create custom website
    cat > /var/www/html/index.html << 'HTML'
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My Terraform Website - Varun Kumar</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                min-height: 100vh;
            }
            .container {
                max-width: 800px;
                margin: 0 auto;
                padding: 50px 20px;
                text-align: center;
            }
            .header {
                margin-bottom: 50px;
            }
            .header h1 {
                font-size: 3em;
                margin-bottom: 10px;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
            }
            .header p {
                font-size: 1.2em;
                opacity: 0.9;
            }
            .content {
                background: rgba(255,255,255,0.1);
                padding: 30px;
                border-radius: 15px;
                backdrop-filter: blur(10px);
                margin-bottom: 30px;
            }
            .skills {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 20px;
                margin-top: 30px;
            }
            .skill-card {
                background: rgba(255,255,255,0.2);
                padding: 20px;
                border-radius: 10px;
                transition: transform 0.3s ease;
            }
            .skill-card:hover {
                transform: translateY(-5px);
            }
            .footer {
                margin-top: 50px;
                opacity: 0.8;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="header">
                <h1>🚀 My Terraform Website</h1>
                <p>Deployed with Infrastructure as Code</p>
            </div>
            
            <div class="content">
                <h2>About This Deployment</h2>
                <p>This website is running on Amazon EC2 instance deployed using Terraform. This demonstrates Infrastructure as Code principles and automated cloud deployments.</p>
                
                <div class="skills">
                    <div class="skill-card">
                        <h3>🏗️ Terraform</h3>
                        <p>Infrastructure as Code tool</p>
                    </div>
                    <div class="skill-card">
                        <h3>☁️ AWS EC2</h3>
                        <p>Elastic Compute Cloud</p>
                    </div>
                    <div class="skill-card">
                        <h3>🌐 Nginx</h3>
                        <p>High-performance web server</p>
                    </div>
                    <div class="skill-card">
                        <h3>🔧 User Data</h3>
                        <p>Automated configuration</p>
                    </div>
                </div>
            </div>
            
            <div class="content">
                <h2>Technical Details</h2>
                <p><strong>Instance Type:</strong> t2.micro (Free Tier)</p>
                <p><strong>OS:</strong> Amazon Linux 2</p>
                <p><strong>Web Server:</strong> Nginx</p>
                <p><strong>Deployment:</strong> Terraform + User Data</p>
            </div>
            
            <div class="footer">
                <p>🎓 DevOps Training Project</p>
                <p>Created by <strong>Varun Kumar</strong></p>
                <p>Powered by Terraform & AWS</p>
            </div>
        </div>
    </body>
    </html>
HTML
    
    # Set permissions and restart nginx
    chown nginx:nginx /var/www/html/index.html
    systemctl restart nginx
  EOF

  tags = {
    Name = "terraform-web-server"
  }
}

# Output the public IP and website URL
output "public_ip" {
  description = "Public IP address of the web server"
  value       = aws_instance.web_server.public_ip
}

output "website_url" {
  description = "URL to access the website"
  value       = "http://${aws_instance.web_server.public_ip}"
}
