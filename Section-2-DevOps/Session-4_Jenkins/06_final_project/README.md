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

Build a CI/CD pipeline for an Address Book web application. Learn by doing manual deployment first, then automate with Jenkins pipeline.

### 🎯 **Learning Path**
1. **Setup Infrastructure** - Install required software
2. **6.1 Manual Deployment** - Deploy application manually
3. **6.2 Pipeline Automation** - Automate with Jenkins

---

## 🔧 Infrastructure Setup

### **Prerequisites**
- EC2 instance or server with public IP
- Security group allowing ports: 22 (SSH), 8080 (Jenkins), 8090 (Tomcat)
- Java 11 or higher

---

## 📦 Installation Steps

### **🐧 For Ubuntu/Debian Systems**

#### **Step 1: Update System**
```bash
sudo apt update -y
sudo apt upgrade -y
```

#### **Step 2: Install Java**
```bash
# Install OpenJDK 11
sudo apt install openjdk-11-jdk -y

# Verify installation
java -version
javac -version
```

#### **Step 3: Install Maven**
```bash
# Install Maven
sudo apt install maven -y

# Verify installation
mvn -version
```

#### **Step 4: Install Tomcat 9**
```bash
# Install Tomcat 9
sudo apt install tomcat9 tomcat9-admin -y

# Start and enable Tomcat
sudo systemctl start tomcat9
sudo systemctl enable tomcat9

# Check status
sudo systemctl status tomcat9
```

---

### **🔴 For Amazon Linux/RHEL/CentOS Systems**

#### **Step 1: Update System**
```bash
sudo yum update -y
# OR for Amazon Linux 2023
sudo dnf update -y
```

#### **Step 2: Install Java**
```bash
# For Amazon Linux 2
sudo yum install java-11-amazon-corretto-devel -y

# For Amazon Linux 2023
sudo dnf install java-11-amazon-corretto-devel -y

# Verify installation
java -version
javac -version
```

#### **Step 3: Install Maven**
```bash
# For Amazon Linux 2
sudo yum install maven -y

# For Amazon Linux 2023
sudo dnf install maven -y

# Verify installation
mvn -version
```

#### **Step 4: Install Tomcat 9**
```bash
# Create tomcat user
sudo useradd -r -m -U -d /opt/tomcat -s /bin/false tomcat

# Download Tomcat 9
cd /tmp
wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.82/bin/apache-tomcat-9.0.82.tar.gz

# Extract and setup
sudo tar xf apache-tomcat-9.0.82.tar.gz -C /opt/tomcat
sudo ln -s /opt/tomcat/apache-tomcat-9.0.82 /opt/tomcat/latest
sudo chown -RH tomcat: /opt/tomcat/latest
sudo sh -c 'chmod +x /opt/tomcat/latest/bin/*.sh'

# Create systemd service
sudo tee /etc/systemd/system/tomcat.service > /dev/null <<EOF
[Unit]
Description=Tomcat 9 servlet container
After=network.target

[Service]
Type=forking
User=tomcat
Group=tomcat
Environment="JAVA_HOME=/usr/lib/jvm/java-11-amazon-corretto"
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

# Start and enable Tomcat
sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo systemctl enable tomcat

# Check status
sudo systemctl status tomcat
```

---

## ⚙️ Tomcat Configuration

### **Step 1: Configure Tomcat Port (Both Systems)**

#### **For Ubuntu (Tomcat 9 package):**
```bash
# Edit server configuration
sudo vim /var/lib/tomcat9/conf/server.xml

# Find and change port from 8080 to 8090:
# <Connector port="8090" protocol="HTTP/1.1"
#            address="0.0.0.0"
#            connectionTimeout="20000"
#            redirectPort="8443" />
```

#### **For Amazon Linux (Manual Tomcat):**
```bash
# Edit server configuration
sudo vim /opt/tomcat/latest/conf/server.xml

# Find and change port from 8080 to 8090:
# <Connector port="8090" protocol="HTTP/1.1"
#            address="0.0.0.0"
#            connectionTimeout="20000"
#            redirectPort="8443" />
```

### **Step 2: Configure Tomcat Users**

#### **For Ubuntu:**
```bash
# Edit tomcat users file
sudo vim /etc/tomcat9/tomcat-users.xml
```

#### **For Amazon Linux:**
```bash
# Edit tomcat users file
sudo vim /opt/tomcat/latest/conf/tomcat-users.xml
```

**Add these lines before `</tomcat-users>` (Both Systems):**
```xml
<role rolename="admin-gui,manager-gui,manager-script"/>
<user username="admin" password="admin" roles="manager-gui,admin-gui,manager-script"/>
```

