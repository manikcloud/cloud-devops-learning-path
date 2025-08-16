# 🎛️ Project 3.4: Parameterized Jobs - AWS EC2 Automation

<div align="center">

![Parameterized Jobs](https://img.shields.io/badge/Jenkins-Parameterized%20Jobs-blue?style=for-the-badge&logo=jenkins&logoColor=white)
![AWS EC2](https://img.shields.io/badge/AWS-EC2%20Automation-orange?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Infrastructure](https://img.shields.io/badge/Infrastructure-as%20Code-green?style=for-the-badge&logo=terraform&logoColor=white)

**🎛️ Dynamic Job Parameters | ☁️ AWS EC2 Management | 🔧 Infrastructure Automation**

</div>

---

## 📋 Project Overview

Master Jenkins parameterized jobs by creating dynamic AWS EC2 instance management workflows. This advanced project demonstrates how to build flexible, reusable Jenkins jobs that accept user input parameters for on-demand infrastructure provisioning and management using the **current repository**.

<div align="center">

### 🎯 **What You'll Build**
*Professional parameterized Jenkins jobs for AWS EC2 lifecycle management*

</div>

### 🎯 **Learning Objectives**
- ✅ Create parameterized Jenkins jobs with dynamic inputs
- ✅ Integrate AWS CLI with Jenkins for cloud automation
- ✅ Build EC2 instance provisioning and termination workflows
- ✅ Master parameter types and validation techniques
- ✅ Implement infrastructure automation best practices
- ✅ Use current repository for script management

---

## 🚀 Prerequisites & Setup

### **📋 Prerequisites Checklist**
- ✅ Jenkins installed and running
- ✅ AWS CLI installed and configured on Jenkins server
- ✅ AWS IAM user with EC2 permissions
- ✅ Default VPC and subnet in AWS account
- ✅ SSH key pair created in AWS
- ✅ Current repository accessible to Jenkins

### **🔧 AWS CLI Configuration**

#### **Step 1: Install AWS CLI on Jenkins Server**
```bash
# Install AWS CLI v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Verify installation
aws --version
```

#### **Step 2: Configure AWS Credentials**
```bash
# Configure AWS CLI (run as jenkins user)
sudo -u jenkins aws configure
# Enter:
# AWS Access Key ID: [Your Access Key]
# AWS Secret Access Key: [Your Secret Key]
# Default region name: us-east-1
# Default output format: json

# Verify configuration
sudo -u jenkins aws sts get-caller-identity
```

#### **Step 3: Required AWS Permissions**
Ensure your IAM user has these permissions:
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:RunInstances",
                "ec2:TerminateInstances",
                "ec2:DescribeInstances",
                "ec2:DescribeInstanceStatus",
                "ec2:CreateTags"
            ],
            "Resource": "*"
        }
    ]
}
```

---

## 📦 Repository Integration

### **📁 Current Repository Structure**

The automation scripts are located in your repository:

```bash
# Navigate to the parameterized job directory (after Jenkins checkout)
cd Section-2-DevOps/Session-4_Jenkins/03_basic_jobs/3.4_parameterized_job

# View available scripts
ls -la
```

**Directory Structure:**
```
3.4_parameterized_job/
├── README.md              # This comprehensive guide
├── ec2-create.sh          # EC2 instance creation script
└── ec2-delete.sh          # EC2 instance termination script
```

---

## 🔧 Jenkins Job Configuration

### **🎛️ Job 1: EC2 Instance Creation**

#### **Step 1: Create Parameterized Job**
1. **Jenkins Dashboard**: Navigate to `http://localhost:8080`
2. **New Item**: Click "New Item"
3. **Job Configuration**:
   ```yaml
   Item name: EC2-Instance-Creator
   Type: Freestyle project
   ```
4. **Click OK**: Proceed to configuration

#### **Step 2: Configure Parameters**
Enable "This project is parameterized" and add these parameters:

<table>
<tr>
<th width="20%">Parameter</th>
<th width="15%">Type</th>
<th width="25%">Default Value</th>
<th width="40%">Description</th>
</tr>

<tr>
<td><strong>AMI_ID</strong></td>
<td>String</td>
<td><code>ami-0c55b159cbfafe1f0</code></td>
<td>Amazon Machine Image ID for the instance</td>
</tr>

