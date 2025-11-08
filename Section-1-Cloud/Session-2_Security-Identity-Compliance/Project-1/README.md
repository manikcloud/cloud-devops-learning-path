# 🔐 Project 1: Delegate Access Across AWS Accounts Using IAM Roles

<div align="center">

![Cross Account](https://img.shields.io/badge/Cross--Account-Access-blue?style=for-the-badge&logo=amazon-aws&logoColor=white)
![IAM Roles](https://img.shields.io/badge/IAM-Roles-orange?style=for-the-badge&logo=key&logoColor=white)
![Security](https://img.shields.io/badge/Enterprise-Security-green?style=for-the-badge&logo=shield&logoColor=white)

**🎯 Secure Cross-Account Access | 🔑 IAM Role Implementation | 📊 Enterprise Architecture**

</div>

---

## 📋 Project Overview

**Objective:** Implement secure cross-account access using IAM roles to enable users from one AWS account to access resources in another account without sharing credentials.

**Duration:** 2-3 hours  
**Difficulty:** Intermediate  
**Prerequisites:** Basic understanding of IAM concepts

---

## 🎯 Learning Objectives

By completing this project, you will:

- ✅ **Understand cross-account access** patterns and use cases
- ✅ **Create and configure IAM roles** for cross-account access
- ✅ **Implement trust relationships** between AWS accounts
- ✅ **Configure assume role permissions** for users
- ✅ **Test and validate** cross-account access
- ✅ **Implement monitoring** and logging for security

---

## 🏗️ Architecture Overview

```
┌─────────────────────┐         ┌─────────────────────┐
│   Account A (Dev)   │         │  Account B (Prod)  │
│   ID: 111111111111  │         │  ID: 222222222222  │
│                     │         │                     │
│  ┌───────────────┐  │         │  ┌───────────────┐  │
│  │   IAM User    │  │ Assume  │  │   IAM Role    │  │
│  │  (Developer)  │  │ ──────► │  │ (CrossAccount │  │
│  │               │  │  Role   │  │    Access)    │  │
│  └───────────────┘  │         │  └───────────────┘  │
│                     │         │          │          │
│                     │         │          ▼          │
│                     │         │  ┌───────────────┐  │
│                     │         │  │   S3 Bucket   │  │
│                     │         │  │  (Production) │  │
│                     │         │  └───────────────┘  │
└─────────────────────┘         └─────────────────────┘
```

---

## 🛠️ Implementation Steps

### **Phase 1: Account B (Target Account) Setup**

#### **Step 1: Create IAM Role in Account B**

1. **Navigate to IAM Console** in Account B
2. **Create Role** with the following configuration:
   - **Trusted Entity Type:** Another AWS Account
   - **Account ID:** Enter Account A's ID (111111111111)
   - **Role Name:** `CrossAccountAccessRole`

#### **Step 2: Configure Trust Policy**

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::111111111111:root"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "unique-external-id-123"
        }
      }
    }
  ]
}
```

#### **Step 3: Attach Permissions Policy**

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "arn:aws:s3:::production-bucket-name",
        "arn:aws:s3:::production-bucket-name/*"
      ]
    }
  ]
}
```

### **Phase 2: Account A (Source Account) Setup**

#### **Step 4: Create IAM User in Account A**

1. **Create IAM User:** `DeveloperUser`
2. **Enable Console Access** with secure password
3. **Enable MFA** for additional security

#### **Step 5: Create Assume Role Policy**

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Resource": "arn:aws:iam::222222222222:role/CrossAccountAccessRole"
    }
  ]
}
```

#### **Step 6: Attach Policy to User**

1. **Create Policy:** `AssumeRolePolicy`
2. **Attach to User:** `DeveloperUser`

### **Phase 3: Testing and Validation**

#### **Step 7: Test Cross-Account Access**

**Using AWS CLI:**
```bash
# Configure AWS CLI with Account A credentials
aws configure --profile account-a

# Assume role in Account B
aws sts assume-role \
  --role-arn arn:aws:iam::222222222222:role/CrossAccountAccessRole \
  --role-session-name CrossAccountSession \
  --external-id unique-external-id-123 \
  --profile account-a

# Use temporary credentials to access Account B resources
export AWS_ACCESS_KEY_ID=<temporary-access-key>
export AWS_SECRET_ACCESS_KEY=<temporary-secret-key>
export AWS_SESSION_TOKEN=<temporary-session-token>