### **Step 3: Restart Tomcat**

#### **For Ubuntu:**
```bash
sudo systemctl restart tomcat9
sudo systemctl status tomcat9
```

#### **For Amazon Linux:**
```bash
sudo systemctl restart tomcat
sudo systemctl status tomcat
```

### **Step 4: Test Tomcat**
```bash
# Test Tomcat is running
curl http://localhost:8090

# Access from browser
http://YOUR_SERVER_IP:8090
```

---

## 🔐 Configure Jenkins Credentials

### **Step 1: Access Jenkins**
```bash
# Open Jenkins in browser
http://YOUR_SERVER_IP:8080
```

### **Step 2: Add Tomcat Credentials**
1. **Go to:** `Manage Jenkins` → `Manage Credentials`
2. **Click:** `(global)` → `Add Credentials`
3. **Configure:**
   ```yaml
   Kind: Username with password
   Scope: Global
   Username: admin
   Password: admin
   ID: tomcat-9
   Description: Tomcat 9 Deployment Credentials
   ```
4. **Click:** `Create`

### **Step 3: Configure Maven Tool**
1. **Go to:** `Manage Jenkins` → `Global Tool Configuration`
2. **Find:** `Maven` section
3. **Click:** `Add Maven`
4. **Configure:**
   ```yaml
   Name: my_mvn
   Install automatically: ✅ (checked)
   Version: Latest available (e.g., 3.9.4)
   ```
5. **Click:** `Save`

### **Step 4: Install Required Plugins**
1. **Go to:** `Manage Jenkins` → `Manage Plugins`
2. **Available Tab:** Search and install:
   - `Pipeline`
   - `Maven Integration`
   - `Deploy to container`
   - `JUnit`
3. **Click:** `Install without restart`

---

## 📁 Project Structure

```
06_final_project/
├── README.md                    # This overview guide
├── 6.1_manual/                  # Manual deployment
│   ├── src/                     # Java source code
│   ├── pom.xml                  # Maven configuration
│   └── README.md                # Manual deployment steps
└── 6.2_pipeline/                # Pipeline automation
    ├── src/                     # Same source code
    ├── pom.xml                  # Same Maven configuration
    ├── Jenkinsfile              # Jenkins pipeline
    └── README.md                # Pipeline setup steps
```

---

## 🚀 Learning Path

### **Phase 1: Manual Deployment**
📂 **Go to:** [6.1_manual/](./6.1_manual/)
- Learn the deployment process step by step
- Understand Maven build lifecycle
- Deploy WAR file to Tomcat manually
- Test application functionality

### **Phase 2: Pipeline Automation**
📂 **Go to:** [6.2_pipeline/](./6.2_pipeline/)
- Create Jenkins pipeline job
- Automate the manual process
- Configure SCM integration
- Monitor automated deployment

---

## 🔍 Verification Steps

### **✅ Infrastructure Check**
```bash
# Check Java
java -version

# Check Maven
mvn -version

# Check Tomcat (Ubuntu)
sudo systemctl status tomcat9

# Check Tomcat (Amazon Linux)
sudo systemctl status tomcat

# Test Tomcat access
curl http://localhost:8090
```

### **✅ Jenkins Check**
```bash
# Access Jenkins
http://YOUR_SERVER_IP:8080

# Verify credentials: tomcat-9
# Verify Maven tool: my_mvn
# Verify plugins installed
```

---

## 🛠️ Troubleshooting

### **Common Issues**

| Issue | Solution |
|-------|----------|
| **Port 8090 not accessible** | Check firewall: `sudo ufw allow 8090` (Ubuntu) or Security Group (AWS) |
| **Tomcat not starting** | Check logs: `sudo journalctl -u tomcat9` (Ubuntu) or `sudo journalctl -u tomcat` (Amazon Linux) |
| **Java not found** | Set JAVA_HOME: `export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64` |
| **Maven not working** | Check PATH: `echo $PATH` and reinstall if needed |

---

## 🎯 Next Steps

1. **Complete Infrastructure Setup** ✅
2. **Go to 6.1_manual** → Learn manual deployment
3. **Go to 6.2_pipeline** → Automate with Jenkins
4. **Compare approaches** → Manual vs Automated

---

<div align="center">

**🚀 Ready to start? Go to [6.1_manual](./6.1_manual/) for manual deployment!**

[![GitHub](https://img.shields.io/badge/GitHub-manikcloud-black?style=for-the-badge&logo=github)](https://github.com/manikcloud)

</div>
