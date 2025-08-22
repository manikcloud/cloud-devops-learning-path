# 🚀 Terraform Provisioning & Deployments

<div align="center">

![Terraform](https://img.shields.io/badge/Terraform-Provisioning-623CE4?style=for-the-badge&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-Deployment-FF9900?style=for-the-badge&logo=amazon-aws&logoColor=white)

**🎯 Master AWS Provisioning | 🚀 Advanced Deployments | 📊 Production Ready**

</div>

---

## 📋 Overview

Learn advanced Terraform concepts for provisioning and deploying AWS resources. This module covers real-world scenarios, best practices, and production-ready configurations.

---

## 🏗️ Advanced AWS Resources

### **VPC and Networking**

```hcl
# Create VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "terraform-vpc"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "terraform-igw"
  }
}

# Create Public Subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "terraform-public-subnet"
  }
}

# Create Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "terraform-public-rt"
  }
}

# Associate Route Table
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
```

### **Load Balancer Configuration**

```hcl
# Application Load Balancer
resource "aws_lb" "main" {
  name               = "terraform-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [aws_subnet.public.id, aws_subnet.public2.id]

  enable_deletion_protection = false

  tags = {
    Name = "terraform-alb"
  }
}

# Target Group
resource "aws_lb_target_group" "web" {
  name     = "terraform-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    enabled             = true
    healthy_threshold   = 2
    interval            = 30
    matcher             = "200"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = "terraform-tg"
  }
}

# Load Balancer Listener
resource "aws_lb_listener" "web" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}
```

### **Auto Scaling Group**

```hcl
# Launch Template
resource "aws_launch_template" "web" {
  name_prefix   = "terraform-web-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.web.id]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum update -y
    amazon-linux-extras install nginx1 -y
    systemctl start nginx
    systemctl enable nginx
    
    # Create custom website
    cat > /var/www/html/index.html << 'HTML'
    <html>
    <head><title>Auto Scaling with Terraform</title></head>
    <body style="font-family: Arial; text-align: center; padding: 50px;">
        <h1>🚀 Auto Scaling Group</h1>
        <p>This server is part of an Auto Scaling Group</p>
        <p>Deployed with Terraform Infrastructure as Code</p>
        <p>Instance ID: $(curl -s http://169.254.169.254/latest/meta-data/instance-id)</p>
    </body>
    </html>
HTML
    
    systemctl restart nginx
  EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "terraform-asg-instance"
    }
  }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "web" {
  name                = "terraform-asg"
  vpc_zone_identifier = [aws_subnet.public.id, aws_subnet.public2.id]
  target_group_arns   = [aws_lb_target_group.web.arn]
  health_check_type   = "ELB"

  min_size         = 2
  max_size         = 6
  desired_capacity = 3

  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "terraform-asg"
    propagate_at_launch = false
  }
}
```

---

## 💾 Database Resources

### **RDS Database**

```hcl
# DB Subnet Group
resource "aws_db_subnet_group" "main" {
  name       = "terraform-db-subnet-group"
  subnet_ids = [aws_subnet.private1.id, aws_subnet.private2.id]

  tags = {
    Name = "terraform-db-subnet-group"
  }
}

# RDS Instance
resource "aws_db_instance" "main" {
  identifier = "terraform-database"

  allocated_storage    = 20
  max_allocated_storage = 100
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"

  db_name  = "webapp"
  username = "admin"
  password = var.db_password

  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name

  backup_retention_period = 7
  backup_window          = "03:00-04:00"
  maintenance_window     = "sun:04:00-sun:05:00"

  skip_final_snapshot = true

  tags = {
    Name = "terraform-database"
  }
}
```

### **DynamoDB Table**

```hcl
# DynamoDB Table
resource "aws_dynamodb_table" "users" {
  name           = "terraform-users"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "user_id"

  attribute {
    name = "user_id"
    type = "S"
  }

  attribute {
    name = "email"
    type = "S"
  }

  global_secondary_index {
    name     = "email-index"
    hash_key = "email"
  }

  tags = {
    Name = "terraform-users"
  }
}
```

---

## 📦 Storage Resources

### **S3 Bucket Configuration**

```hcl
# S3 Bucket
resource "aws_s3_bucket" "app_storage" {
  bucket = "terraform-app-storage-${random_string.bucket_suffix.result}"

  tags = {
    Name = "terraform-app-storage"
  }
}

# S3 Bucket Versioning
resource "aws_s3_bucket_versioning" "app_storage" {
  bucket = aws_s3_bucket.app_storage.id
  versioning_configuration {
    status = "Enabled"
  }
}

# S3 Bucket Public Access Block
resource "aws_s3_bucket_public_access_block" "app_storage" {
  bucket = aws_s3_bucket.app_storage.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Random string for unique bucket name
resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
}
```

---

## 🔧 Variables and Outputs

### **Variables Configuration**

Create `variables.tf`:
```hcl
variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed to access resources"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
```

### **Outputs Configuration**

Create `outputs.tf`:
```hcl
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "load_balancer_dns" {
  description = "DNS name of the load balancer"
  value       = aws_lb.main.dns_name
}

output "website_url" {
  description = "URL to access the website"
  value       = "http://${aws_lb.main.dns_name}"
}

output "database_endpoint" {
  description = "RDS instance endpoint"
  value       = aws_db_instance.main.endpoint
  sensitive   = true
}

output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.app_storage.bucket
}
```

---

## 🔒 Security Best Practices

### **Security Groups**

```hcl
# ALB Security Group
resource "aws_security_group" "alb" {
  name        = "terraform-alb-sg"
  description = "Security group for ALB"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-alb-sg"
  }
}

# Web Server Security Group
resource "aws_security_group" "web" {
  name        = "terraform-web-sg"
  description = "Security group for web servers"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

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

# Database Security Group
resource "aws_security_group" "rds" {
  name        = "terraform-rds-sg"
  description = "Security group for RDS"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web.id]
  }

  tags = {
    Name = "terraform-rds-sg"
  }
}
```

---

## 📊 State Management

### **Remote State Configuration**

Create `backend.tf`:
```hcl
terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-unique-name"
    key            = "terraform/state"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}
```

### **State Locking with DynamoDB**

```hcl
# S3 Bucket for State
resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-bucket-${random_string.state_suffix.result}"

  tags = {
    Name = "terraform-state-bucket"
  }
}

# DynamoDB Table for State Locking
resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "terraform-state-lock"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "terraform-state-lock"
  }
}
```

---

## 🚀 Deployment Commands

### **Complete Deployment Workflow**

```bash
# 1. Initialize Terraform
terraform init

# 2. Format code
terraform fmt

# 3. Validate configuration
terraform validate

# 4. Plan deployment
terraform plan -var="db_password=SecurePassword123!"

# 5. Apply configuration
terraform apply -var="db_password=SecurePassword123!"

# 6. Show outputs
terraform output

# 7. Destroy when done
terraform destroy -var="db_password=SecurePassword123!"
```

### **Using Variables File**

Create `terraform.tfvars`:
```hcl
region      = "us-east-1"
environment = "production"
instance_type = "t3.small"
db_password = "SecurePassword123!"
allowed_cidr_blocks = ["10.0.0.0/8", "172.16.0.0/12"]
```

Deploy with variables file:
```bash
terraform apply -var-file="terraform.tfvars"
```

---

## 🎯 Best Practices

### **1. Resource Naming**
- Use consistent naming conventions
- Include environment and purpose in names
- Use tags for resource organization

### **2. Security**
- Use security groups with least privilege
- Store sensitive data in AWS Secrets Manager
- Enable encryption for all storage resources

### **3. State Management**
- Always use remote state for teams
- Enable state locking with DynamoDB
- Regular state backups

### **4. Code Organization**
- Separate resources into logical files
- Use modules for reusable components
- Version control all Terraform code

---

## 🔧 Troubleshooting

### **Common Issues**

#### **1. Resource Dependencies**
```bash
# View dependency graph
terraform graph | dot -Tpng > graph.png
```

#### **2. State Issues**
```bash
# Refresh state
terraform refresh

# Import existing resources
terraform import aws_instance.example i-1234567890abcdef0
```

#### **3. Plan Failures**
```bash
# Detailed logging
export TF_LOG=DEBUG
terraform plan
```

---

## 🎓 What You Learned

✅ **Advanced AWS Resources** - VPC, ALB, ASG, RDS, DynamoDB, S3
✅ **Security Best Practices** - Security groups, IAM, encryption
✅ **State Management** - Remote state, locking, backups
✅ **Production Patterns** - High availability, auto scaling
✅ **Code Organization** - Variables, outputs, modules

---

*Master advanced Terraform provisioning for production-ready AWS infrastructure!* 🚀