<tr>
<td><strong>INSTANCE_TYPE</strong></td>
<td>Choice</td>
<td><code>t2.micro<br>t2.small<br>t2.medium</code></td>
<td>EC2 instance type to launch</td>
</tr>

<tr>
<td><strong>KEY_PAIR_NAME</strong></td>
<td>String</td>
<td><code>my-key-pair</code></td>
<td>Name of the SSH key pair for instance access</td>
</tr>

<tr>
<td><strong>TAG_NAME</strong></td>
<td>String</td>
<td><code>jenkins-ec2</code></td>
<td>Tag name for easy instance identification</td>
</tr>

<tr>
<td><strong>COUNT</strong></td>
<td>String</td>
<td><code>1</code></td>
<td>Number of instances to launch (1-5)</td>
</tr>

<tr>
<td><strong>REGION</strong></td>
<td>Choice</td>
<td><code>us-east-1<br>us-west-2<br>eu-west-1</code></td>
<td>AWS region for instance deployment</td>
</tr>

</table>

#### **Step 3: Source Code Management**
```yaml
Source Code Management:
  ✅ Git
  Repository URL: https://github.com/manikcloud/cloud-devops-learning-path.git
  Branch Specifier: */main
  
  Additional Behaviours:
    ✅ Sparse Checkout Paths:
      Path: Section-2-DevOps/Session-4_Jenkins/03_basic_jobs/3.4_parameterized_job
```

#### **Step 4: Build Steps**
Add "Execute shell" build step:

```bash
#!/bin/bash

echo "🚀 Starting EC2 Instance Creation Job"
echo "=================================="
echo "Parameters:"
echo "AMI ID: $AMI_ID"
echo "Instance Type: $INSTANCE_TYPE"
echo "Key Pair: $KEY_PAIR_NAME"
echo "Tag Name: $TAG_NAME"
echo "Count: $COUNT"
echo "Region: $REGION"
echo "=================================="

# Navigate to the script directory
cd Section-2-DevOps/Session-4_Jenkins/03_basic_jobs/3.4_parameterized_job

# Make script executable
chmod +x ec2-create.sh

# Execute the EC2 creation script
./ec2-create.sh

echo "✅ EC2 Instance Creation Job Completed"
```

---

## 🗑️ Job 2: EC2 Instance Termination

### **🔧 Termination Job Configuration**

#### **Step 1: Create Termination Job**
1. **New Item**: `EC2-Instance-Terminator`
2. **Type**: Freestyle project

#### **Step 2: Configure Parameters**
Add these parameters:

<table>
<tr>
<th width="25%">Parameter</th>
<th width="15%">Type</th>
<th width="25%">Default Value</th>
<th width="35%">Description</th>
</tr>

<tr>
<td><strong>TAG_NAME</strong></td>
<td>String</td>
<td><code>jenkins-ec2</code></td>
<td>Tag name to identify instances for termination</td>
</tr>

<tr>
<td><strong>REGION</strong></td>
<td>Choice</td>
<td><code>us-east-1<br>us-west-2<br>eu-west-1</code></td>
<td>AWS region where instances are located</td>
</tr>

<tr>
<td><strong>CONFIRM_DELETE</strong></td>
<td>Boolean</td>
<td><code>false</code></td>
<td>Confirmation checkbox to prevent accidental deletion</td>
</tr>

</table>

#### **Step 3: Build Steps**
Add "Execute shell" build step:

```bash
#!/bin/bash

echo "🗑️ Starting EC2 Instance Termination Job"
echo "======================================="

# Safety check
if [ "$CONFIRM_DELETE" != "true" ]; then
    echo "❌ ERROR: Deletion not confirmed!"
    echo "Please check the 'CONFIRM_DELETE' parameter to proceed."
    exit 1
fi

echo "Parameters:"
echo "Tag Name: $TAG_NAME"
echo "Region: $REGION"
echo "Confirm Delete: $CONFIRM_DELETE"
echo "======================================="

# Navigate to the script directory
cd Section-2-DevOps/Session-4_Jenkins/03_basic_jobs/3.4_parameterized_job

# Make script executable
chmod +x ec2-delete.sh

# Execute the EC2 deletion script
./ec2-delete.sh

echo "✅ EC2 Instance Termination Job Completed"
```

---

## 📜 Enhanced Shell Scripts

