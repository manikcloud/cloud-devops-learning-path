# 🎯 Final Project: Enterprise CI/CD Pipeline with Address Book Application

<div align="center">

![Jenkins Pipeline](https://img.shields.io/badge/Jenkins-Pipeline-blue?style=for-the-badge&logo=jenkins&logoColor=white)
![Java](https://img.shields.io/badge/Java-11+-red?style=for-the-badge&logo=java&logoColor=white)
![Maven](https://img.shields.io/badge/Apache-Maven-orange?style=for-the-badge&logo=apache-maven&logoColor=white)
![Tomcat](https://img.shields.io/badge/Apache-Tomcat-yellow?style=for-the-badge&logo=apache-tomcat&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-Ubuntu%20%7C%20Amazon-green?style=for-the-badge&logo=linux&logoColor=white)
![Git](https://img.shields.io/badge/Git-SCM-black?style=for-the-badge&logo=git&logoColor=white)

**🚀 Complete DevOps Implementation | 📱 Real-World Application | 🔧 Production-Ready Pipeline**

</div>

---

## 🌟 Project Overview

This capstone project demonstrates a **complete DevOps implementation** using industry-standard tools and practices. You'll build an end-to-end CI/CD pipeline for a real Address Book web application, progressing from manual deployment to full automation.

<div align="center">

### 🎯 **What You'll Master**
*Transform from manual deployment to enterprise-grade automation*

</div>

## 🏗️ Architecture & Technology Stack

<div align="center">

![CI/CD Pipeline Architecture](./cicd-architecture.svg)

</div>

---

## 🎯 Project Objectives

### **🚀 Primary Goals**
- **Master CI/CD Concepts** - Understand continuous integration and deployment
- **Hands-on DevOps Tools** - Work with industry-standard tools
- **Real Application Deployment** - Deploy actual web application
- **Automation Skills** - Transform manual processes to automated pipelines
- **Production Readiness** - Learn enterprise deployment practices

### **📚 Learning Outcomes**
- **Linux System Administration** - Ubuntu & Amazon Linux proficiency
- **Git Version Control** - Source code management and collaboration
- **Jenkins Pipeline Development** - CI/CD automation and orchestration
- **Java Application Building** - Maven build lifecycle and dependency management
- **Automated Testing** - JUnit integration and test automation
- **Web Application Deployment** - Tomcat server configuration and WAR deployment
- **Infrastructure as Code** - Pipeline as code with Jenkinsfile

---

## 🏗️ Technology Deep Dive

<table>
<tr>
<th width="20%">Technology</th>
<th width="25%">Purpose</th>
<th width="30%">Skills Gained</th>
<th width="25%">Industry Relevance</th>
</tr>

<tr>
<td><strong>🐧 Linux</strong><br><small>Ubuntu/Amazon Linux</small></td>
<td>Server Operating System</td>
<td>• Command line proficiency<br>• System administration<br>• Package management</td>
<td>90% of servers run Linux</td>
</tr>

<tr>
<td><strong>📚 Git</strong><br><small>Version Control</small></td>
<td>Source Code Management</td>
<td>• Repository management<br>• Branching strategies<br>• Collaboration workflows</td>
<td>Industry standard for SCM</td>
</tr>

<tr>
<td><strong>🔧 Jenkins</strong><br><small>CI/CD Platform</small></td>
<td>Build Automation</td>
<td>• Pipeline development<br>• Job configuration<br>• Plugin ecosystem</td>
<td>Leading CI/CD tool</td>
</tr>

<tr>
<td><strong>☕ Java</strong><br><small>Programming Language</small></td>
<td>Application Development</td>
<td>• Object-oriented programming<br>• Enterprise applications<br>• JVM ecosystem</td>
<td>Enterprise standard</td>
</tr>

<tr>
<td><strong>🔨 Maven</strong><br><small>Build Tool</small></td>
<td>Dependency Management</td>
<td>• Build lifecycle<br>• Dependency resolution<br>• Project structure</td>
<td>Java build standard</td>
</tr>

<tr>
<td><strong>🧪 JUnit</strong><br><small>Testing Framework</small></td>
<td>Automated Testing</td>
<td>• Unit test development<br>• Test automation<br>• Quality assurance</td>
<td>Testing best practices</td>
</tr>

<tr>
<td><strong>🌐 Tomcat</strong><br><small>Web Server</small></td>
<td>Application Deployment</td>
<td>• Web server configuration<br>• Application deployment<br>• Production management</td>
<td>Java web standard</td>
</tr>

</table>

---

## 📋 Prerequisites & Environment

### **💻 System Requirements**
- **Operating System:** Ubuntu 20.04+ or Amazon Linux 2/2023
- **Hardware:** 2+ CPU cores, 4GB+ RAM, 20GB+ storage
- **Network:** Public IP address with internet access
- **Security:** SSH access, ports 8080 (Jenkins) and 8090 (Tomcat) open

### **🔧 Required Software Stack**
- **Java 11+** - Runtime environment and development kit
- **Maven 3.6+** - Build automation and dependency management
- **Git** - Version control system
- **Jenkins 2.400+** - CI/CD automation server
- **Tomcat 9** - Web application server

### **☁️ Cloud Platform Support**
- **AWS EC2** - Amazon Linux 2/2023, Ubuntu instances
- **Azure VM** - Ubuntu virtual machines
- **Google Cloud** - Compute Engine instances
- **On-Premises** - Physical or virtual Linux servers

---

## 🎯 Project Structure & Learning Path

### **📁 Project Organization**
```
06_final_project/
├── README.md                    # This comprehensive guide
├── 6.1_manual/                  # Phase 1: Manual Deployment
│   ├── src/                     # Address Book source code
│   ├── pom.xml                  # Maven project configuration
│   ├── build.xml                # Ant build configuration
│   └── README.md                # Manual deployment guide
└── 6.2_pipeline/                # Phase 2: Pipeline Automation
    ├── src/                     # Same application source
    ├── pom.xml                  # Same Maven configuration
    ├── Jenkinsfile              # Pipeline as code
    └── README.md                # Pipeline automation guide
```

### **🎓 Learning Progression**

#### **Phase 0: Infrastructure Setup**
- **Duration:** 30-45 minutes
- **Focus:** Environment preparation and tool installation
- **Skills:** Linux administration, software installation, system configuration

#### **Phase 1: Manual Deployment** → [6.1_manual/](./6.1_manual/)
- **Duration:** 45-60 minutes
- **Focus:** Understanding the deployment process step-by-step
- **Skills:** Maven builds, WAR deployment, Tomcat configuration, troubleshooting

#### **Phase 2: Pipeline Automation** → [6.2_pipeline/](./6.2_pipeline/)
- **Duration:** 60-90 minutes
- **Focus:** Automating manual processes with Jenkins
- **Skills:** Pipeline development, SCM integration, automated deployment, monitoring

---

## 🚀 Address Book Application

### **📱 Application Features**
- **Contact Management** - Add, edit, delete contacts
- **Search & Filter** - Real-time contact search
- **Responsive UI** - Modern Vaadin-based interface
- **Data Persistence** - In-memory contact storage
- **RESTful Architecture** - Clean separation of concerns

### **🏗️ Technical Architecture**
- **Frontend:** Vaadin 7 Framework (Java-based UI)
- **Backend:** Java servlets and business logic
- **Build System:** Maven with standard directory structure
- **Testing:** JUnit unit tests with Maven Surefire
- **Packaging:** WAR file for Tomcat deployment
- **Configuration:** Standard Java web application structure

### **📊 Application Metrics**
- **Lines of Code:** ~2,000 Java LOC
- **Test Coverage:** Unit tests for core functionality
- **Build Time:** ~2-3 minutes (clean build)
- **Deployment Size:** ~15MB WAR file
- **Startup Time:** ~10-15 seconds on Tomcat

---

## 🔧 Installation Guide

### **🐧 Ubuntu/Debian Systems**

#### **System Update & Java Installation**
```bash
# Update system packages
sudo apt update && sudo apt upgrade -y

# Install OpenJDK 11
sudo apt install openjdk-11-jdk maven git -y

# Verify installations
java -version && mvn -version && git --version
```

#### **Tomcat 9 Installation**
```bash
# Install Tomcat 9
sudo apt install tomcat9 tomcat9-admin -y

# Configure and start service
sudo systemctl enable tomcat9
sudo systemctl start tomcat9
```

### **🔴 Amazon Linux/RHEL Systems**

#### **System Update & Java Installation**
```bash
# Update system (Amazon Linux 2)
sudo yum update -y

# Update system (Amazon Linux 2023)
sudo dnf update -y

# Install Java and Maven
sudo yum install java-11-amazon-corretto-devel maven git -y
# OR for AL2023: sudo dnf install java-11-amazon-corretto-devel maven git -y
```

#### **Tomcat 9 Manual Installation**
```bash
# Create tomcat user and download Tomcat
sudo useradd -r -m -U -d /opt/tomcat -s /bin/false tomcat
cd /tmp && wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.82/bin/apache-tomcat-9.0.82.tar.gz

# Extract and configure
sudo tar xf apache-tomcat-9.0.82.tar.gz -C /opt/tomcat
sudo ln -s /opt/tomcat/apache-tomcat-9.0.82 /opt/tomcat/latest
sudo chown -RH tomcat: /opt/tomcat/latest
```

---

## 🔐 Jenkins Configuration

### **🔧 Jenkins Setup Steps**
1. **Access Jenkins:** `http://YOUR_SERVER_IP:8080`
2. **Install Required Plugins:**
   - Pipeline Plugin
   - Maven Integration Plugin
   - Deploy to Container Plugin
   - JUnit Plugin

### **🔑 Credentials Configuration**
```yaml
Tomcat Deployment Credentials:
  Credential ID: tomcat-9
  Type: Username with password
  Username: admin
  Password: admin
  Description: Tomcat 9 Deployment Access
```

### **🛠️ Tool Configuration**
```yaml
Maven Configuration:
  Name: my_mvn
  Install automatically: ✅
  Version: Latest stable (3.9.x)
```

---

## 🎯 Success Metrics & Validation

### **✅ Phase 1 Success Criteria**
- [ ] Application builds successfully with Maven
- [ ] WAR file deploys to Tomcat without errors
- [ ] Web interface accessible via browser
- [ ] All CRUD operations functional
- [ ] No errors in application logs

### **✅ Phase 2 Success Criteria**
- [ ] Jenkins pipeline executes all stages successfully
- [ ] Automated deployment matches manual deployment
- [ ] Pipeline completes in under 5 minutes
- [ ] Application automatically available after pipeline
- [ ] Pipeline can be triggered by code changes

### **📊 Performance Benchmarks**
- **Manual Deployment Time:** 8-12 minutes
- **Automated Pipeline Time:** 3-5 minutes
- **Build Success Rate:** >95%
- **Deployment Success Rate:** >98%
- **Application Startup Time:** <30 seconds

---

## 🚀 Getting Started

<div align="center">

### **🎯 Ready to Begin Your DevOps Journey?**

**Step 1:** Complete infrastructure setup (this README)  
**Step 2:** Master manual deployment → [6.1_manual/](./6.1_manual/)  
**Step 3:** Automate with pipelines → [6.2_pipeline/](./6.2_pipeline/)

</div>

### **🔧 Quick Start Checklist**
- [ ] Linux server with public IP ready
- [ ] Security groups configured (ports 22, 8080, 8090)
- [ ] SSH access established
- [ ] Ready to install software stack

---

## 🎓 Career Impact

### **💼 Industry Skills Gained**
- **DevOps Engineering** - CI/CD pipeline development
- **Site Reliability Engineering** - Automated deployment practices
- **Cloud Engineering** - Infrastructure and application management
- **Software Engineering** - Build automation and testing

### **📈 Market Value**
- **DevOps Engineers:** $95K - $165K annually
- **Jenkins Specialists:** High demand across industries
- **CI/CD Expertise:** Essential for modern development teams
- **Automation Skills:** 40%+ salary premium over manual processes

---

<div align="center">

## 🚀 **Transform Your Career with Enterprise DevOps Skills**

**From Manual Deployment to Full Automation Mastery**

[![Start Manual Deployment](https://img.shields.io/badge/Start-6.1%20Manual%20Deployment-blue?style=for-the-badge)](./6.1_manual/)
[![Automate with Pipeline](https://img.shields.io/badge/Automate-6.2%20Pipeline-green?style=for-the-badge)](./6.2_pipeline/)

---

**Created with ❤️ by [Varun Kumar Manik](https://github.com/manikcloud)**  
*AWS Ambassador | Kubernetes Expert | DevOps Specialist*

</div>
