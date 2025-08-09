# 🏗️ Project 1.1: Create EC2 Instances with Terraform

<div align="center">

![Terraform](https://img.shields.io/badge/Terraform-Infrastructure-purple?style=for-the-badge&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-EC2-orange?style=for-the-badge&logo=amazon-aws&logoColor=white)

**🎯 Provision Jenkins Infrastructure | 🔧 Infrastructure as Code | ☁️ AWS Foundation**

</div>

---

## 📋 Project Overview

This project creates the foundational AWS infrastructure needed for Jenkins using Terraform. You'll provision EC2 instances, security groups, and networking components required for a complete Jenkins CI/CD environment.

### 🎯 **Learning Objectives**
- ✅ Create AWS EC2 instances using Terraform
- ✅ Configure security groups for Jenkins access
- ✅ Set up networking and key pair management
- ✅ Understand Infrastructure as Code principles
- ✅ Prepare scalable environment for Jenkins installation

---

## 📁 Project Files

```
1.1_create_ec2_tf/
├── README.md                 # This documentation
├── main.tf                   # Main Terraform configuration
├── variables.tf              # Input variables definition
├── outputs.tf                # Output values
├── terraform.tfvars.example  # Example variables file
├── scripts/
│   └── user-data.sh          # EC2 initialization script
└── docs/
    └── architecture.md       # Architecture documentation
```

---

## 🚀 Quick Start

### **Step 1: Setup**
```bash
# Navigate to project directory
cd 01_infrastructure_setup/1.1_create_ec2_tf

# Copy example variables
cp terraform.tfvars.example terraform.tfvars

# Edit with your AWS settings
vi terraform.tfvars
```

### **Step 2: Deploy**
```bash
# Initialize Terraform
terraform init

# Review planned changes
terraform plan

# Apply configuration
terraform apply
```

### **Step 3: Verify**
```bash
# Check EC2 instances
aws ec2 describe-instances --filters "Name=tag:Project,Values=Jenkins-Infrastructure"

# Test SSH access
ssh -i jenkins-key.pem ec2-user@<public-ip>
```

---

## 🔧 Configuration Details

### **Resources Created:**
- 🖥️ **Jenkins Master**: t3.medium instance
- 🖥️ **Jenkins Slave**: t3.small instance  
- 🔒 **Security Groups**: Jenkins access rules
- 🔑 **Key Pair**: SSH access management
- 🌐 **Elastic IPs**: Static IP addresses

### **Security Configuration:**
- **Port 8080**: Jenkins web interface
- **Port 22**: SSH access
- **Port 50000**: Jenkins agent communication
- **Outbound**: All traffic allowed

---

## 📊 Expected Outcomes

After completion:
- ✅ Two EC2 instances running (Master & Slave)
- ✅ Security groups properly configured
- ✅ SSH access established
- ✅ Static IP addresses assigned
- ✅ Ready for Jenkins installation

---

## ➡️ Next Steps

Once infrastructure is ready:
1. **Verify Access** - Test SSH to both instances
2. **Document IPs** - Record public IP addresses
3. **Proceed to 2.1** - [Install Jenkins](../../02_jenkins_installation/2.1_install_jenkins/README.md)

---

<div align="center">

### 🎯 **Infrastructure Ready!**
*Your AWS environment is prepared for Jenkins installation.*

</div>