### **🚀 EC2 Creation Script (ec2-create.sh)**

The script in your repository has been enhanced for better error handling:

```bash
#!/bin/bash

echo "🚀 Creating EC2 instances..."
echo "AMI ID: $AMI_ID"
echo "Instance Type: $INSTANCE_TYPE"
echo "Count: $COUNT"
echo "Key Pair: $KEY_PAIR_NAME"
echo "Tag Name: $TAG_NAME"
echo "Region: $REGION"

# Validate parameters
if [ -z "$AMI_ID" ] || [ -z "$INSTANCE_TYPE" ] || [ -z "$KEY_PAIR_NAME" ]; then
    echo "❌ ERROR: Missing required parameters"
    exit 1
fi

# Launch EC2 instances
echo "Launching $COUNT instance(s)..."
LAUNCH_RESULT=$(aws ec2 run-instances \
    --image-id $AMI_ID \
    --instance-type $INSTANCE_TYPE \
    --count $COUNT \
    --key-name $KEY_PAIR_NAME \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$TAG_NAME}]" \
    --region $REGION \
    --output json)

if [ $? -eq 0 ]; then
    echo "✅ Instances launched successfully!"
else
    echo "❌ Failed to launch instances"
    exit 1
fi

echo "Waiting for instances to initialize..."
sleep 30

# Get instance details
INSTANCE_IDS=$(aws ec2 describe-instances \
    --filters "Name=tag:Name,Values=$TAG_NAME" "Name=instance-state-name,Values=running,pending" \
    --query 'Reservations[*].Instances[*].InstanceId' \
    --output text \
    --region $REGION)

echo "📊 Instance Details:"
echo "==================="
for INSTANCE_ID in $INSTANCE_IDS; do
    INSTANCE_DETAILS=$(aws ec2 describe-instances \
        --instance-ids $INSTANCE_ID \
        --query 'Reservations[0].Instances[0].[InstanceId,InstanceType,PublicIpAddress,State.Name]' \
        --output text \
        --region $REGION)
    
    echo "Instance: $INSTANCE_DETAILS"
done

echo "🎉 EC2 creation process completed!"
```

### **🗑️ EC2 Termination Script (ec2-delete.sh)**

Enhanced termination script with safety checks:

```bash
#!/bin/bash

echo "🗑️ Terminating EC2 instances with tag: $TAG_NAME"
echo "Region: $REGION"

# Find instances to terminate
INSTANCE_IDS=$(aws ec2 describe-instances \
    --filters "Name=tag:Name,Values=$TAG_NAME" "Name=instance-state-name,Values=running,pending,stopped" \
    --query 'Reservations[*].Instances[*].InstanceId' \
    --output text \
    --region $REGION)

if [ -z "$INSTANCE_IDS" ]; then
    echo "ℹ️ No instances found with tag: $TAG_NAME"
    exit 0
fi

echo "Found instances to terminate: $INSTANCE_IDS"
echo "Proceeding with termination..."

# Terminate instances
aws ec2 terminate-instances --instance-ids $INSTANCE_IDS --region $REGION

if [ $? -eq 0 ]; then
    echo "✅ Termination command sent successfully!"
else
    echo "❌ Failed to send termination command"
    exit 1
fi

echo "Waiting for termination to complete..."
sleep 30

# Verify termination
echo "📊 Termination Status:"
echo "====================="
for INSTANCE_ID in $INSTANCE_IDS; do
    INSTANCE_STATE=$(aws ec2 describe-instances \
        --instance-ids $INSTANCE_ID \
        --query 'Reservations[0].Instances[0].State.Name' \
        --output text \
        --region $REGION 2>/dev/null)
    
    if [ "$INSTANCE_STATE" = "terminated" ] || [ "$INSTANCE_STATE" = "shutting-down" ]; then
        echo "✅ Instance $INSTANCE_ID: $INSTANCE_STATE"
    else
        echo "⚠️ Instance $INSTANCE_ID: $INSTANCE_STATE (may need more time)"
    fi
done

echo "🎉 EC2 termination process completed!"
```

---

## 🎯 Job Execution & Testing

### **▶️ Running the Creation Job**

