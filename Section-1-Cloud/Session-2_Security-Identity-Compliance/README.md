# 🔐 Session 2: Security, Identity, and Compliance on AWS

<div align="center">

![Security](https://img.shields.io/badge/AWS-Security-red?style=for-the-badge&logo=amazon-aws&logoColor=white)
![IAM](https://img.shields.io/badge/Identity-Access%20Management-blue?style=for-the-badge&logo=key&logoColor=white)
![Compliance](https://img.shields.io/badge/Compliance-Best%20Practices-green?style=for-the-badge&logo=shield&logoColor=white)

**🛡️ Secure Your Cloud | 👥 Manage Access | 💰 Control Costs**

</div>

---

## 📋 Session Overview

**Duration:** 8 hours  
**Format:** Theory + Hands-on Labs + Demos  
**Focus:** AWS Security fundamentals, IAM implementation, and cost management

Master AWS security fundamentals and learn to identify, categorize, and protect your assets while managing secure access to AWS resources.

---

## 🎯 Learning Objectives

By the end of this session, you will be able to:

- ✅ **Set up AWS account** with security best practices
- ✅ **Master IAM components** (Users, Groups, Roles, Policies)
- ✅ **Implement MFA** and password policies
- ✅ **Configure billing alerts** and cost budgets
- ✅ **Delegate cross-account access** using IAM roles
- ✅ **Apply security best practices** in real scenarios

---

## 📚 Topics Covered

### 🚀 **AWS Account Setup & IAM Foundation**
- AWS account creation and initial configuration
- Root account security and best practices
- IAM service introduction and importance
- Security principles and shared responsibility model

### 👥 **IAM Components Deep Dive**
- **Users:** Individual identities for people and applications
- **Groups:** Collections of users with similar permissions
- **Roles:** Temporary access for services and cross-account access
- **Policies:** JSON documents defining permissions

### 🧪 **Hands-On IAM Labs**
- Creating and managing IAM users
- Setting up groups and membership
- Attaching policies to users and groups
- Testing permissions and access

### 🎭 **User Management Demo**
- Creating users in groups with specific permissions
- Managing group membership and inheritance
- Implementing least privilege principle
- Troubleshooting access issues

### 🔒 **Security Policies Implementation**
- IAM password policy configuration
- Multi-Factor Authentication (MFA) setup
- Account lockout and security settings
- Security monitoring and alerts

### 💰 **Cost Management & Billing**
- AWS billing dashboard overview
- Setting up billing alerts and notifications
- Creating cost budgets and spending limits
- Cost optimization strategies

---

## 🛠️ Hands-On Labs

### 🧪 **Lab 1: IAM Users and Groups**
**Objective:** Create a complete IAM structure with users and groups

**Tasks:**
- Create IAM groups (Developers, Admins, ReadOnly)
- Create IAM users and assign to appropriate groups
- Attach policies to groups
- Test user permissions

### 🧪 **Lab 2: IAM Roles and Policies**
**Objective:** Implement cross-service and cross-account access

**Tasks:**
- Create IAM roles for EC2 instances
- Configure trust relationships
- Attach service policies
- Test role assumption

### 🧪 **Lab 3: Security Configuration**
**Objective:** Implement comprehensive security measures

**Tasks:**
- Configure password policy
- Enable MFA for users
- Set up CloudTrail logging
- Configure security alerts

### 🧪 **Lab 4: Billing and Cost Management**
**Objective:** Set up cost monitoring and alerts

**Tasks:**
- Configure billing alerts
- Create cost budgets
- Set up spending notifications
- Analyze cost reports

---

## 💻 Project 1: Delegate Access Across AWS Accounts Using IAM Roles

### **Project Overview:**
Implement secure cross-account access using IAM roles, enabling users from one AWS account to access resources in another account.

### **Architecture:**
```
Account A (Dev) → Assume Role → Account B (Prod) → Access Resources
```

### **Requirements:**
- ✅ Create IAM role in target account
- ✅ Configure trust relationship with source account
- ✅ Attach appropriate permissions policies
- ✅ Create users in source account
- ✅ Grant permission to assume role
- ✅ Test cross-account access
- ✅ Implement logging and monitoring

### **Deliverables:**
- 📄 Cross-account access working demonstration
- 📋 IAM role and policy configurations
- 📝 Security documentation and procedures
- 🔧 Monitoring and alerting setup

---

## 🏗️ Security Architecture Patterns

### **Multi-Account Strategy**
```
Organization Root
├── Security Account (Logging, Monitoring)
├── Production Account (Live workloads)
├── Development Account (Testing)
└── Shared Services Account (Common resources)
```

### **IAM Best Practices Architecture**
```
Root Account (Minimal use)
├── Admin Group (Full access)
├── Developer Group (Limited access)
├── ReadOnly Group (View only)
└── Service Roles (Application access)
```

---

## 🔧 Key Learning Outcomes

### **Security Fundamentals:**
- ✅ AWS Shared Responsibility Model understanding
- ✅ Identity vs Access Management concepts
- ✅ Principle of least privilege implementation
- ✅ Defense in depth strategies

### **IAM Mastery:**
- ✅ User, group, and role management
- ✅ Policy creation and attachment
- ✅ Cross-account access configuration
- ✅ Service-linked roles understanding

### **Cost Management:**
- ✅ Billing dashboard navigation
- ✅ Alert and budget configuration
- ✅ Cost optimization identification
- ✅ Resource tagging for cost allocation

---

## 📊 Security Best Practices

### **Account Security:**
- 🔐 Enable MFA on root account
- 🚫 Avoid using root account for daily tasks
- 📱 Use hardware MFA devices for production
- 🔄 Regularly rotate access keys

### **IAM Best Practices:**
- 👥 Create individual users, avoid sharing
- 🏷️ Use groups to assign permissions
- 🎯 Apply least privilege principle
- 📋 Use managed policies when possible
- 🔍 Regularly review and audit permissions

### **Monitoring and Compliance:**
- 📊 Enable CloudTrail for API logging
- 🚨 Set up CloudWatch alarms
- 📈 Monitor unusual access patterns
- 📋 Regular access reviews and audits

---

## 🎯 Assessment Criteria

### **Theoretical Knowledge (30%):**
- Security concepts and principles
- IAM components understanding
- AWS shared responsibility model
- Compliance requirements

### **Practical Implementation (70%):**
- IAM configuration accuracy
- Security policy implementation
- Cross-account access setup
- Cost management configuration

---

## 📖 Study Materials

### **Required Reading:**
- [AWS IAM User Guide](https://docs.aws.amazon.com/iam/)
- [AWS Security Best Practices](https://aws.amazon.com/security/security-learning/)
- [AWS Billing and Cost Management](https://docs.aws.amazon.com/awsaccountbilling/)

### **Security Resources:**
- AWS Security Center
- IAM Policy Simulator
- AWS Trusted Advisor
- AWS Config Rules

---

## 🚨 Common Security Pitfalls

### **Avoid These Mistakes:**
- ❌ Using root account for daily operations
- ❌ Sharing IAM user credentials
- ❌ Overly permissive policies
- ❌ Not enabling MFA
- ❌ Ignoring billing alerts
- ❌ Not monitoring access logs

### **Security Checklist:**
- ✅ Root account MFA enabled
- ✅ Individual IAM users created
- ✅ Strong password policy configured
- ✅ Billing alerts set up
- ✅ CloudTrail logging enabled
- ✅ Regular access reviews scheduled

---

## 🔗 Quick Links

- **[AWS IAM Console](https://console.aws.amazon.com/iam/)** - Identity and Access Management
- **[AWS Billing Console](https://console.aws.amazon.com/billing/)** - Cost and billing management
- **[IAM Policy Simulator](https://policysim.aws.amazon.com/)** - Test IAM policies
- **[AWS Security Center](https://aws.amazon.com/security/)** - Security resources

---

## 🚀 Next Steps

### **Session Completion:**
1. **Complete all hands-on labs** successfully
2. **Deploy Project 1** with cross-account access
3. **Configure security monitoring** and alerts
4. **Document security procedures** and policies

### **Preparation for Session 3:**
- Review VPC and networking concepts
- Understand network security principles
- Prepare for advanced networking labs

---

<div align="center">

**🛡️ Secure your cloud foundation with AWS IAM! 🔐**

*Build robust security from day one*

</div>

---

**Session 2 of AWS Job Ready Program**  
**Created by:** Varun Kumar  
**Last Updated:** November 2024