# Test S3 access
aws s3 ls s3://production-bucket-name
```

**Using AWS Console:**
1. **Login to Account A** as DeveloperUser
2. **Switch Role** using Account B details
3. **Access Account B resources** through console

---

## 📊 Security Enhancements

### **Multi-Factor Authentication**
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::111111111111:root"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "Bool": {
          "aws:MultiFactorAuthPresent": "true"
        },
        "NumericLessThan": {
          "aws:MultiFactorAuthAge": "3600"
        }
      }
    }
  ]
}
```

### **Time-Based Access**
```json
{
  "DateGreaterThan": {
    "aws:CurrentTime": "2024-01-01T00:00:00Z"
  },
  "DateLessThan": {
    "aws:CurrentTime": "2024-12-31T23:59:59Z"
  }
}
```

### **IP Address Restrictions**
```json
{
  "IpAddress": {
    "aws:SourceIp": [
      "203.0.113.0/24",
      "198.51.100.0/24"
    ]
  }
}
```

---

## 📈 Monitoring and Logging

### **CloudTrail Configuration**

1. **Enable CloudTrail** in both accounts
2. **Configure S3 logging** for audit trails
3. **Set up CloudWatch alarms** for suspicious activities

### **Key Events to Monitor:**
- `AssumeRole` API calls
- Failed authentication attempts
- Unusual access patterns
- Policy modifications

### **CloudWatch Metrics:**
```json
{
  "MetricName": "CrossAccountAssumeRole",
  "Namespace": "Security/IAM",
  "Dimensions": [
    {
      "Name": "SourceAccount",
      "Value": "111111111111"
    },
    {
      "Name": "TargetAccount", 
      "Value": "222222222222"
    }
  ]
}
```

---

## 🎯 Testing Scenarios

### **Scenario 1: Successful Access**
- User assumes role successfully
- Accesses permitted resources
- Actions logged in CloudTrail

### **Scenario 2: Permission Denied**
- User attempts unauthorized action
- Access denied by IAM policy
- Security event logged

### **Scenario 3: MFA Required**
- User attempts access without MFA
- Access denied due to condition
- User prompted for MFA

### **Scenario 4: Session Expiry**
- Temporary credentials expire
- User must re-assume role
- New session created

---

## 📋 Deliverables

### **Required Outputs:**

1. **📄 Working Cross-Account Access**
   - Demonstration of successful role assumption
   - Resource access from Account A to Account B

2. **📋 IAM Configuration Documentation**
   - Trust policies and permission policies
   - User and role configurations
   - Security conditions implemented

3. **📝 Security Procedures**
   - Step-by-step access procedures
   - Emergency access protocols
   - Regular review processes

4. **🔧 Monitoring Setup**
   - CloudTrail configuration
   - CloudWatch alarms
   - Security dashboards

---

## ✅ Validation Checklist

### **Security Validation:**
- [ ] Cross-account access works correctly
- [ ] Unauthorized access is properly denied
- [ ] MFA requirements are enforced
- [ ] Session timeouts are configured
- [ ] All activities are logged

### **Documentation Validation:**
- [ ] Architecture diagram is accurate
- [ ] Policies are well-documented
- [ ] Procedures are clearly written
- [ ] Security considerations are addressed

---

## 🚨 Troubleshooting Guide

### **Common Issues:**

**Issue:** "Access Denied" when assuming role
- **Solution:** Check trust policy and account IDs
- **Verify:** External ID matches in both policies

**Issue:** "Invalid session token"
- **Solution:** Refresh temporary credentials
- **Check:** Session timeout settings

**Issue:** "MFA required" error
- **Solution:** Enable MFA for user
- **Verify:** MFA condition in trust policy

---

## 🔗 Additional Resources

- **[AWS IAM Roles Documentation](https://docs.aws.amazon.com/iam/latest/userguide/id_roles.html)**
- **[Cross-Account Access Best Practices](https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_cross-account-with-roles.html)**
- **[AWS STS Documentation](https://docs.aws.amazon.com/STS/latest/APIReference/)**

---

<div align="center">

**🔐 Master enterprise-grade security with cross-account access! 🚀**

*Build secure, scalable multi-account architectures*

</div>

---

**Project 1 - Session 2**  
**Created by:** Varun Kumar  
**Last Updated:** November 2024