1. **Navigate to Job**: Go to `EC2-Instance-Creator`
2. **Build with Parameters**: Click "Build with Parameters"
3. **Configure Parameters**:
   ```yaml
   AMI_ID: ami-0c55b159cbfafe1f0
   INSTANCE_TYPE: t2.micro
   KEY_PAIR_NAME: your-key-pair-name
   TAG_NAME: jenkins-test-ec2
   COUNT: 1
   REGION: us-east-1
   ```
4. **Build**: Click "Build"

### **📊 Expected Console Output**

```bash
🚀 Starting EC2 Instance Creation Job
==================================
Parameters:
AMI ID: ami-0c55b159cbfafe1f0
Instance Type: t2.micro
Key Pair: your-key-pair-name
Tag Name: jenkins-test-ec2
Count: 1
Region: us-east-1
==================================
🚀 Creating EC2 instances...
AMI ID: ami-0c55b159cbfafe1f0
Instance Type: t2.micro
Count: 1
Key Pair: your-key-pair-name
Tag Name: jenkins-test-ec2
Region: us-east-1
Launching 1 instance(s)...
✅ Instances launched successfully!
Waiting for instances to initialize...
📊 Instance Details:
===================
Instance: i-1234567890abcdef0	t2.micro	54.123.45.67	running
🎉 EC2 creation process completed!
✅ EC2 Instance Creation Job Completed
```

### **🗑️ Running the Termination Job**

1. **Navigate to Job**: Go to `EC2-Instance-Terminator`
2. **Build with Parameters**: Click "Build with Parameters"
3. **Configure Parameters**:
   ```yaml
   TAG_NAME: jenkins-test-ec2
   REGION: us-east-1
   CONFIRM_DELETE: ✅ (checked)
   ```
4. **Build**: Click "Build"

---

## 🔍 Advanced Parameter Types

### **🎛️ Parameter Type Examples**

<table>
<tr>
<th width="20%">Parameter Type</th>
<th width="30%">Use Case</th>
<th width="50%">Configuration Example</th>
</tr>

<tr>
<td><strong>String Parameter</strong></td>
<td>Free text input</td>
<td><code>Name: CUSTOM_TAG<br>Default: my-instance<br>Description: Custom tag for instance</code></td>
</tr>

<tr>
<td><strong>Choice Parameter</strong></td>
<td>Predefined options</td>
<td><code>Name: ENVIRONMENT<br>Choices: dev<br>staging<br>production</code></td>
</tr>

<tr>
<td><strong>Boolean Parameter</strong></td>
<td>True/false options</td>
<td><code>Name: ENABLE_MONITORING<br>Default: false<br>Description: Enable CloudWatch monitoring</code></td>
</tr>

<tr>
<td><strong>Password Parameter</strong></td>
<td>Sensitive data</td>
<td><code>Name: DB_PASSWORD<br>Description: Database password (masked)</code></td>
</tr>

<tr>
<td><strong>Multi-line String</strong></td>
<td>Large text blocks</td>
<td><code>Name: USER_DATA_SCRIPT<br>Description: EC2 user data script</code></td>
</tr>

</table>

### **🔧 Parameter Validation**

Add validation to your build scripts:

```bash
#!/bin/bash

# Validate instance count
if [ "$COUNT" -gt 5 ]; then
    echo "❌ ERROR: Maximum 5 instances allowed"
    exit 1
fi

# Validate instance type
VALID_TYPES=("t2.micro" "t2.small" "t2.medium")
if [[ ! " ${VALID_TYPES[@]} " =~ " ${INSTANCE_TYPE} " ]]; then
    echo "❌ ERROR: Invalid instance type: $INSTANCE_TYPE"
    exit 1
fi

# Validate region
VALID_REGIONS=("us-east-1" "us-west-2" "eu-west-1")
if [[ ! " ${VALID_REGIONS[@]} " =~ " ${REGION} " ]]; then
    echo "❌ ERROR: Invalid region: $REGION"
    exit 1
fi

echo "✅ All parameters validated successfully"
```

---

## 🔧 Troubleshooting Guide

### **❌ Common Issues and Solutions**

<table>
<tr>
<th width="30%">Issue</th>
<th width="35%">Cause</th>
<th width="35%">Solution</th>
</tr>

<tr>
<td><strong>AWS CLI not found</strong></td>
<td>AWS CLI not installed or not in PATH</td>
<td>• Install AWS CLI v2<br>• Verify PATH configuration<br>• Test with <code>aws --version</code></td>
</tr>

