# 🔄 6.2 Pipeline Deployment - Automated CI/CD

## 🎯 Objective
Automate the manual deployment process using Jenkins pipeline.

## 📋 Prerequisites
- ✅ Manual deployment completed (6.1_manual)
- ✅ Jenkins running on port 8080
- ✅ Jenkins credentials configured (tomcat-9)
- ✅ Maven tool configured (my_mvn)

---

## 🔧 Pipeline Setup

### **Step 1: Update Server IP in Jenkinsfile**
```bash
# Navigate to pipeline directory
cd cloud-devops-learning-path/Section-2-DevOps/Session-4_Jenkins/06_final_project/6.2_pipeline

# Edit Jenkinsfile
vim Jenkinsfile

# Update this line with your server IP:
SERVER_IP = 'YOUR_SERVER_IP'  // Replace with your actual server IP
```

### **Step 2: Create Jenkins Pipeline Job**
1. **Open Jenkins:** `http://YOUR_SERVER_IP:8080`
2. **New Item** → Enter name: `AddressBook-Pipeline`
3. **Select:** `Pipeline` → **OK**

### **Step 3: Configure Pipeline**
```yaml
Pipeline Definition: Pipeline script from SCM
SCM: Git
Repository URL: https://github.com/manikcloud/cloud-devops-learning-path.git
Branch Specifier: */main
Script Path: Section-2-DevOps/Session-4_Jenkins/06_final_project/6.2_pipeline/Jenkinsfile
```

### **Step 4: Save and Build**
1. **Click:** `Save`
2. **Click:** `Build Now`
3. **Monitor:** Console Output

---

## 📊 Pipeline Stages

### **🔧 Jenkinsfile Overview**
```groovy
pipeline {
    agent any
    tools { maven 'my_mvn' }
    
    environment {
        SERVER_IP = 'YOUR_SERVER_IP'
        TOMCAT_PORT = '8090'
        APP_CONTEXT = 'addressbook'
    }
    
    stages {
        stage("Checkout") { ... }
        stage("Navigate") { ... }
        stage("Clean") { ... }
        stage("Build") { ... }
        stage("Test") { ... }
        stage("Package") { ... }
        stage("Deploy") { ... }
    }
}
```

### **📈 Pipeline Flow**
1. **Checkout** → Clone repository from GitHub
2. **Navigate** → Change to project directory  
3. **Clean** → Remove previous build artifacts
4. **Build** → Compile Java source code
5. **Test** → Run unit tests
6. **Package** → Create WAR file
7. **Deploy** → Deploy to Tomcat server

---

## 🔍 Monitor Pipeline Execution

### **✅ Stage Monitoring**
```bash
# Watch Jenkins console output for:
✅ Checkout - Repository cloned successfully
✅ Navigate - Project directory found
✅ Clean - Previous builds cleaned
✅ Build - Compilation successful
✅ Test - All tests passed
✅ Package - WAR file created
✅ Deploy - Deployment to Tomcat successful
```

### **✅ Expected Console Output**
```
Started by user admin
Running in Durability level: MAX_SURVIVABILITY
[Pipeline] Start of Pipeline
[Pipeline] node
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Checkout)
[Pipeline] git
Cloning the remote Git repository...
✅ SUCCESS

[Pipeline] stage
[Pipeline] { (Deploy to Tomcat)
Deploying /var/lib/jenkins/workspace/AddressBook-Pipeline/.../*.war to container Tomcat 9.x Remote
✅ SUCCESS
```

---

## 🧪 Verify Automated Deployment

### **Step 1: Check Pipeline Success**
```bash
# In Jenkins console, look for:
✅ Pipeline completed successfully!
🚀 App URL: http://YOUR_SERVER_IP:8090/addressbook/
```

### **Step 2: Test Application**
```bash
# Access application
http://YOUR_SERVER_IP:8090/addressbook/

# Test functionality (same as manual deployment)
- Add contacts
- Edit contacts  
- Search contacts
- Delete contacts
```

### **Step 3: Compare with Manual Deployment**
```bash
# Both should produce identical results:
✅ Same WAR file deployed
✅ Same application functionality
✅ Same user experience
```

---

## 📊 Pipeline vs Manual Comparison

| Aspect | Manual Deployment | Pipeline Deployment |
|--------|------------------|-------------------|
| **Time** | 5-10 minutes | 2-3 minutes |
| **Steps** | 5 manual steps | 1 click (Build Now) |
| **Errors** | Human errors possible | Consistent execution |
| **Repeatability** | Manual each time | Automated & repeatable |
| **Scalability** | Not scalable | Scales with team |

---

## 🛠️ Troubleshooting Pipeline

### **❌ Common Pipeline Issues**

| Issue | Cause | Solution |
|-------|-------|----------|
| **Checkout fails** | Wrong repository URL | Verify GitHub repository URL |
| **Maven not found** | Tool not configured | Check Global Tool Configuration |
| **Build fails** | Code compilation error | Check code syntax and dependencies |
| **Deploy fails** | Wrong credentials | Verify tomcat-9 credentials |
| **Wrong server IP** | Hardcoded IP in Jenkinsfile | Update SERVER_IP variable |

### **🔍 Debug Steps**
```bash
# Check Jenkins logs
# Go to: Build → Console Output

# Check Tomcat logs (Ubuntu)
sudo tail -f /var/log/tomcat9/catalina.out

# Check Tomcat logs (Amazon Linux)
sudo tail -f /opt/tomcat/latest/logs/catalina.out

# Verify credentials in Jenkins
# Go to: Manage Jenkins → Manage Credentials
```

---

## 🎯 Learning Outcomes

After completing pipeline automation:

### **✅ CI/CD Understanding**
- Jenkins pipeline creation
- SCM integration with Git
- Automated build and deployment
- Pipeline monitoring and debugging

### **✅ DevOps Skills**
- Infrastructure as Code concepts
- Automation benefits
- Pipeline troubleshooting
- Continuous deployment practices

### **✅ Comparison Analysis**
- Manual vs Automated processes
- Time and effort savings
- Consistency and reliability
- Scalability advantages

---

## 🚀 Enhancement Ideas

### **🔄 Next Level Features**
1. **Multi-Environment** - Add dev, test, prod stages
2. **Notifications** - Add email/Slack notifications
3. **Quality Gates** - Add code quality checks
4. **Rollback** - Add deployment rollback capability
5. **Parallel Builds** - Run tests in parallel

### **📊 Advanced Pipeline**
```groovy
// Example enhancements
stage('Code Quality') {
    steps {
        sh 'mvn sonar:sonar'
    }
}

stage('Security Scan') {
    steps {
        sh 'mvn dependency-check:check'
    }
}
```

---

## 🎉 Project Completion

### **✅ Achievements**
- ✅ Manual deployment mastered
- ✅ Pipeline automation implemented
- ✅ CI/CD concepts understood
- ✅ DevOps practices applied

### **📈 Skills Gained**
- Jenkins pipeline development
- Maven build automation
- Tomcat deployment
- Git integration
- Troubleshooting and debugging

---

<div align="center">

**🎉 Congratulations! You've built a complete CI/CD pipeline!**

**From manual deployment to full automation - you've mastered the DevOps journey!**

[![GitHub](https://img.shields.io/badge/GitHub-manikcloud-black?style=for-the-badge&logo=github)](https://github.com/manikcloud)

</div>
