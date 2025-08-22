# Simple Terraform EC2 Deployment - Step by Step Guide

## 🎯 What We'll Create

A simple EC2 instance with Nginx web server using Terraform - perfect for your first Infrastructure as Code experience!

## 📋 Prerequisites

- AWS account with Free Tier
- Computer with internet connection
- Basic command line knowledge

## 🛠️ Step 1: Install Required Tools

### Install AWS CLI

**Linux/macOS:**
```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws --version
```

**Windows:**
- Download from: https://awscli.amazonaws.com/AWSCLIV2.msi
- Install and verify: `aws --version`

### Install Terraform

**Linux:**
```bash
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
terraform --version
```

**macOS:**
```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
terraform --version
```

**Windows:**
- Download from: https://www.terraform.io/downloads
- Extract to folder in PATH
- Verify: `terraform --version`

## 🔑 Step 2: Configure AWS CLI

### Get Your AWS Access Keys

1. Login to AWS Console
2. Go to IAM → Users → Your Username
3. Security Credentials tab
4. Create Access Key → Command Line Interface (CLI)
5. Download or copy the keys

### Configure AWS CLI

```bash
aws configure
```

Enter when prompted:
- **AWS Access Key ID**: [Your Access Key]
- **AWS Secret Access Key**: [Your Secret Key]  
- **Default region**: `us-east-1`
- **Default output format**: `json`

### Test Configuration

```bash
aws sts get-caller-identity
```

You should see your account details.

## 🚀 Step 3: Deploy with Terraform

### Navigate to Project Directory

```bash
cd Section-2-DevOps/Session-8_terraform_and_infra_automation/02_installation_workflows
```

### Initialize Terraform

```bash
terraform init
```

This downloads the AWS provider.

### Review the Plan

```bash
terraform plan
```

This shows what Terraform will create.

### Deploy the Infrastructure

```bash
terraform apply
```

Type `yes` when prompted.

### Get Your Website URL

After deployment completes, you'll see:
```
Outputs:
public_ip = "54.123.45.67"
website_url = "http://54.123.45.67"
```

## 🌐 Step 4: Access Your Website

1. Copy the website URL from the output
2. Open in your web browser
3. You should see your Terraform-deployed website!

## 📊 What Was Created

- **EC2 Instance**: t2.micro (Free Tier)
- **Security Group**: Allows HTTP (80) and SSH (22)
- **Nginx Web Server**: Automatically installed
- **Custom Website**: With Terraform branding

## 🧹 Step 5: Clean Up (Important!)

**Always clean up to avoid charges:**

```bash
terraform destroy
```

Type `yes` when prompted.

## 🔧 Troubleshooting

### Common Issues:

**1. AWS CLI not configured:**
```bash
aws configure list
```

**2. Terraform not initialized:**
```bash
terraform init
```

**3. Permission denied:**
- Check your AWS access keys
- Ensure IAM user has EC2 permissions

**4. Website not loading:**
- Wait 2-3 minutes for setup to complete
- Check security group allows port 80

## 📚 Understanding the Code

### Key Components in `main.tf`:

```hcl
# Provider - tells Terraform to use AWS
provider "aws" {
  region = "us-east-1"
}

# Data source - gets latest Amazon Linux AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
}

# Resource - creates the EC2 instance
resource "aws_instance" "web_server" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  user_data     = <<-EOF
    # Script to install nginx
  EOF
}

# Output - shows important information
output "public_ip" {
  value = aws_instance.web_server.public_ip
}
```

## 🎓 What You Learned

✅ **Infrastructure as Code** - Managing infrastructure with code
✅ **Terraform Basics** - Provider, resources, data sources, outputs
✅ **AWS Integration** - Using Terraform with AWS services
✅ **Automation** - Automated server setup with user data
✅ **Best Practices** - Clean up resources to avoid costs

## 🚀 Next Steps

1. **Modify the website** - Edit the HTML in user_data
2. **Change instance type** - Try t3.micro instead of t2.micro
3. **Add more resources** - Create multiple instances
4. **Learn variables** - Make the configuration more flexible
5. **Explore modules** - Reusable Terraform components

## 💡 Key Terraform Commands

```bash
terraform init      # Initialize project
terraform plan      # Preview changes
terraform apply     # Apply changes
terraform destroy   # Delete resources
terraform show      # Show current state
terraform output    # Show outputs
```

---

**Created by Varun Kumar**

*Simple Terraform Guide - Infrastructure as Code*
