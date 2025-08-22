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

## 📁 Project Files

This project includes the following Terraform configuration files:

### **Core Configuration Files**
- **[main.tf](./main.tf)** - Main infrastructure configuration with all AWS resources
- **[variables.tf](./variables.tf)** - Input variables with validation rules
- **[outputs.tf](./outputs.tf)** - Output values for important resource information
- **[backend.tf](./backend.tf)** - Remote state configuration (commented)

### **Configuration Files**
- **[terraform.tfvars.example](./terraform.tfvars.example)** - Example variable values
- **[.gitignore](./.gitignore)** - Git ignore rules for Terraform files

---

## 🏗️ Infrastructure Components

### **Networking Resources**
The `main.tf` file creates a complete VPC infrastructure:
- **VPC** with DNS support and hostnames enabled
- **Internet Gateway** for public internet access
- **Public Subnets** (2) across different availability zones
- **Private Subnets** (2) for database resources
- **Route Tables** and associations for proper routing

### **Compute Resources**
- **Application Load Balancer** for traffic distribution
- **Auto Scaling Group** with 2-6 instances
- **Launch Template** with user data for web server setup
- **Target Group** with health checks

### **Database Resources**
- **RDS MySQL** instance in private subnets
- **DynamoDB** table for NoSQL data
- **DB Subnet Group** for multi-AZ deployment

### **Storage Resources**
- **S3 Bucket** with versioning enabled
- **Public access blocking** for security

### **Security Resources**
- **Security Groups** for ALB, web servers, and database
- **Least privilege access** principles applied

---

## 🔧 Variables Configuration

The `variables.tf` file includes comprehensive input variables:

### **Required Variables**
- `db_password` - Database password (sensitive)

### **Optional Variables with Defaults**
- `region` - AWS region (default: us-east-1)
- `environment` - Environment name (default: dev)
- `instance_type` - EC2 instance type (default: t2.micro)
- `allowed_cidr_blocks` - Allowed IP ranges
- `min_size`, `max_size`, `desired_capacity` - Auto Scaling parameters

### **Variable Validation**
All variables include validation rules to ensure:
- Valid AWS region format
- Proper environment values (dev/staging/prod)
- Valid EC2 instance types
- Secure password requirements
- Valid CIDR block notation

---

## 📊 Outputs

The `outputs.tf` file provides important information:

### **Network Information**
- VPC ID and CIDR block
- Public and private subnet IDs

### **Application Access**
- Load balancer DNS name
- Website URL for easy access

### **Resource Details**
- Auto Scaling Group ARN and name
- Database endpoint (sensitive)
- S3 bucket name and ARN
- Security group IDs

### **Summary Output**
- Complete resource summary with all important details

---

## 🚀 Deployment Instructions

### **Step 1: Prepare Configuration**

```bash
# Clone or navigate to the project directory
cd 04_provisioning_deployments

# Copy example variables file
cp terraform.tfvars.example terraform.tfvars

# Edit terraform.tfvars with your values
nano terraform.tfvars
```

### **Step 2: Initialize Terraform**

```bash
# Initialize Terraform
terraform init

# Format code
terraform fmt

# Validate configuration
terraform validate
```

### **Step 3: Plan and Deploy**

```bash
# Plan deployment
terraform plan

# Apply configuration
terraform apply

# Confirm with 'yes' when prompted
```

### **Step 4: Access Your Application**

After deployment, Terraform will output the website URL:
```
website_url = "http://terraform-alb-1234567890.us-east-1.elb.amazonaws.com"
```

Visit this URL to see your auto-scaling web application!

---

## 🔒 Security Best Practices

### **Network Security**
- Private subnets for database resources
- Security groups with least privilege access
- No direct internet access to database

### **Data Protection**
- S3 bucket with public access blocked
- Database password marked as sensitive
- Encryption enabled where possible

### **Access Control**
- Configurable CIDR blocks for SSH access
- Load balancer security group separate from web servers
- Database only accessible from web servers

---

## 📊 State Management

### **Local State (Default)**
- State stored locally in `terraform.tfstate`
- Suitable for learning and development

### **Remote State (Production)**
- Uncomment `backend.tf` configuration
- Create S3 bucket and DynamoDB table first
- Enable state locking and encryption

### **State Commands**
```bash
# View current state
terraform show

# List resources in state
terraform state list

# Refresh state from real infrastructure
terraform refresh
```

---

## 🧹 Cleanup

**⚠️ Important: Always clean up resources to avoid charges!**

```bash
# Destroy all resources
terraform destroy

# Confirm with 'yes' when prompted
```

---

## 🔧 Troubleshooting

### **Common Issues**

#### **1. Variable Validation Errors**
```bash
# Check variable values
terraform console
> var.region
> var.environment
```

#### **2. Resource Dependencies**
```bash
# View dependency graph
terraform graph | dot -Tpng > graph.png
```

#### **3. State Issues**
```bash
# Refresh state
terraform refresh

# Import existing resources
terraform import aws_instance.example i-1234567890abcdef0
```

#### **4. Permission Errors**
- Ensure AWS credentials are configured
- Check IAM permissions for all required services
- Verify region availability for resources

---

## 🎯 Customization Options

### **Scaling Configuration**
Edit `terraform.tfvars` to adjust:
- Auto Scaling Group size (min/max/desired)
- Instance types for different workloads
- Database storage and instance class

### **Security Configuration**
- Modify `allowed_cidr_blocks` for SSH access
- Adjust security group rules in `main.tf`
- Configure backup retention periods

### **Environment Configuration**
- Change environment tags
- Modify resource naming conventions
- Add additional tags for cost tracking

---

## 🎓 What You'll Learn

✅ **Advanced AWS Resources** - VPC, ALB, ASG, RDS, DynamoDB, S3
✅ **Security Best Practices** - Security groups, network isolation
✅ **State Management** - Local and remote state handling
✅ **Variable Management** - Input validation and sensitive data
✅ **Output Management** - Extracting important resource information
✅ **Production Patterns** - High availability and auto scaling
✅ **Code Organization** - Separating configuration into logical files

---

## 📚 Next Steps

1. **Explore Modules** - Create reusable Terraform modules
2. **CI/CD Integration** - Automate deployments with pipelines
3. **Advanced Networking** - VPN, NAT Gateway, VPC Peering
4. **Monitoring** - CloudWatch, logging, and alerting
5. **Security** - IAM roles, KMS encryption, secrets management

---

*Master advanced Terraform provisioning for production-ready AWS infrastructure!* 🚀
