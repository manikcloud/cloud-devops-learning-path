# 🎯 Final Project: Enterprise CI/CD Pipeline with Address Book Application

<div align="center">

![Jenkins Pipeline](https://img.shields.io/badge/Jenkins-Pipeline-blue?style=for-the-badge&logo=jenkins&logoColor=white)
![Java](https://img.shields.io/badge/Java-17+-red?style=for-the-badge&logo=java&logoColor=white)
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

### **🌟 Introduction**

Welcome to the **Jenkins CI/CD Final Project** - the culmination of your DevOps learning journey! This comprehensive project bridges the gap between theoretical knowledge and real-world application by implementing a complete continuous integration and deployment pipeline.

You'll work with a **production-ready Address Book web application**, transforming it from manual deployment to fully automated enterprise-grade CI/CD. This hands-on experience mirrors what you'll encounter in professional DevOps environments, giving you the confidence and skills to excel in your career.

### **🚀 Primary Goals**
- **Master CI/CD Concepts** - Understand continuous integration and deployment workflows
- **Hands-on DevOps Tools** - Work with industry-standard tools (Jenkins, Maven, Git, Tomcat/Jetty)
- **Real Application Deployment** - Deploy actual web application with database integration
- **Automation Skills** - Transform manual processes to automated pipelines
- **Production Readiness** - Learn enterprise deployment practices and best practices

### **📚 Learning Outcomes**
- **Linux System Administration** - Ubuntu & Amazon Linux proficiency with Java 17
- **Git Version Control** - Source code management and collaboration workflows
- **Jenkins Pipeline Development** - CI/CD automation and orchestration with Jenkinsfile
- **Java Application Building** - Maven build lifecycle and dependency management
- **Automated Testing** - JUnit integration and test automation strategies
- **Web Application Deployment** - Tomcat/Jetty server configuration and WAR deployment
- **Infrastructure as Code** - Pipeline as code with declarative Jenkinsfile syntax
- **Troubleshooting Skills** - Debug build failures and deployment issues

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
- **Security:** SSH access, ports 8080 (Jenkins) and 8090 (Tomcat/Jetty) open

### **🔧 Required Software Stack**
- **Java 17+** - Runtime environment and development kit (backward compatible with Java 8 applications)
- **Maven 3.6+** - Build automation and dependency management
- **Git** - Version control system
- **Jenkins 2.400+** - CI/CD automation server
- **Jetty 11.0.24+** - Lightweight web server (Recommended)
- **Tomcat 9.0.108+** - Alternative web application server

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
├── 6.2_pipeline/                # Phase 2: Pipeline Automation
│   ├── src/                     # Same application source
│   ├── pom.xml                  # Same Maven configuration
│   ├── Jenkinsfile              # Pipeline as code
│   └── README.md                # Pipeline automation guide
└── 6.3_git_integration/         # Phase 3: Git Webhook Integration
    ├── src/                     # Same application source
    ├── pom.xml                  # Same Maven configuration
    ├── Jenkinsfile              # Webhook-enabled pipeline
    └── README.md                # Git integration guide
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

#### **Phase 3: Git Webhook Integration** → [6.3_git_integration/](./6.3_git_integration/)
- **Duration:** 45-60 minutes
- **Focus:** Automatic pipeline triggering with GitHub webhooks
- **Skills:** Webhook configuration, Git integration, event-driven CI/CD, production workflows

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
sudo apt install openjdk-17-jdk maven git -y

# Verify installations
java -version && mvn -version && git --version
```

#### **Step 4: Install Jetty (Recommended)**
```bash
# Install Jetty
sudo apt install jetty9 -y

# Start and enable Jetty
sudo systemctl enable jetty9
sudo systemctl start jetty9
sudo systemctl status jetty9
```
```

### **🔴 Amazon Linux/RHEL Systems**

#### **System Update & Java Installation**
```bash
# Update system (Amazon Linux 2)
sudo yum update -y

# Update system (Amazon Linux 2023)
sudo dnf update -y

# Install Java and Maven
sudo yum install java-17-amazon-corretto-devel maven git -y
# OR for AL2023: sudo dnf install java-17-amazon-corretto-devel maven git -y
```

#### **Step 4: Install Jetty (Recommended)**
```bash
# Download and install Jetty
cd /tmp
wget https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-home/11.0.24/jetty-home-11.0.24.tar.gz
sudo tar -xzf jetty-home-11.0.24.tar.gz -C /opt/
sudo mv /opt/jetty-home-11.0.24 /opt/jetty
sudo useradd -r -s /bin/false jetty
sudo chown -R jetty:jetty /opt/jetty

# For this project, we'll use Maven Jetty plugin instead
# This provides easier development and deployment
```

---

## 🚀 Jetty Configuration & Usage

### **🎯 Why Jetty for This Project?**
- **Lightweight** - Faster startup and lower memory usage
- **Maven Integration** - Built-in Maven plugin for easy development
- **Development Friendly** - Hot reload and quick testing
- **Production Ready** - Scales well for enterprise applications

### **🔧 Running with Maven Jetty Plugin**
```bash
# Navigate to project directory
cd your-project-directory

# Run with Jetty on port 8090 (recommended)
mvn jetty:run -Djetty.port=8090 &

# Stop Jetty
kill %1
# OR find and kill the process
ps aux | grep jetty
kill <process_id>
```

---

## 🔧 Alternative: Tomcat Installation & Configuration

### **🐧 Ubuntu Tomcat Installation**
```bash
# Install Tomcat 9
sudo apt install tomcat9 tomcat9-admin -y

# Configure and start service
sudo systemctl enable tomcat9
sudo systemctl start tomcat9
sudo systemctl status tomcat9
```

### **🔴 Amazon Linux Tomcat Installation**

#### **Download and Setup Tomcat**
```bash
# Create tomcat user and download latest Tomcat 9.0.108
sudo useradd -r -m -U -d /opt/tomcat -s /bin/false tomcat
cd /tmp && wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.108/bin/apache-tomcat-9.0.108.tar.gz

# Extract and configure
sudo tar xf apache-tomcat-9.0.108.tar.gz -C /opt/tomcat
sudo ln -s /opt/tomcat/apache-tomcat-9.0.108 /opt/tomcat/latest
sudo chown -RH tomcat: /opt/tomcat/latest
sudo sh -c 'chmod +x /opt/tomcat/latest/bin/*.sh'
```

#### **Create Systemd Service**
```bash
# Create systemd service file
sudo tee /etc/systemd/system/tomcat.service > /dev/null <<EOF
[Unit]
Description=Tomcat 9 servlet container
After=network.target

[Service]
Type=forking
User=tomcat
Group=tomcat
Environment="JAVA_HOME=/usr/lib/jvm/java-17-amazon-corretto"
Environment="JAVA_OPTS=-Djava.security.egd=file:///dev/urandom -Djava.awt.headless=true"
Environment="CATALINA_BASE=/opt/tomcat/latest"
Environment="CATALINA_HOME=/opt/tomcat/latest"
Environment="CATALINA_PID=/opt/tomcat/latest/temp/tomcat.pid"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"
ExecStart=/opt/tomcat/latest/bin/startup.sh
ExecStop=/opt/tomcat/latest/bin/shutdown.sh

[Install]
WantedBy=multi-user.target
EOF

# Start and enable Tomcat service
sudo systemctl daemon-reload
sudo systemctl enable tomcat
sudo systemctl start tomcat
sudo systemctl status tomcat
```

> **⚠️ Troubleshooting JAVA_HOME Issues:**
> If Tomcat fails to start with "JAVA_HOME environment variable is not defined correctly":
> ```bash
> # Check your Java version
> java --version
> 
> # For Java 17: Use JAVA_HOME=/usr/lib/jvm/java-17-amazon-corretto
> # For Java 11: Use JAVA_HOME=/usr/lib/jvm/java-11-amazon-corretto
> # For Java 21: Use JAVA_HOME=/usr/lib/jvm/java-21-amazon-corretto
> 
> # Update the service file with correct JAVA_HOME and reload
> sudo systemctl daemon-reload
> sudo systemctl restart tomcat
> ```

### **🔧 Tomcat Service Management**

<table>
<tr>
<th width="30%">Action</th>
<th width="35%">Ubuntu (tomcat9)</th>
<th width="35%">Amazon Linux (tomcat)</th>
</tr>

<tr>
<td><strong>Start Service</strong></td>
<td><code>sudo systemctl start tomcat9</code></td>
<td><code>sudo systemctl start tomcat</code></td>
</tr>

<tr>
<td><strong>Stop Service</strong></td>
<td><code>sudo systemctl stop tomcat9</code></td>
<td><code>sudo systemctl stop tomcat</code></td>
</tr>

<tr>
<td><strong>Restart Service</strong></td>
<td><code>sudo systemctl restart tomcat9</code></td>
<td><code>sudo systemctl restart tomcat</code></td>
</tr>

<tr>
<td><strong>Check Status</strong></td>
<td><code>sudo systemctl status tomcat9</code></td>
<td><code>sudo systemctl status tomcat</code></td>
</tr>

<tr>
<td><strong>Enable Auto-start</strong></td>
<td><code>sudo systemctl enable tomcat9</code></td>
<td><code>sudo systemctl enable tomcat</code></td>
</tr>

<tr>
<td><strong>View Logs</strong></td>
<td><code>sudo journalctl -u tomcat9 -f</code><br><code>sudo tail -f /var/log/tomcat9/catalina.out</code></td>
<td><code>sudo journalctl -u tomcat -f</code><br><code>sudo tail -f /opt/tomcat/latest/logs/catalina.out</code></td>
</tr>

</table>

### **🔍 Tomcat Configuration**

#### **Configure Port (Change from 8080 to 8090)**

**Ubuntu:**
```bash
# Edit server configuration
sudo vim /var/lib/tomcat9/conf/server.xml

# Find and change port from 8080 to 8090:
# <Connector port="8090" protocol="HTTP/1.1"
#            address="0.0.0.0"
#            connectionTimeout="20000"
#            redirectPort="8443" />
```

**Amazon Linux:**
```bash
# Edit server configuration
sudo vim /opt/tomcat/latest/conf/server.xml

# Find and change port from 8080 to 8090:
# <Connector port="8090" protocol="HTTP/1.1"
#            address="0.0.0.0"
#            connectionTimeout="20000"
#            redirectPort="8443" />
```

#### **Configure Tomcat Users**

**Ubuntu:**
```bash
# Edit tomcat users file
sudo vim /etc/tomcat9/tomcat-users.xml
```

**Amazon Linux:**
```bash
# Edit tomcat users file
sudo vim /opt/tomcat/latest/conf/tomcat-users.xml
```

**Add these lines before `</tomcat-users>` (Both Systems):**
```xml
<role rolename="admin-gui"/>
<role rolename="manager-gui"/>
<role rolename="manager-script"/>
<user username="admin" password="admin" roles="admin-gui,manager-gui,manager-script"/>
```

#### **Restart After Configuration**
```bash
# Ubuntu
sudo systemctl restart tomcat9

# Amazon Linux
sudo systemctl restart tomcat
```

### **🔧 Deployment Troubleshooting**

#### **Issue: Jenkins Deployment Fails**
**Symptoms:**
```
[DeployPublisher][INFO] Attempting to deploy 1 war file(s)
[DeployPublisher][INFO] Deploying ... to container Tomcat 9.x Remote with context /addressbook
[ERROR] Deployment failed
```

**Solution for Amazon Linux:**
```bash
# 1. Verify tomcat-users.xml configuration
sudo cat /opt/tomcat/latest/conf/tomcat-users.xml

# Should contain these lines before </tomcat-users>:
# <role rolename="admin-gui"/>
# <role rolename="manager-gui"/>
# <role rolename="manager-script"/>
# <user username="admin" password="admin" roles="admin-gui,manager-gui,manager-script"/>

# 2. Restart Tomcat after changes
sudo systemctl restart tomcat

# 3. Verify Tomcat is running on correct port
sudo netstat -tlnp | grep :8090

# 4. Test manager access manually
curl -u admin:admin http://98.86.230.111:8090/manager/text/list

# 5. If curl works but Jenkins deployment fails, check Jenkins credentials
# Ensure Jenkins credential ID 'tomcat-9' matches exactly
# Verify username: admin, password: admin

# 6. Check WAR file exists in Jenkins workspace
# In Jenkins build logs, look for: target/addressbook.war

# 7. Test manual deployment via curl
curl -u admin:admin -T target/addressbook.war \
"http://98.86.230.111:8090/manager/text/deploy?path=/addressbook&update=true"
```

**Solution for Ubuntu:**
```bash
# Same steps but use different paths:
sudo cat /etc/tomcat9/tomcat-users.xml
sudo systemctl restart tomcat9
```

#### **Issue: 403 Access Denied for Tomcat Manager**
**Error:** `403 Access Denied` when accessing manager application

**Root Cause:** Tomcat Manager restricts access by IP address by default

**IMMEDIATE FIX for Amazon Linux:**
```bash
# 1. Edit manager context.xml to remove IP restrictions
sudo vim /opt/tomcat/latest/webapps/manager/META-INF/context.xml

# 2. Find and comment out the Valve restriction line:
# Look for this line:
#   <Valve className="org.apache.catalina.valves.RemoteAddrValve" allow="127\.0\.0\.1" />
# 
# Comment it out like this:
#   <!-- <Valve className="org.apache.catalina.valves.RemoteAddrValve" allow="127\.0\.0\.1" /> -->

# 3. The file should look like this after editing:
cat << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<Context antiResourceLocking="false" privileged="true" >
  <CookieProcessor className="org.apache.tomcat.util.http.Rfc6265CookieProcessor"
                   sameSiteCookies="strict" />
  <Manager sessionAttributeValueClassNameFilter="java\.lang\.(?:Boolean|Integer|Long|Number|String)|org\.apache\.catalina\.filters\.CsrfPreventionFilter\$LruCache(?:\$1)?|java\.util\.(?:Linked)?HashMap"/>
  <!-- <Valve className="org.apache.catalina.valves.RemoteAddrValve" allow="127\.0\.0\.1" /> -->
</Context>
EOF

# 4. Also edit host-manager if it exists
sudo vim /opt/tomcat/latest/webapps/host-manager/META-INF/context.xml
# Apply same changes (comment out the Valve line)

# 5. Restart Tomcat
sudo systemctl restart tomcat

# 6. Wait a moment for Tomcat to fully restart
sleep 10

# 7. Test manager access
curl -u admin:admin http://98.86.230.111:8090/manager/text/list
```

**Expected Result After Fix:**
```
OK - Listed applications for virtual host [localhost]
/:running:0:ROOT
/addressbook:running:0:addressbook
/manager:running:0:manager
```

**Solution for Ubuntu:**
```bash
# Same steps but different paths:
sudo vim /var/lib/tomcat9/webapps/manager/META-INF/context.xml
sudo vim /var/lib/tomcat9/webapps/host-manager/META-INF/context.xml
sudo systemctl restart tomcat9
```
**When curl works but Jenkins pipeline fails:**

**Check Jenkins Deployment Configuration:**
```yaml
# Verify in Jenkins pipeline:
deploy adapters: [tomcat9(
    credentialsId: 'tomcat-9',     # Must match exactly
    path: '',                      # Leave empty
    url: "http://98.86.230.111:8090"  # Your server IP
)], 
contextPath: "/addressbook",       # Application context
war: '**/target/*.war'            # WAR file pattern
```

**Debug Steps:**
```bash
# 1. Check Jenkins credentials
# Go to: Manage Jenkins → Manage Credentials
# Verify: ID = 'tomcat-9', Username = 'admin', Password = 'admin'

# 2. Check WAR file in Jenkins workspace
# In Jenkins build console, verify:
ls -la target/*.war

# 3. Test deployment manually from Jenkins server
cd /var/lib/jenkins/workspace/AddressBook-Pipeline/Section-2-DevOps/Session-4_Jenkins/06_final_project/6.2_pipeline
curl -u admin:admin -T target/addressbook.war \
"http://98.86.230.111:8090/manager/text/deploy?path=/addressbook&update=true"

# 4. Check Tomcat logs for deployment errors
sudo tail -f /opt/tomcat/latest/logs/catalina.out
```

#### **Issue: Manager Access Works But Jenkins Deployment Still Fails**
**When curl works but Jenkins pipeline fails:**

**Check Jenkins Deployment Configuration:**
```yaml
# Verify in Jenkins pipeline:
deploy adapters: [tomcat9(
    credentialsId: 'tomcat-9',     # Must match exactly
    path: '',                      # Leave empty
    url: "http://98.86.230.111:8090"  # Your server IP
)], 
contextPath: "/addressbook",       # Application context
war: '**/target/*.war'            # WAR file pattern
```

**Additional Debug Steps:**
```bash
# 1. Check Jenkins credentials
# Go to: Manage Jenkins → Manage Credentials
# Verify: ID = 'tomcat-9', Username = 'admin', Password = 'admin'

# 2. Test deployment manually from Jenkins server
cd /var/lib/jenkins/workspace/AddressBook-Pipeline/Section-2-DevOps/Session-4_Jenkins/06_final_project/6.2_pipeline
curl -u admin:admin -T target/addressbook.war \
"http://98.86.230.111:8090/manager/text/deploy?path=/addressbook&update=true"
```

---

## 🔐 Jenkins Configuration

### **🔧 Jenkins Setup Steps**
1. **Access Jenkins:** `http://YOUR_SERVER_IP:8080`
2. **Complete Initial Setup** (if first time)
3. **Install Required Plugins**
4. **Configure Credentials**
5. **Configure Maven Tool**

---

### **📦 Step 1: Install Required Plugins**

1. **Navigate to Plugin Manager:**
   - Go to `Manage Jenkins` → `Manage Plugins`
   - Click on `Available` tab

2. **Search and Install These Plugins:**
   - **Pipeline Plugin** - For pipeline support
   - **Git Plugin** - For Git SCM integration and Pipeline script from SCM
   - **Maven Integration Plugin** - For Maven builds
   - **Deploy to Container Plugin** - For Tomcat deployment
   - **JUnit Plugin** - For test reporting

3. **Install Plugins:**
   - Check the boxes for required plugins:
     - ✅ **Pipeline Plugin**
     - ✅ **Git Plugin** 
     - ✅ **Maven Integration Plugin**
     - ✅ **Deploy to Container Plugin**
     - ✅ **JUnit Plugin**
   - Click `Install without restart`
   - Wait for installation to complete

---

### **🔑 Step 2: Configure Tomcat Credentials**

1. **Navigate to Credentials:**
   ```
   Manage Jenkins → Manage Credentials → (global) → Add Credentials
   ```

2. **Fill Credential Details:**
   ```yaml
   Kind: Username with password
   Scope: Global (Jenkins, nodes, items, all child items, etc)
   Username: admin
   Password: admin
   ID: tomcat-9
   Description: Tomcat 9 Deployment Access
   ```

3. **Step-by-Step Process:**
   - **Kind:** Select `Username with password` from dropdown
   - **Scope:** Leave as `Global`
   - **Username:** Enter `admin`
   - **Password:** Enter `admin`
   - **ID:** Enter `tomcat-9` (exactly as shown)
   - **Description:** Enter `Tomcat 9 Deployment Access`
   - Click `Create`

---
<img width="695" height="816" alt="image" src="https://github.com/user-attachments/assets/ed21fbdf-d43b-4bab-be07-fa293205db7e" />

### **🛠️ Step 3: Configure Maven Tool**

1. **Navigate to Global Tool Configuration:**
   ```
   Manage Jenkins → Global Tool Configuration
   ```

2. **Find Maven Section:**
   - Scroll down to `Maven` section
   - Click `Add Maven`

3. **Configure Maven:**
   ```yaml
   Name: maven
   Install automatically: ✅ (checked)
   Version: Latest available (e.g., 3.9.4)
   ```

4. **Step-by-Step Process:**
   - **Name:** Enter `maven` (exactly as shown)
   - **Install automatically:** Check this box ✅
   - **Version:** Select latest stable version from dropdown
   - Click `Save`

---

### **✅ Verification Steps**

#### **Verify Credentials Configuration:**
1. **Navigate to:** `Manage Jenkins` → `Manage Credentials`
2. **Click on:** `(global)` domain
3. **Check:** You should see `tomcat-9` credential listed
4. **Verify details:** Click on credential to confirm username is `admin`

#### **Verify Maven Tool Configuration:**
1. **Navigate to:** `Manage Jenkins` → `Global Tool Configuration`
2. **Scroll to:** `Maven` section
3. **Check:** You should see `maven` tool configured
4. **Verify:** Auto-install should be checked with latest version

#### **Test Jenkins Dashboard Access:**
```bash
# Open browser and navigate to:
http://YOUR_SERVER_IP:8080

# You should see:
✅ Jenkins dashboard loads successfully
✅ No plugin installation warnings
✅ "Manage Jenkins" menu accessible
```

#### **Quick Configuration Test:**
1. **Create a test job:** `New Item` → `Freestyle project` → `Test`
2. **Build Environment:** Should show Maven tool available
3. **Build Steps:** Should show "Deploy war/ear to a container" option
4. **Delete test job** after verification
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
**Step 4:** Git integration with webhooks → [6.3_git_integration/](./6.3_git_integration/)

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
