# 🎯 Final Project: Address Book CI/CD Pipeline

<div align="center">

![Jenkins Pipeline](https://img.shields.io/badge/Jenkins-Pipeline-blue?style=for-the-badge&logo=jenkins&logoColor=white)
![Java](https://img.shields.io/badge/Java-Vaadin-red?style=for-the-badge&logo=java&logoColor=white)
![Maven](https://img.shields.io/badge/Apache-Maven-orange?style=for-the-badge&logo=apache-maven&logoColor=white)
![Tomcat](https://img.shields.io/badge/Apache-Tomcat-yellow?style=for-the-badge&logo=apache-tomcat&logoColor=white)

**🚀 Complete CI/CD Pipeline | 📱 Address Book Web App | 🔧 Production Deployment**

</div>

---

## 📦 Repository Information

<div align="center">

### 🔗 **Project Repository**
**Repository URL:** `https://github.com/manikcloud/cloud-devops-learning-path.git`  
**Branch:** `main`  
**Project Path:** `Section-2-DevOps/Session-4_Jenkins/06_final_project`

</div>

```bash
# Quick Start Commands
git clone https://github.com/manikcloud/cloud-devops-learning-path.git
cd cloud-devops-learning-path/Section-2-DevOps/Session-4_Jenkins/06_final_project
```

---

## 📋 Project Overview

Build a complete CI/CD pipeline for a real-world Address Book web application using Jenkins, Maven, and Tomcat. This project demonstrates essential DevOps practices with automated testing and production deployment.

<div align="center">

### 🎯 **What You'll Build**
*Professional CI/CD pipeline with automated build, test, and deployment*

</div>

### 🎯 **Learning Objectives**
- ✅ Deploy a complete CI/CD pipeline for a real application
- ✅ Automate build, test, and deployment processes
- ✅ Deploy to Tomcat server automatically
- ✅ Master essential DevOps practices

---

## 🏗️ Application Architecture

### **📱 Address Book Application**
A modern web application built with Vaadin 7 and Java that demonstrates:

- **CRUD Operations** - Create, update, and delete contacts
- **Search & Filter** - Filter contacts by name or email
- **Vaadin UI** - Modern web interface with Java backend
- **Maven Build** - Automated build and test processes

### **🔧 Technology Stack**
- **Frontend:** Vaadin 7 Framework
- **Backend:** Java
- **Build Tool:** Apache Maven
- **Web Server:** Apache Tomcat 9
- **CI/CD:** Jenkins Pipeline

---

## 🚀 Getting Started

### **📋 Prerequisites**
- ✅ Jenkins with Pipeline plugin
- ✅ Maven configured in Jenkins
- ✅ Tomcat 9 server

### **📦 Repository Setup**

```bash
# Clone the cloud-devops-learning-path repository
git clone https://github.com/manikcloud/cloud-devops-learning-path.git

# Navigate to final project directory
cd cloud-devops-learning-path/Section-2-DevOps/Session-4_Jenkins/06_final_project

# View project contents
ls -la
```

---

## 🔧 Infrastructure Setup

### **🐱 Tomcat 9 Installation & Configuration**

#### **Step 1: Install Tomcat 9**
```bash
# Update system packages
sudo apt update -y

# Install Maven and Tomcat 9
sudo apt install maven tomcat9 tomcat9-admin -y
```

#### **Step 2: Configure Tomcat Port**
```bash
# Edit Tomcat server configuration
sudo vim /var/lib/tomcat9/conf/server.xml
```

**Update the connector configuration:**
```xml
<Connector port="8090" protocol="HTTP/1.1"
           address="0.0.0.0"
           connectionTimeout="20000"
           redirectPort="8443" />
```

#### **Step 3: Configure Tomcat Users**
```bash
# Edit tomcat users file
sudo vim /etc/tomcat9/tomcat-users.xml
```

**Add user configuration:**
```xml
<role rolename="admin-gui,manager-gui,manager-script,manager-jmx,manager-status"/>
<user username="admin" password="admin" roles="manager-gui,admin-gui,manager-script"/>
<user username="robot" password="admin" roles="manager-script"/>
```

#### **Step 4: Restart Tomcat**
```bash
# Restart Tomcat service
sudo systemctl restart tomcat9

# Verify Tomcat is running
sudo systemctl status tomcat9
```

---

## 📜 Jenkins Pipeline Configuration

### **🔧 Complete Jenkinsfile**

**Repository:** `https://github.com/manikcloud/cloud-devops-learning-path.git`  
**Branch:** `main`  
**Project Path:** `Section-2-DevOps/Session-4_Jenkins/06_final_project`

```groovy
pipeline {
    agent any
    tools {
        maven 'my_mvn'
    }
    stages {
        stage("Checkout") {   
            steps {               	 
                git branch: 'main', url: 'https://github.com/manikcloud/cloud-devops-learning-path.git'        	 
            }    
        }
        stage('Navigate to Project') {
            steps {
                dir('Section-2-DevOps/Session-4_Jenkins/06_final_project') {
                    sh "pwd && ls -la"
                }
            }
        }
        stage('Maven Clean') {
            steps {
                dir('Section-2-DevOps/Session-4_Jenkins/06_final_project') {
                    sh "mvn clean"
                }
            }
        }
        stage('Maven Build') {
            steps {
                dir('Section-2-DevOps/Session-4_Jenkins/06_final_project') {
                    sh "mvn compile"
                }
            }
        }
        stage("Unit Test") {          	 
            steps {
                dir('Section-2-DevOps/Session-4_Jenkins/06_final_project') {
                    sh "mvn test"
                }
            }
        }
        stage("Maven Package") {
            steps {
                dir('Section-2-DevOps/Session-4_Jenkins/06_final_project') {
                    sh "mvn package"
                }
            }
        }
        stage("Deploy On Server") {          	 
            steps {
                dir('Section-2-DevOps/Session-4_Jenkins/06_final_project') {
                    deploy adapters: [tomcat9(credentialsId: 'tomcat-9', path: '', url: 'http://3.82.130.168:8090')], contextPath: '/addressbook', war: '**/target/*.war'
                }
            }
        }  	
    }
    post {
        always {
            dir('Section-2-DevOps/Session-4_Jenkins/06_final_project') {
                junit 'target/surefire-reports/*.xml'
            }
        }
        success {
            echo "✅ Pipeline completed successfully!"
            echo "🚀 App URL: http://3.82.130.168:8090/addressbook/"
        }
        failure {
            echo "❌ Pipeline failed!"
        }
    }
}
```
        stage('Navigate to Project') {
            steps {
                dir('Section-2-DevOps/Session-4_Jenkins/06_final_project') {
                    sh "pwd && ls -la"
                }
            }
        }
        stage('Maven Clean') {
            steps {
                dir('Section-2-DevOps/Session-4_Jenkins/06_final_project') {
                    sh "mvn clean"
                }
            }
        }
        stage('Maven Build') {
            steps {
                dir('Section-2-DevOps/Session-4_Jenkins/06_final_project') {
                    sh "mvn compile"
                }
            }
        }
        stage("Unit Test") {          	 
            steps {
                dir('Section-2-DevOps/Session-4_Jenkins/06_final_project') {
                    sh "mvn test"
                }
            }
        }
        stage("Maven Package") {
            steps {
                dir('Section-2-DevOps/Session-4_Jenkins/06_final_project') {
                    sh "mvn package"
                }
            }
        }
        stage("Deploy On Server") {          	 
            steps {
                dir('Section-2-DevOps/Session-4_Jenkins/06_final_project') {
                    deploy adapters: [tomcat9(credentialsId: 'tomcat-9', path: '', url: 'http://3.82.130.168:8090')], contextPath: '/addressbook', war: '**/target/*.war'
                }
            }
        }  	
    }
    post {
        always {
            dir('Section-2-DevOps/Session-4_Jenkins/06_final_project') {
                junit 'target/surefire-reports/*.xml'
            }
        }
        success {
            echo "✅ Pipeline completed successfully!"
            echo "🚀 App URL: http://3.82.130.168:8090/addressbook/"
        }
        failure {
            echo "❌ Pipeline failed!"
        }
    }
}
```

---

## 🎯 Pipeline Stages Explained

### **🔄 Stage 1: Checkout**
- Clones the repository from GitHub
- Switches to the `main` branch
- Prepares the workspace for build

### **🧹 Stage 2: Maven Clean**
- Removes previous build artifacts
- Ensures clean build environment
- Prepares for fresh compilation

### **🔨 Stage 3: Maven Build**
- Compiles the Java source code
- Resolves dependencies
- Validates code compilation

### **🧪 Stage 4: Unit Test**
- Executes automated unit tests
- Generates test reports
- Validates code functionality

### **📦 Stage 5: Maven Package**
- Creates deployable WAR file
- Packages application with dependencies
- Prepares for deployment

### **🚀 Stage 6: Deploy On Server**
- Deploys WAR file to Tomcat server
- Configures application context
- Makes application available to users

---

## 📊 Manual Deployment Process

### **🔧 Local Build and Test**

```bash
# Clone the repository
git clone https://github.com/manikcloud/cloud-devops-learning-path.git

# Navigate to final project directory
cd cloud-devops-learning-path/Section-2-DevOps/Session-4_Jenkins/06_final_project

# Clean and build the project
mvn clean install

# Run the application locally (if Jetty plugin is configured)
mvn jetty:run

# Access application at http://localhost:8090
```

### **🚀 Manual Tomcat Deployment**

```bash
# Build the WAR file
mvn clean install

# Copy WAR file to Tomcat webapps
sudo cp target/addressbook.war /var/lib/tomcat9/webapps/ -v

# Access application
# URL: http://localhost:8090/addressbook/
```

---

## 🔧 Jenkins Configuration

### **📋 Required Jenkins Plugins**
- Pipeline Plugin
- Maven Integration Plugin
- Deploy to Container Plugin
- JUnit Plugin

### **🔐 Credentials Configuration**

#### **Tomcat Credentials**
```yaml
Credential ID: tomcat-9
Type: Username with password
Username: admin
Password: admin
```

### **🛠️ Tool Configuration**

#### **Maven Configuration**
```yaml
Name: my_mvn
MAVEN_HOME: /usr/share/maven
Install automatically: false
```

---

## 📱 Application Features

### **👥 Contact Management**
- **Add Contacts** - Create new contact entries
- **Edit Contacts** - Update existing contact information
- **Delete Contacts** - Remove contacts from the address book
- **Search Contacts** - Filter contacts by name or email

### **🎨 User Interface**
- **Modern Web UI** - Built with Vaadin framework
- **Responsive Design** - Works on desktop and mobile
- **Intuitive Navigation** - Easy-to-use interface
- **Real-time Updates** - Dynamic content updates

---

## 🌐 Access URLs

### **📱 Application URLs**
- **Local Development:** `http://localhost:8090/addressbook/`
- **Production:** `http://your-server-ip:8090/addressbook/`

### **🔧 Management URLs**
- **Tomcat Manager:** `http://your-server-ip:8090/manager/html`

---

## 🔧 Troubleshooting Guide

### **❌ Common Issues**

<table>
<tr>
<th width="30%">Issue</th>
<th width="35%">Cause</th>
<th width="35%">Solution</th>
</tr>

<tr>
<td><strong>Tomcat deployment fails</strong></td>
<td>Incorrect credentials or URL</td>
<td>• Verify Tomcat credentials<br>• Check server URL and port<br>• Ensure Tomcat is running</td>
</tr>

<tr>
<td><strong>Maven build fails</strong></td>
<td>Missing dependencies or Java version</td>
<td>• Check Java version compatibility<br>• Verify Maven configuration<br>• Check internet connectivity</td>
</tr>

</table>

---

## 🎓 Learning Outcomes

After completing this project, you will have mastered:

### **✅ CI/CD Pipeline Development**
- **Complete Pipeline Creation** - End-to-end automation
- **Multi-stage Builds** - Complex pipeline orchestration
- **Automated Testing** - Unit test integration
- **Deployment Automation** - Production deployment strategies

### **✅ Essential DevOps Practices**
- **Build Automation** - Maven integration
- **Automated Testing** - Unit and integration testing
- **Infrastructure Management** - Server configuration and management

### **✅ Production-Ready Skills**
- **Real Application Deployment** - Actual web application
- **Server Management** - Tomcat configuration and deployment
- **Build Monitoring** - Pipeline execution monitoring
- **Troubleshooting** - Production issue resolution

---

## 🚀 Next Steps

<div align="center">

### 🎯 **Congratulations!**
*You've built a complete enterprise-grade CI/CD pipeline!*

</div>

### **🔄 Enhancements to Consider:**
1. **🐳 Containerization** - Add Docker support
2. **☁️ Cloud Deployment** - Deploy to AWS/Azure
3. **📊 Advanced Monitoring** - Add application monitoring
4. **🔍 Code Quality** - Integrate SonarQube for analysis
5. **📧 Notifications** - Add email/Slack notifications
6. **🚀 Blue-Green Deployment** - Zero-downtime deployments

---

## 🤝 Connect & Follow

<div align="center">

**Created with ❤️ by Varun Kumar Manik**

[![GitHub](https://img.shields.io/badge/GitHub-manikcloud-black?style=for-the-badge&logo=github)](https://github.com/manikcloud)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-vkmanik-blue?style=for-the-badge&logo=linkedin)](https://www.linkedin.com/in/vkmanik/)
[![Email](https://img.shields.io/badge/Email-varunmanik1%40gmail.com-red?style=for-the-badge&logo=gmail)](mailto:varunmanik1@gmail.com)
[![YouTube](https://img.shields.io/badge/YouTube-Technical%20Tutorials-red?style=for-the-badge&logo=youtube)](https://bit.ly/32fknRN)

</div>
