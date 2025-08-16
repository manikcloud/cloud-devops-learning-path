# 🎯 Final Project: Address Book CI/CD Pipeline

<div align="center">

![Jenkins Pipeline](https://img.shields.io/badge/Jenkins-Pipeline-blue?style=for-the-badge&logo=jenkins&logoColor=white)
![Java](https://img.shields.io/badge/Java-Vaadin-red?style=for-the-badge&logo=java&logoColor=white)
![Maven](https://img.shields.io/badge/Apache-Maven-orange?style=for-the-badge&logo=apache-maven&logoColor=white)
![Tomcat](https://img.shields.io/badge/Apache-Tomcat-yellow?style=for-the-badge&logo=apache-tomcat&logoColor=white)

**📱 Address Book Web App | 🔧 Manual → Pipeline Deployment**

</div>

---

## 📋 Project Overview

Build a CI/CD pipeline for an Address Book web application. First deploy manually, then automate with Jenkins pipeline.

### 🎯 **Learning Steps**
1. **Manual Deployment** - Deploy application manually to understand the process
2. **Pipeline Automation** - Automate the same process using Jenkins

---

## 🔧 Infrastructure Setup

### **Step 1: Install Required Software**
```bash
# Update system
sudo apt update -y

# Install Maven and Tomcat 9
sudo apt install maven tomcat9 tomcat9-admin -y
```

### **Step 2: Configure Tomcat**
```bash
# Edit Tomcat server configuration
sudo vim /var/lib/tomcat9/conf/server.xml
```

**Change port from 8080 to 8090:**
```xml
<Connector port="8090" protocol="HTTP/1.1"
           address="0.0.0.0"
           connectionTimeout="20000"
           redirectPort="8443" />
```

### **Step 3: Configure Tomcat Users**
```bash
# Edit tomcat users file
sudo vim /etc/tomcat9/tomcat-users.xml
```

**Add these lines before `</tomcat-users>`:**
```xml
<role rolename="admin-gui,manager-gui,manager-script"/>
<user username="admin" password="admin" roles="manager-gui,admin-gui,manager-script"/>
```

### **Step 4: Restart Tomcat**
```bash
# Restart Tomcat service
sudo systemctl restart tomcat9

# Check status
sudo systemctl status tomcat9
```

---

## 📁 Project Structure

```
06_final_project/
├── manual_deployment/          # Manual deployment files
│   ├── src/                   # Java source code
│   ├── pom.xml               # Maven configuration
│   └── build.xml             # Build configuration
├── pipeline_deployment/       # Pipeline automation files
│   ├── src/                  # Same source code
│   ├── pom.xml              # Same Maven configuration
│   └── Jenkinsfile          # Jenkins pipeline
└── README.md                # This guide
```

---

## 🚀 Part 1: Manual Deployment

### **Step 1: Clone Repository**
```bash
# Clone the repository
git clone https://github.com/manikcloud/cloud-devops-learning-path.git

# Navigate to manual deployment
cd cloud-devops-learning-path/Section-2-DevOps/Session-4_Jenkins/06_final_project/manual_deployment
```

### **Step 2: Build Application**
```bash
# Clean and build
mvn clean install

# Check if WAR file is created
ls -la target/
```

### **Step 3: Deploy to Tomcat**
```bash
# Copy WAR file to Tomcat webapps
sudo cp target/addressbook.war /var/lib/tomcat9/webapps/

# Check deployment
ls -la /var/lib/tomcat9/webapps/
```

### **Step 4: Access Application**
```bash
# Replace YOUR_SERVER_IP with your actual server IP
# Example: http://3.82.130.168:8090/addressbook/
http://YOUR_SERVER_IP:8090/addressbook/
```

### **Step 5: Verify Manual Deployment**
- Open browser and go to `http://YOUR_SERVER_IP:8090/addressbook/`
- You should see the Address Book application
- Try adding/editing contacts to test functionality

---

## 🔄 Part 2: Pipeline Automation

### **Step 1: Jenkins Setup**
```bash
# Install Jenkins (if not already installed)
# Configure Maven in Jenkins Global Tools
# Name: my_mvn
# MAVEN_HOME: /usr/share/maven
```

### **Step 2: Configure Jenkins Credentials**
```yaml
# Add Tomcat credentials in Jenkins
Credential ID: tomcat-9
Type: Username with password
Username: admin
Password: admin
```

### **Step 3: Create Jenkins Pipeline Job**
1. **New Item** → **Pipeline**
2. **Pipeline Definition:** Pipeline script from SCM
3. **SCM:** Git
4. **Repository URL:** `https://github.com/manikcloud/cloud-devops-learning-path.git`
5. **Branch:** `main`
6. **Script Path:** `Section-2-DevOps/Session-4_Jenkins/06_final_project/pipeline_deployment/Jenkinsfile`

### **Step 4: Update Server IP in Jenkinsfile**
```bash
# Edit the Jenkinsfile
cd pipeline_deployment
vim Jenkinsfile

# Replace 3.82.130.168 with your server IP in these lines:
# - Tomcat URL in deploy stage
# - App URL in success message
```

### **Step 5: Run Pipeline**
1. **Build Now** in Jenkins
2. **Monitor Console Output**
3. **Check each stage completion**

---

## 📜 Pipeline Stages

### **🔧 Jenkinsfile Overview**
```groovy
pipeline {
    agent any
    tools {
        maven 'my_mvn'
    }
    
    environment {
        TOMCAT_URL = 'http://YOUR_SERVER_IP:8090'
        APP_CONTEXT = '/addressbook'
    }
    
    stages {
        stage("Checkout") { ... }
        stage("Build") { ... }
        stage("Test") { ... }
        stage("Package") { ... }
        stage("Deploy") { ... }
    }
}
```

### **📊 Pipeline Flow**
1. **Checkout** → Get code from repository
2. **Build** → Compile Java code with Maven
3. **Test** → Run unit tests
4. **Package** → Create WAR file
5. **Deploy** → Deploy to Tomcat server

---

## 🔍 Verification Steps

### **✅ Manual Deployment Check**
```bash
# Check if WAR is deployed
ls -la /var/lib/tomcat9/webapps/

# Check Tomcat logs
sudo tail -f /var/log/tomcat9/catalina.out

# Test application
curl http://YOUR_SERVER_IP:8090/addressbook/
```

### **✅ Pipeline Deployment Check**
```bash
# Check Jenkins console output
# Verify each stage passes
# Check final deployment message
# Test application URL
```

---

## 🛠️ Troubleshooting

### **❌ Common Issues**

| Issue | Solution |
|-------|----------|
| **Port 8090 not accessible** | Check firewall: `sudo ufw allow 8090` |
| **Tomcat not starting** | Check logs: `sudo journalctl -u tomcat9` |
| **WAR not deploying** | Check permissions: `sudo chown tomcat9:tomcat9 /var/lib/tomcat9/webapps/` |
| **Maven build fails** | Check Java version: `java -version` |
| **Jenkins can't connect to Tomcat** | Verify credentials and URL |

---

## 🎯 Learning Outcomes

After completing this project:

### **✅ Manual Deployment Skills**
- Maven build process
- WAR file creation
- Tomcat deployment
- Application testing

### **✅ Pipeline Automation Skills**
- Jenkins pipeline creation
- SCM integration
- Automated deployment
- Build monitoring

### **✅ DevOps Understanding**
- Manual vs Automated processes
- CI/CD pipeline benefits
- Infrastructure as Code basics
- Production deployment practices

---

## 🚀 Next Steps

1. **Add more stages** - Code quality checks, security scans
2. **Environment variables** - Make pipeline more flexible
3. **Multi-environment deployment** - Dev, Test, Prod
4. **Rollback strategies** - Handle deployment failures
5. **Monitoring** - Add application monitoring

---

<div align="center">

**🎉 Congratulations! You've built a complete CI/CD pipeline!**

[![GitHub](https://img.shields.io/badge/GitHub-manikcloud-black?style=for-the-badge&logo=github)](https://github.com/manikcloud)

</div>
