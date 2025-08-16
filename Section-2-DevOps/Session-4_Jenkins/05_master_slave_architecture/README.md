# 🏗️ Jenkins Master-Slave Architecture

<div align="center">

![Jenkins](https://img.shields.io/badge/Jenkins-Master--Slave-blue?style=for-the-badge&logo=jenkins&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-EC2-orange?style=for-the-badge&logo=linux&logoColor=white)
![Pipeline](https://img.shields.io/badge/Pipeline-Hello%20World-green?style=for-the-badge&logo=pipeline&logoColor=white)

**🎯 Simple Setup | 🔄 Distributed Builds | 🚀 Hello World Pipeline**

</div>

---

## 🌟 Overview

Learn Jenkins Master-Slave architecture with a **simple Hello World pipeline** running on two EC2 instances. This demonstrates how to distribute build workloads across multiple servers.

### **🎯 What You'll Learn:**
- **Master-Slave Setup** - Connect two EC2 instances
- **Distributed Builds** - Run jobs on remote slave
- **Simple Pipeline** - Hello World example
- **SSH Connection** - Secure slave communication

---

## 🏗️ Architecture

![Master-Slave Architecture](./master-slave-architecture.svg)

*Simple Jenkins Master-Slave setup for distributed Hello World pipeline execution*

```
┌─────────────────┐    SSH    ┌─────────────────┐
│  Jenkins Master │ ────────► │  Jenkins Slave  │
│  (Main Server)  │           │  (Worker Node)  │
│  98.86.230.111  │           │  YOUR_SLAVE_IP  │
└─────────────────┘           └─────────────────┘
```

---

## 🚀 Quick Setup Guide

### **Prerequisites:**
- ✅ **Jenkins Master** - Already running (98.86.230.111:8080)
- ✅ **Second EC2 Instance** - Your new Linux VM
- ✅ **SSH Access** - Between master and slave

---

## 📋 Step-by-Step Setup

### **Step 1: Prepare Slave Server**

**On your second EC2 instance:**

```bash
# Update system
sudo yum update -y

# Install Java (required for Jenkins slave)
sudo yum install java-17-amazon-corretto -y

# Verify Java installation
java -version

# Create workspace directory for Jenkins (using ec2-user)
mkdir -p /home/ec2-user/jenkins-workspace
```

### **Step 2: Use Existing SSH Keys**

**No need to create new keys! Use your existing EC2 SSH setup:**

```bash
# On Jenkins Master, you already have access via ec2-user
# Test SSH connection to slave (replace with your slave IP)
ssh -i /path/to/your/key.pem ec2-user@YOUR_SLAVE_IP

# Example:
# ssh -i ~/.ssh/my-key.pem ec2-user@10.0.1.100
```

### **Step 3: Configure Jenkins Master SSH**

**Copy your existing SSH key to Jenkins user on master:**

```bash
# On Jenkins Master (98.86.230.111)
sudo mkdir -p /var/lib/jenkins/.ssh
sudo cp /home/ec2-user/.ssh/your-key.pem /var/lib/jenkins/.ssh/
sudo chown jenkins:jenkins /var/lib/jenkins/.ssh/your-key.pem
sudo chmod 600 /var/lib/jenkins/.ssh/your-key.pem

# Or if you have the key locally, copy it:
# sudo cp /path/to/your/key.pem /var/lib/jenkins/.ssh/
```

### **Step 4: Add Slave Node in Jenkins**

**In Jenkins Web UI:**

1. **Navigate to Nodes:**
   ```
   Jenkins Dashboard → Manage Jenkins → Manage Nodes and Clouds
   ```

2. **Add New Node:**
   ```
   New Node → Node name: "ec2-slave-1" → Permanent Agent → OK
   ```

3. **Configure Node (Using ec2-user):**
   ```yaml
   Name: ec2-slave-1
   Description: EC2 Slave using ec2-user
   Number of executors: 2
   Remote root directory: /home/ec2-user/jenkins-workspace
   Labels: ec2 slave linux
   Usage: Use this node as much as possible
   Launch method: Launch agents via SSH
   Host: YOUR_SLAVE_IP
   Credentials: Add → SSH Username with private key
     Username: ec2-user
     Private Key: Enter directly → [Paste your .pem key content]
   Host Key Verification Strategy: Non verifying Verification Strategy
   ```

4. **Save and Launch:**
   ```
   Save → Launch agent
   ```

---

## 🎯 Hello World Pipeline

### **Create Simple Pipeline Job:**

1. **New Pipeline:**
   ```
   Jenkins Dashboard → New Item → Pipeline → Name: "hello-world-ec2-slave"
   ```

2. **Pipeline Script (Updated for ec2-user):**
   ```groovy
   pipeline {
       agent {
           label 'ec2'
       }
       
       stages {
           stage('Hello from EC2 Slave') {
               steps {
                   script {
                       echo "🎉 Hello World from EC2 Jenkins Slave!"
                       echo "Running on: ${env.NODE_NAME}"
                       echo "Workspace: ${env.WORKSPACE}"
                       echo "User: ec2-user (no need for separate jenkins user!)"
                   }
               }
           }
           
           stage('Simple Commands') {
               steps {
                   echo "Executing simple commands on EC2 slave..."
                   sh 'echo "This is running on EC2 slave with ec2-user!"'
                   sh 'whoami'
                   sh 'pwd'
                   sh 'ls -la'
                   sh 'df -h'
                   sh 'free -m'
               }
           }
           
           stage('Create Test File') {
               steps {
                   sh '''
                   echo "Hello from EC2 Jenkins Slave!" > hello-ec2-slave.txt
                   echo "Generated on: $(date)" >> hello-ec2-slave.txt
                   echo "Hostname: $(hostname)" >> hello-ec2-slave.txt
                   echo "User: $(whoami)" >> hello-ec2-slave.txt
                   echo "Working Directory: $(pwd)" >> hello-ec2-slave.txt
                   cat hello-ec2-slave.txt
                   '''
               }
           }
       }
       
       post {
           success {
               echo "✅ Hello World pipeline completed successfully on EC2 slave!"
               echo "Using existing ec2-user - much simpler setup!"
           }
           failure {
               echo "❌ Pipeline failed on EC2 slave node"
           }
       }
   }
   ```

---

## 🔧 Troubleshooting

### **Common Issues:**

#### **SSH Connection Failed:**
```bash
# Test SSH connectivity from master using your existing key
ssh -i /path/to/your/key.pem ec2-user@YOUR_SLAVE_IP

# Example:
ssh -i ~/.ssh/my-key.pem ec2-user@10.0.1.100

# Verify SSH service on slave
sudo systemctl status sshd
sudo systemctl start sshd
```

#### **Java Not Found:**
```bash
# Install Java on slave
sudo yum install java-17-amazon-corretto -y

# Check Java path
which java
/usr/bin/java -version
```

#### **Permission Issues:**
```bash
# Ensure ec2-user has proper permissions
sudo chown -R ec2-user:ec2-user /home/ec2-user/jenkins-workspace
chmod 755 /home/ec2-user/jenkins-workspace

# Check Jenkins master key permissions
sudo chmod 600 /var/lib/jenkins/.ssh/your-key.pem
sudo chown jenkins:jenkins /var/lib/jenkins/.ssh/your-key.pem
```

#### **Security Group Issues:**
```bash
# Ensure SSH port 22 is open between master and slave
# In AWS Console: Security Groups → Edit inbound rules
# Add rule: SSH (22) from Master's security group or IP
```

---

## 🎯 Testing Your Setup

### **Verify Slave Connection:**

1. **Check Node Status:**
   ```
   Jenkins → Manage Nodes → ec2-slave-1 should show "In sync"
   ```

2. **Run Hello World Pipeline:**
   ```
   Build Now → Check Console Output
   Should show: "Running on ec2-slave-1"
   ```

3. **Expected Output:**
   ```
   🎉 Hello World from EC2 Jenkins Slave!
   Running on: ec2-slave-1
   Workspace: /home/ec2-user/jenkins-workspace/hello-world-ec2-slave
   User: ec2-user (no need for separate jenkins user!)
   [ec2-slave-1] $ whoami
   ec2-user
   [ec2-slave-1] $ hostname
   YOUR_SLAVE_HOSTNAME
   ```

---

## 🏆 Success Indicators

### **✅ Setup Complete When:**
- EC2 slave node shows "In sync" status
- Hello World pipeline runs on ec2-user
- Console output shows slave hostname
- Files created in `/home/ec2-user/jenkins-workspace/`
- No SSH connection errors
- **Much simpler than creating separate jenkins user!**

### **🎉 Advantages of Using ec2-user:**
- ✅ **No new user creation** - Use existing EC2 setup
- ✅ **Existing SSH keys** - No key generation needed
- ✅ **Familiar environment** - Same user you always use
- ✅ **Simpler permissions** - No complex user management
- ✅ **Faster setup** - Skip user creation steps

### **🎉 Congratulations!**
You've successfully set up Jenkins Master-Slave architecture with a working Hello World pipeline!

---

## 🚀 Next Steps

### **Expand Your Setup:**
1. **Add More Slaves** - Scale to multiple worker nodes
2. **Label-Based Routing** - Route specific jobs to specific slaves
3. **Load Balancing** - Distribute builds across slaves
4. **Monitoring** - Track slave performance and usage

### **Advanced Pipelines:**
1. **Parallel Builds** - Run jobs simultaneously on multiple slaves
2. **Matrix Builds** - Test across different environments
3. **Conditional Execution** - Route based on conditions

---

*Simple, effective, and ready for production scaling!* 🚀
