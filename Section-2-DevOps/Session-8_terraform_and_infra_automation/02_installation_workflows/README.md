# 🔧 02: Installation & First Resources

<div align="center">

![Terraform Install](https://img.shields.io/badge/Terraform-Installation-623CE4?style=for-the-badge&logo=terraform&logoColor=white)
![Hands On](https://img.shields.io/badge/Hands_On-Practice-green?style=for-the-badge&logo=terraform&logoColor=white)

**🎯 Install & Configure | 🚀 Deploy First EC2 | 📊 Learn by Doing**

</div>

---

## 📋 **What You'll Build**

A complete EC2 web server deployment including:
- ✅ **EC2 Instance** with Nginx web server
- ✅ **Security Group** with proper access controls
- ✅ **Elastic IP** for consistent access
- ✅ **Custom HTML** page showing infrastructure details

---

## 🛠️ **Prerequisites Setup**

### **Step 1: Install Terraform**

#### **Amazon Linux:**
```bash
# Add HashiCorp repository
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo

# Install Terraform
sudo yum install terraform -y
terraform version
```

#### **Ubuntu/Linux:**
```bash
# Add HashiCorp repository
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

# Install Terraform
sudo apt update && sudo apt install terraform
terraform version
```

#### **macOS:**
```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
terraform version
```

### **Step 2: Configure AWS CLI**

#### **Install AWS CLI:**
```bash
# Amazon Linux / Ubuntu
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# macOS
brew install awscli
```

#### **Configure Credentials:**
```bash
aws configure
# Enter: Access Key ID, Secret Access Key, Region (us-east-1), Output format (json)

# Verify configuration
aws sts get-caller-identity
```

### **Step 3: Clone Repository**
```bash
git clone https://github.com/manikcloud/cloud-devops-learning-path.git
cd cloud-devops-learning-path/Section-2-DevOps/Session-8_terraform_and_infra_automation/02_installation_workflows
```

---

## 🚀 **Hands-On Deployment**

### **Step 1: Initialize Terraform**
```bash
# Initialize Terraform (downloads AWS provider)
terraform init

# Expected output: "Terraform has been successfully initialized!"
```

### **Step 2: Review Configuration**
```bash
# Check the main configuration
cat main.tf

# Validate syntax
terraform validate

# Format code (optional)
terraform fmt
```

### **Step 3: Plan Infrastructure**
```bash
# Create execution plan
terraform plan

# Expected output shows resources to be created:
# + aws_instance.web_server
# + aws_security_group.web_sg  
# + aws_eip.web_eip
```

### **Step 4: Deploy Infrastructure**
```bash
# Apply the configuration
terraform apply

# Type 'yes' when prompted
# Wait 2-3 minutes for deployment
```

### **Step 5: Access Your Web Server**
```bash
# Get the public IP
PUBLIC_IP=$(terraform output -raw instance_public_ip)
echo "Your website: http://$PUBLIC_IP"

# Test the web server
curl http://$PUBLIC_IP

# Or open in browser: http://[PUBLIC_IP]
```

---

## 📊 **Understanding Your Infrastructure**

### **What Was Created:**

| Resource | Purpose | Configuration |
|----------|---------|---------------|
| **EC2 Instance** | Virtual server | t3.micro, Amazon Linux 2 |
| **Security Group** | Firewall rules | HTTP (80), SSH (22) access |
| **Elastic IP** | Static IP address | Consistent public access |
| **User Data Script** | Server setup | Installs and configures Nginx |

### **Key Configuration Files:**

#### **main.tf - Main Infrastructure:**
- AWS provider configuration
- EC2 instance with automated Nginx setup
- Security group with HTTP/SSH access
- Elastic IP for consistent access

#### **variables.tf - Input Parameters:**
- AWS region (default: us-east-1)
- Instance type (default: t3.micro)
- Environment and project tags

#### **outputs.tf - Important Information:**
- Instance public IP address
- Website URL for easy access
- SSH connection command

#### **terraform.tfvars - Configuration Values:**
- Customizable deployment settings
- Environment-specific values

---

## 🧪 **Hands-On Exercises**

### **Exercise 1: Modify the Website**
```bash
# 1. Edit main.tf and change the HTML content in user_data
# 2. Plan and apply changes
terraform plan
terraform apply

# 3. Refresh your browser to see changes
```

### **Exercise 2: Change Instance Type**
```bash
# 1. Edit terraform.tfvars
echo 'instance_type = "t3.small"' >> terraform.tfvars

# 2. Apply changes
terraform plan
terraform apply
```

### **Exercise 3: Add Custom Tags**
```bash
# 1. Edit variables.tf to add more tag options
# 2. Update main.tf to use new tags
# 3. Apply changes to see updated resource tags
```

---

## 🔄 **Terraform Workflow Practice**

### **Essential Commands:**
```bash
# View current state
terraform show

# List all resources
terraform state list

# Get specific output
terraform output instance_public_ip

# View execution plan without applying
terraform plan -out=tfplan

# Apply saved plan
terraform apply tfplan
```

### **State Management:**
```bash
# Refresh state from real infrastructure
terraform refresh

# Import existing resource (if needed)
terraform import aws_instance.example i-1234567890abcdef0

# Show resource details
terraform state show aws_instance.web_server
```

---

## 🔍 **Troubleshooting Guide**

### **Common Issues:**

#### **Authentication Errors:**
```bash
# Check AWS configuration
aws configure list
aws sts get-caller-identity

# Verify credentials are working
aws ec2 describe-regions
```

#### **Permission Issues:**
```bash
# Ensure your AWS user has these permissions:
# - EC2FullAccess (for learning)
# - Or specific: ec2:*, vpc:*, iam:PassRole
```

#### **Instance Not Accessible:**
```bash
# Check security group
aws ec2 describe-security-groups --group-ids $(terraform output -raw security_group_id)

# Verify instance is running
aws ec2 describe-instances --instance-ids $(terraform output -raw instance_id)

# Test connectivity
curl -I http://$(terraform output -raw instance_public_ip)
```

#### **Terraform State Issues:**
```bash
# If state is corrupted
terraform refresh

# Force unlock if needed (use carefully)
terraform force-unlock <lock-id>
```

---

## 📈 **Monitoring Your Deployment**

### **Check Instance Status:**
```bash
# Via Terraform
terraform show | grep -A 5 "aws_instance"

# Via AWS CLI
aws ec2 describe-instances --instance-ids $(terraform output -raw instance_id)
```

### **View Logs:**
```bash
# SSH into instance (if key pair configured)
ssh -i ~/.ssh/your-key.pem ec2-user@$(terraform output -raw instance_public_ip)

# Check nginx status
sudo systemctl status nginx

# View nginx logs
sudo tail -f /var/log/nginx/access.log
```

---

## 🧹 **Cleanup (Important!)**

### **Destroy Infrastructure:**
```bash
# Remove all resources
terraform destroy

# Confirm with 'yes'
# Wait for all resources to be deleted

# Verify cleanup
aws ec2 describe-instances --filters "Name=tag:Name,Values=terraform-web-server"
```

### **Clean Local Files:**
```bash
# Remove Terraform state files (optional)
rm -f terraform.tfstate*
rm -f .terraform.lock.hcl
rm -rf .terraform/
```

---

## 🎓 **What You Learned**

### **Technical Skills:**
- ✅ Terraform installation and configuration
- ✅ AWS provider setup and authentication
- ✅ Infrastructure planning and deployment
- ✅ Resource management and state handling
- ✅ Troubleshooting common issues

### **Best Practices:**
- ✅ Always run `terraform plan` before `apply`
- ✅ Use version control for Terraform configurations
- ✅ Clean up resources to avoid unnecessary costs
- ✅ Use meaningful names and tags for resources
- ✅ Validate configurations before deployment

---

<div align="center">

### 🎯 **Ready for Advanced Concepts?**

**Next: [03 Configuration Management](../03_configuration_management/README.md)**

*Learn variables, modules, and advanced Terraform patterns!*

</div>
