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

```svg
<svg width="800" height="500" xmlns="http://www.w3.org/2000/svg">
  <!-- Background -->
  <rect width="800" height="500" fill="#f8f9fa" stroke="#dee2e6" stroke-width="2"/>
  
  <!-- Title -->
  <text x="400" y="30" text-anchor="middle" font-family="Arial, sans-serif" font-size="20" font-weight="bold" fill="#2c3e50">CI/CD Pipeline Architecture</text>
  
  <!-- Developer Section -->
  <rect x="50" y="60" width="120" height="80" fill="#3498db" stroke="#2980b9" stroke-width="2" rx="5"/>
  <text x="110" y="85" text-anchor="middle" font-family="Arial, sans-serif" font-size="12" font-weight="bold" fill="white">Developer</text>
  <text x="110" y="105" text-anchor="middle" font-family="Arial, sans-serif" font-size="10" fill="white">Code Changes</text>
  <text x="110" y="120" text-anchor="middle" font-family="Arial, sans-serif" font-size="10" fill="white">Git Push</text>
  
  <!-- Git Repository -->
  <rect x="220" y="60" width="120" height="80" fill="#e74c3c" stroke="#c0392b" stroke-width="2" rx="5"/>
  <text x="280" y="85" text-anchor="middle" font-family="Arial, sans-serif" font-size="12" font-weight="bold" fill="white">Git Repository</text>
  <text x="280" y="105" text-anchor="middle" font-family="Arial, sans-serif" font-size="10" fill="white">GitHub SCM</text>
  <text x="280" y="120" text-anchor="middle" font-family="Arial, sans-serif" font-size="10" fill="white">Source Control</text>
  
  <!-- Jenkins CI/CD -->
  <rect x="390" y="60" width="120" height="80" fill="#f39c12" stroke="#e67e22" stroke-width="2" rx="5"/>
  <text x="450" y="85" text-anchor="middle" font-family="Arial, sans-serif" font-size="12" font-weight="bold" fill="white">Jenkins</text>
  <text x="450" y="105" text-anchor="middle" font-family="Arial, sans-serif" font-size="10" fill="white">CI/CD Pipeline</text>
  <text x="450" y="120" text-anchor="middle" font-family="Arial, sans-serif" font-size="10" fill="white">Automation</text>
  
  <!-- Production Server -->
  <rect x="560" y="60" width="120" height="80" fill="#27ae60" stroke="#229954" stroke-width="2" rx="5"/>
  <text x="620" y="85" text-anchor="middle" font-family="Arial, sans-serif" font-size="12" font-weight="bold" fill="white">Production</text>
  <text x="620" y="105" text-anchor="middle" font-family="Arial, sans-serif" font-size="10" fill="white">Tomcat Server</text>
  <text x="620" y="120" text-anchor="middle" font-family="Arial, sans-serif" font-size="10" fill="white">Live Application</text>
  
  <!-- Arrows -->
  <path d="M170 100 L220 100" stroke="#34495e" stroke-width="3" fill="none" marker-end="url(#arrowhead)"/>
  <path d="M340 100 L390 100" stroke="#34495e" stroke-width="3" fill="none" marker-end="url(#arrowhead)"/>
  <path d="M510 100 L560 100" stroke="#34495e" stroke-width="3" fill="none" marker-end="url(#arrowhead)"/>
  
  <!-- Pipeline Stages -->
  <rect x="50" y="200" width="700" height="120" fill="#ecf0f1" stroke="#bdc3c7" stroke-width="2" rx="5"/>
  <text x="400" y="225" text-anchor="middle" font-family="Arial, sans-serif" font-size="16" font-weight="bold" fill="#2c3e50">Pipeline Stages</text>
  
  <!-- Stage boxes -->
  <rect x="70" y="240" width="80" height="60" fill="#9b59b6" stroke="#8e44ad" stroke-width="1" rx="3"/>
  <text x="110" y="260" text-anchor="middle" font-family="Arial, sans-serif" font-size="10" font-weight="bold" fill="white">Checkout</text>
  <text x="110" y="275" text-anchor="middle" font-family="Arial, sans-serif" font-size="8" fill="white">Git Clone</text>
  <text x="110" y="290" text-anchor="middle" font-family="Arial, sans-serif" font-size="8" fill="white">Source Code</text>
  
  <rect x="170" y="240" width="80" height="60" fill="#e67e22" stroke="#d35400" stroke-width="1" rx="3"/>
  <text x="210" y="260" text-anchor="middle" font-family="Arial, sans-serif" font-size="10" font-weight="bold" fill="white">Build</text>
  <text x="210" y="275" text-anchor="middle" font-family="Arial, sans-serif" font-size="8" fill="white">Maven</text>
  <text x="210" y="290" text-anchor="middle" font-family="Arial, sans-serif" font-size="8" fill="white">Compile</text>
  
  <rect x="270" y="240" width="80" height="60" fill="#3498db" stroke="#2980b9" stroke-width="1" rx="3"/>
  <text x="310" y="260" text-anchor="middle" font-family="Arial, sans-serif" font-size="10" font-weight="bold" fill="white">Test</text>
  <text x="310" y="275" text-anchor="middle" font-family="Arial, sans-serif" font-size="8" fill="white">Unit Tests</text>
  <text x="310" y="290" text-anchor="middle" font-family="Arial, sans-serif" font-size="8" fill="white">JUnit</text>
  
  <rect x="370" y="240" width="80" height="60" fill="#f39c12" stroke="#e67e22" stroke-width="1" rx="3"/>
  <text x="410" y="260" text-anchor="middle" font-family="Arial, sans-serif" font-size="10" font-weight="bold" fill="white">Package</text>
  <text x="410" y="275" text-anchor="middle" font-family="Arial, sans-serif" font-size="8" fill="white">WAR File</text>
  <text x="410" y="290" text-anchor="middle" font-family="Arial, sans-serif" font-size="8" fill="white">Artifact</text>
  
  <rect x="470" y="240" width="80" height="60" fill="#27ae60" stroke="#229954" stroke-width="1" rx="3"/>
  <text x="510" y="260" text-anchor="middle" font-family="Arial, sans-serif" font-size="10" font-weight="bold" fill="white">Deploy</text>
  <text x="510" y="275" text-anchor="middle" font-family="Arial, sans-serif" font-size="8" fill="white">Tomcat</text>
  <text x="510" y="290" text-anchor="middle" font-family="Arial, sans-serif" font-size="8" fill="white">Production</text>
  
  <rect x="570" y="240" width="80" height="60" fill="#e74c3c" stroke="#c0392b" stroke-width="1" rx="3"/>
  <text x="610" y="260" text-anchor="middle" font-family="Arial, sans-serif" font-size="10" font-weight="bold" fill="white">Verify</text>
  <text x="610" y="275" text-anchor="middle" font-family="Arial, sans-serif" font-size="8" fill="white">Health Check</text>
  <text x="610" y="290" text-anchor="middle" font-family="Arial, sans-serif" font-size="8" fill="white">Live App</text>
  
  <!-- Technology Stack -->
  <rect x="50" y="360" width="700" height="100" fill="#34495e" stroke="#2c3e50" stroke-width="2" rx="5"/>
  <text x="400" y="385" text-anchor="middle" font-family="Arial, sans-serif" font-size="16" font-weight="bold" fill="white">Technology Stack</text>
  
  <!-- Tech icons -->
  <circle cx="120" cy="420" r="25" fill="#e74c3c"/>
  <text x="120" y="415" text-anchor="middle" font-family="Arial, sans-serif" font-size="8" font-weight="bold" fill="white">Linux</text>
  <text x="120" y="428" text-anchor="middle" font-family="Arial, sans-serif" font-size="8" fill="white">Ubuntu/AL</text>
  
  <circle cx="200" cy="420" r="25" fill="#f39c12"/>
  <text x="200" y="415" text-anchor="middle" font-family="Arial, sans-serif" font-size="8" font-weight="bold" fill="white">Git</text>
  <text x="200" y="428" text-anchor="middle" font-family="Arial, sans-serif" font-size="8" fill="white">SCM</text>
  
  <circle cx="280" cy="420" r="25" fill="#3498db"/>
  <text x="280" y="415" text-anchor="middle" font-family="Arial, sans-serif" font-size="8" font-weight="bold" fill="white">Jenkins</text>
  <text x="280" y="428" text-anchor="middle" font-family="Arial, sans-serif" font-size="8" fill="white">CI/CD</text>
  
  <circle cx="360" cy="420" r="25" fill="#e67e22"/>
  <text x="360" y="415" text-anchor="middle" font-family="Arial, sans-serif" font-size="8" font-weight="bold" fill="white">Java</text>
  <text x="360" y="428" text-anchor="middle" font-family="Arial, sans-serif" font-size="8" fill="white">11+</text>
  
  <circle cx="440" cy="420" r="25" fill="#9b59b6"/>
  <text x="440" y="415" text-anchor="middle" font-family="Arial, sans-serif" font-size="8" font-weight="bold" fill="white">Maven</text>
  <text x="440" y="428" text-anchor="middle" font-family="Arial, sans-serif" font-size="8" fill="white">Build</text>
  
  <circle cx="520" cy="420" r="25" fill="#27ae60"/>
  <text x="520" y="415" text-anchor="middle" font-family="Arial, sans-serif" font-size="8" font-weight="bold" fill="white">JUnit</text>
  <text x="520" y="428" text-anchor="middle" font-family="Arial, sans-serif" font-size="8" fill="white">Test</text>
  
  <circle cx="600" cy="420" r="25" fill="#f1c40f"/>
  <text x="600" y="415" text-anchor="middle" font-family="Arial, sans-serif" font-size="8" font-weight="bold" fill="white">Tomcat</text>
  <text x="600" y="428" text-anchor="middle" font-family="Arial, sans-serif" font-size="8" fill="white">Server</text>
  
  <circle cx="680" cy="420" r="25" fill="#e74c3c"/>
  <text x="680" y="415" text-anchor="middle" font-family="Arial, sans-serif" font-size="8" font-weight="bold" fill="white">Vaadin</text>
  <text x="680" y="428" text-anchor="middle" font-family="Arial, sans-serif" font-size="8" fill="white">UI</text>
  
  <!-- Arrow marker definition -->
  <defs>
    <marker id="arrowhead" markerWidth="10" markerHeight="7" refX="9" refY="3.5" orient="auto">
      <polygon points="0 0, 10 3.5, 0 7" fill="#34495e"/>
    </marker>
  </defs>
</svg>
```

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
