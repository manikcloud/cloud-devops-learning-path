# 🏗️ Module 01: Infrastructure Setup

<div align="center">

![Terraform](https://img.shields.io/badge/Terraform-Infrastructure-purple?style=for-the-badge&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-EC2-orange?style=for-the-badge&logo=amazon-aws&logoColor=white)

**🎯 Build Jenkins Foundation | 🔧 Infrastructure as Code | ☁️ AWS Setup**

</div>

---

## 📋 Module Overview

This module establishes the foundational AWS infrastructure required for Jenkins using Infrastructure as Code (IaC) principles. You'll learn to provision cloud resources systematically and reproducibly.

### 🎯 **Learning Objectives**
- ✅ Understand Infrastructure as Code (IaC) concepts
- ✅ Create AWS EC2 instances using Terraform
- ✅ Configure security groups and networking
- ✅ Set up proper access controls and key management
- ✅ Prepare scalable infrastructure for Jenkins deployment

---

## 📚 Theory: Infrastructure as Code (IaC)

### **What is Infrastructure as Code?**
Infrastructure as Code (IaC) is the practice of managing and provisioning computing infrastructure through machine-readable definition files, rather than physical hardware configuration or interactive configuration tools.

#### **Key Benefits:**
- 🔄 **Reproducibility** - Same infrastructure every time
- 📊 **Version Control** - Track infrastructure changes
- 🚀 **Speed** - Rapid provisioning and scaling
- 💰 **Cost Control** - Predictable resource management
- 🔒 **Consistency** - Eliminate configuration drift

#### **IaC Tools Comparison:**
| Tool | Approach | Language | Cloud Support |
|------|----------|----------|---------------|
| **Terraform** | Declarative | HCL | Multi-cloud |
| **CloudFormation** | Declarative | JSON/YAML | AWS Only |
| **Ansible** | Procedural | YAML | Multi-cloud |
| **Pulumi** | Declarative | Multiple | Multi-cloud |

### **Why Terraform?**
- 🌐 **Multi-cloud Support** - Works with AWS, Azure, GCP
- 📝 **Human-readable** - HCL (HashiCorp Configuration Language)
- 🔄 **State Management** - Tracks infrastructure state
- 📊 **Plan & Apply** - Preview changes before execution
- 🏗️ **Modular** - Reusable infrastructure components

---

## 🛤️ Module Structure

<table>
<tr>
<th width="10%">Project</th>
<th width="30%">Name</th>
<th width="40%">Description</th>
<th width="20%">Skills</th>
</tr>

<tr>
<td><strong>1.1</strong></td>
<td><strong><a href="./1.1_create_ec2_tf">Create EC2 with Terraform</a></strong></td>
<td>Provision AWS EC2 instances, security groups, and networking for Jenkins infrastructure</td>
<td>Terraform, AWS EC2, Security Groups, Networking</td>
</tr>

</table>

---

## 🏗️ **AWS Architecture Design**

Our Jenkins infrastructure uses AWS EC2 instances with proper security groups and networking.

### **Infrastructure Components:**

```
┌─────────────────────────────────────────────────────────────┐
│                        AWS VPC                              │
│  ┌─────────────────────────────────────────────────────┐    │
│  │                Public Subnet                        │    │
│  │                                                     │    │
│  │  ┌─────────────────┐    ┌─────────────────┐        │    │
│  │  │  Jenkins Master │    │  Jenkins Slave  │        │    │
│  │  │   (t3.medium)   │    │   (t3.small)    │        │    │
│  │  │   Port: 8080    │    │   Port: 22      │        │    │
│  │  └─────────────────┘    └─────────────────┘        │    │
│  │                                                     │    │
│  └─────────────────────────────────────────────────────┘    │
│                                                             │
│  ┌─────────────────────────────────────────────────────┐    │
│  │                Security Groups                      │    │
│  │  • Jenkins: 8080, 22, 50000                       │    │
│  │  • SSH: 22                                         │    │
│  │  • Outbound: All traffic                          │    │
│  └─────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────┘
```

### **Resource Specifications:**

#### **Jenkins Master Server:**
- **Instance Type**: t3.medium (2 vCPU, 4 GB RAM)
- **Storage**: 20 GB GP3 SSD
- **OS**: Amazon Linux 2
- **Ports**: 8080 (Jenkins UI), 22 (SSH), 50000 (Agent communication)

#### **Jenkins Slave Node:**
- **Instance Type**: t3.small (2 vCPU, 2 GB RAM)
- **Storage**: 10 GB GP3 SSD
- **OS**: Amazon Linux 2
- **Ports**: 22 (SSH)

#### **Security Configuration:**
- **Key Pair**: RSA 2048-bit for SSH access
- **Security Groups**: Restrictive inbound rules
- **IAM Roles**: Minimal required permissions
- **Elastic IPs**: Static IP addresses for stability

---

## 🚀 Getting Started

### **Prerequisites**
- ✅ AWS Account with administrative access
- ✅ AWS CLI installed and configured
- ✅ Terraform installed (version 1.0+)
- ✅ Basic understanding of AWS services
- ✅ SSH client for server access

### **Setup Verification**
```bash
# Check AWS CLI
aws --version
aws sts get-caller-identity

# Check Terraform
terraform --version

# Verify AWS credentials
aws ec2 describe-regions --output table
```

---

## 📊 Expected Outcomes

After completing this module, you will have:

### **Infrastructure Ready**
- ✅ **Jenkins Master** server running on AWS
- ✅ **Jenkins Slave** node for distributed builds
- ✅ **Security Groups** properly configured
- ✅ **SSH Access** established and tested
- ✅ **Network Configuration** optimized for Jenkins

### **Skills Gained**
- ✅ **Terraform Fundamentals** - HCL syntax and best practices
- ✅ **AWS EC2 Management** - Instance provisioning and configuration
- ✅ **Security Best Practices** - Proper access controls and networking
- ✅ **Infrastructure Planning** - Resource sizing and architecture design

---

## 🔍 Verification Checklist

### **Infrastructure Validation**
- [ ] EC2 instances are running and accessible
- [ ] Security groups allow required ports
- [ ] SSH access works with key pair
- [ ] Elastic IPs are assigned and stable
- [ ] All resources are properly tagged

### **Cost Optimization**
- [ ] Instance types are appropriate for workload
- [ ] Storage is right-sized
- [ ] Unused resources are terminated
- [ ] Billing alerts are configured

---

## 📈 Best Practices Implemented

### **Security**
- 🔒 **Principle of Least Privilege** - Minimal required permissions
- 🔑 **Key Management** - Secure SSH key handling
- 🌐 **Network Segmentation** - Proper subnet and security group design
- 📊 **Monitoring** - CloudWatch integration for visibility

### **Reliability**
- 🔄 **High Availability** - Multi-AZ deployment ready
- 💾 **Backup Strategy** - EBS snapshot capabilities
- 📊 **Monitoring** - Health checks and alerting
- 🔧 **Maintenance** - Automated patching preparation

### **Cost Management**
- 💰 **Right-sizing** - Appropriate instance types
- ⏰ **Scheduling** - Stop/start automation ready
- 📊 **Monitoring** - Cost tracking and alerts
- 🔄 **Optimization** - Regular review processes

---

## 🚨 Troubleshooting Guide

### **Common Issues**

#### **Terraform Errors**
```bash
# Issue: Provider not found
terraform init

# Issue: State lock
terraform force-unlock <LOCK_ID>

# Issue: Resource conflicts
terraform import aws_instance.example i-1234567890abcdef0
```

#### **AWS Access Issues**
```bash
# Check credentials
aws configure list

# Test permissions
aws ec2 describe-instances --dry-run

# Verify region
aws configure get region
```

#### **SSH Connection Problems**
```bash
# Check security group
aws ec2 describe-security-groups --group-ids sg-xxxxxxxxx

# Test connectivity
telnet <public-ip> 22

# SSH with verbose output
ssh -v -i key.pem ec2-user@<public-ip>
```

---

## 📚 Additional Resources

### **Documentation**
- 📖 [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- 📖 [AWS EC2 User Guide](https://docs.aws.amazon.com/ec2/)
- 📖 [AWS Security Best Practices](https://aws.amazon.com/architecture/security-identity-compliance/)

### **Tools & Utilities**
- 🔧 [Terraform State Management](https://www.terraform.io/docs/language/state/index.html)
- 🔧 [AWS Cost Calculator](https://calculator.aws/)
- 🔧 [Security Group Analyzer](https://aws.amazon.com/blogs/security/)

---

## ➡️ Next Steps

Once your infrastructure is provisioned and verified:

1. **Document Your Setup** - Record IP addresses and access details
2. **Test Connectivity** - Ensure SSH access to all instances
3. **Proceed to Module 02** - [Jenkins Installation](../02_jenkins_installation/README.md)

---

<div align="center">

### 🎯 **Infrastructure Foundation Complete!**
*Your AWS environment is ready for Jenkins installation and configuration.*

**Next: [Module 02 - Jenkins Installation](../02_jenkins_installation/README.md)**

</div>