<tr>
<td><strong>Access denied errors</strong></td>
<td>Insufficient IAM permissions</td>
<td>• Check IAM user permissions<br>• Verify AWS credentials<br>• Test with <code>aws sts get-caller-identity</code></td>
</tr>

<tr>
<td><strong>Invalid AMI ID</strong></td>
<td>AMI not available in region</td>
<td>• Verify AMI exists in target region<br>• Use region-specific AMI IDs<br>• Check AMI permissions</td>
</tr>

<tr>
<td><strong>Key pair not found</strong></td>
<td>SSH key pair doesn't exist</td>
<td>• Create key pair in AWS console<br>• Verify key pair name<br>• Check region-specific keys</td>
</tr>

<tr>
<td><strong>Script permission denied</strong></td>
<td>Script not executable</td>
<td>• Add <code>chmod +x script.sh</code><br>• Check file permissions<br>• Verify script location</td>
</tr>

</table>

### **🔍 Debugging Commands**

Add these to your build steps for debugging:

```bash
# Debug AWS configuration
echo "=== AWS Configuration Debug ==="
aws configure list
aws sts get-caller-identity
echo "Current region: $(aws configure get region)"

# Debug parameters
echo "=== Parameter Debug ==="
echo "All environment variables:"
env | grep -E "(AMI_ID|INSTANCE_TYPE|KEY_PAIR_NAME|TAG_NAME|COUNT|REGION)"

# Debug script location
echo "=== Script Debug ==="
pwd
ls -la *.sh
```

---

## 🎓 Learning Outcomes

After completing this project, you will have mastered:

### **✅ Advanced Jenkins Skills**
- **Parameterized Jobs** - Create dynamic, configurable Jenkins jobs
- **Parameter Types** - Use various parameter types effectively
- **Parameter Validation** - Implement input validation and error handling
- **Build Triggers** - Configure automated and manual build triggers
- **Script Integration** - Integrate shell scripts with Jenkins jobs

### **✅ AWS Automation Skills**
- **EC2 Management** - Automate EC2 instance lifecycle management
- **AWS CLI Integration** - Use AWS CLI in Jenkins automation
- **Infrastructure as Code** - Implement infrastructure automation practices
- **Cost Management** - Create on-demand infrastructure provisioning
- **Security Best Practices** - Implement secure automation workflows

### **✅ DevOps Practices**
- **Infrastructure Automation** - Automate infrastructure provisioning
- **Self-Service Infrastructure** - Enable team self-service capabilities
- **Audit and Compliance** - Track infrastructure changes through Jenkins
- **Error Handling** - Implement robust error handling and validation
- **Documentation** - Create comprehensive automation documentation

---

## ➡️ Next Steps

<div align="center">

### 🚀 **Ready for Advanced Automation?**

</div>

1. **🔄 Add More Parameters** - Extend jobs with additional configuration options
2. **📊 Implement Notifications** - Add email/Slack notifications for job results
3. **🔐 Enhance Security** - Implement parameter encryption and validation
4. **🚀 Create Job Chains** - Link creation and termination jobs together
5. **📈 Add Monitoring** - Integrate with CloudWatch for instance monitoring
6. **🔧 Progress to Pipelines** - [Module 04: Pipeline Fundamentals](../../04_pipeline_fundamentals/README.md)

---

<div align="center">

### 🎯 **Outstanding Achievement!**
*You've mastered Jenkins parameterized jobs and AWS automation!*

**Continue Learning: [Module 04: Pipeline Fundamentals →](../../04_pipeline_fundamentals/README.md)**

</div>

---

## 🤝 Connect & Follow

<div align="center">

**Created with ❤️ by Varun Kumar Manik**

[![GitHub](https://img.shields.io/badge/GitHub-manikcloud-black?style=for-the-badge&logo=github)](https://github.com/manikcloud)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-vkmanik-blue?style=for-the-badge&logo=linkedin)](https://www.linkedin.com/in/vkmanik/)
[![Email](https://img.shields.io/badge/Email-varunmanik1%40gmail.com-red?style=for-the-badge&logo=gmail)](mailto:varunmanik1@gmail.com)
[![YouTube](https://img.shields.io/badge/YouTube-Technical%20Tutorials-red?style=for-the-badge&logo=youtube)](https://bit.ly/32fknRN)

</div>
