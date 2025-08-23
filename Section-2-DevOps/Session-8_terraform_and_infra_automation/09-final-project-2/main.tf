# Final Project 2: Full Stack Application
# ALB + S3 + EC2 + Security Groups + Key Pair

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

# Get default VPC
data "aws_vpc" "default" {
  default = true
}

# Get subnets
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# S3 bucket for static assets
resource "aws_s3_bucket" "app_assets" {
  bucket = "terraform-fullstack-${random_id.bucket_suffix.hex}"
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# Upload a CSS file to S3
resource "aws_s3_object" "app_css" {
  bucket       = aws_s3_bucket.app_assets.id
  key          = "styles.css"
  content_type = "text/css"
  content = <<-EOF
    body { 
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      margin: 0; padding: 20px; color: white;
    }
    .container { 
      max-width: 1000px; margin: 0 auto; 
      background: rgba(255,255,255,0.1); 
      padding: 30px; border-radius: 15px;
      backdrop-filter: blur(10px);
    }
    .header { text-align: center; margin-bottom: 30px; }
    .grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
    .card { 
      background: rgba(255,255,255,0.2); 
      padding: 20px; border-radius: 10px; 
    }
    .success { color: #4CAF50; font-weight: bold; }
  EOF
}

# Security group for ALB
resource "aws_security_group" "alb_sg" {
  name = "terraform-alb-sg"

  ingress {
    from_port   = 80
    to_port     = 80
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

# Security group for EC2
resource "aws_security_group" "ec2_sg" {
  name = "terraform-ec2-sg"

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
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
resource "aws_instance" "app_server" {
  ami           = "ami-0bbc328167dee8f3c"
  instance_type = "t2.micro"
  
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  
  user_data = templatefile("${path.module}/user-data.sh", {
    s3_bucket = aws_s3_bucket.app_assets.id
  })

  tags = {
    Name = "terraform-fullstack-server"
  }
}

# Application Load Balancer
resource "aws_lb" "app_alb" {
  name               = "terraform-fullstack-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = data.aws_subnets.default.ids
}

# Target group
resource "aws_lb_target_group" "app_tg" {
  name     = "terraform-fullstack-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# Target group attachment
resource "aws_lb_target_group_attachment" "app_tg_attachment" {
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = aws_instance.app_server.id
  port             = 80
}

# ALB listener
resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}
