# 🐳 Docker Project - Address Book Application

<div align="center">

![Docker](https://img.shields.io/badge/Docker-Simple-blue?style=for-the-badge&logo=docker&logoColor=white)
![Tomcat](https://img.shields.io/badge/Tomcat-9.0-orange?style=for-the-badge&logo=apache&logoColor=white)
![Java](https://img.shields.io/badge/Java-17-red?style=for-the-badge&logo=java&logoColor=white)

**🎯 Simple Docker Setup | 🚀 Just Dockerfile | 📦 Easy to Understand**

</div>

---

## 🐳 Docker Containerization Workflow

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        🐳 DOCKER CONTAINERIZATION FLOW                     │
└─────────────────────────────────────────────────────────────────────────────┘

📁 Source Code        🔨 Maven Build        📦 Docker Build        🚀 Container Run
     │                      │                     │                      │
     │ Java Application     │                     │                      │
     │ pom.xml             │                     │                      │
     └────────────────────► │                     │                      │
                             │                     │                      │
                             │ mvn clean package   │                      │
                             │                     │                      │
                             │ ✅ addressbook.war   │                      │
                             └───────────────────► │                      │
                                                   │                      │
                                                   │ docker build         │
                                                   │ FROM tomcat:9.0      │
                                                   │ COPY *.war           │
                                                   │                      │
                                                   │ ✅ Docker Image      │
                                                   └────────────────────► │
                                                                          │
                                                                          │ docker run
                                                                          │ -p 9090:8080
                                                                          │
                                                                          │ ✅ Live App
                                                                          │ localhost:9090

┌─────────────────────────────────────────────────────────────────────────────┐
│  🎯 Result: Portable Container | 📦 Consistent Environment | 🚀 Easy Deploy │
└─────────────────────────────────────────────────────────────────────────────┘
```

*Simple Docker workflow: Source → Build → Containerize → Run*

---

## 🚀 Simple Steps

### **Quick Setup**
```bash
# 1. Clone repository
git clone https://github.com/manikcloud/cloud-devops-learning-path.git

# 2. Navigate to project
cd cloud-devops-learning-path/Section-2-DevOps/Session-5_Docker/5.2_docker_project

# 3. Build Java app
mvn clean package

# 4. Build Docker image
docker build -t addressbook-app .

# 5. Run container
docker run -d -p 9090:8080 --name addressbook addressbook-app

# 6. Access application
# Open: http://localhost:9090/addressbook/
```

### **Or Use Script**
```bash
# After cloning and navigating to project directory:
chmod +x simple-build.sh
./simple-build.sh
```

### **Stop/Start**
```bash
docker stop addressbook    # Stop
docker start addressbook   # Start
docker rm addressbook      # Remove
```

---

## 🐳 Simple Dockerfile

```dockerfile
# Use official Tomcat image as base
FROM tomcat:9.0-jdk17

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR file to Tomcat webapps directory
COPY target/addressbook.war /usr/local/tomcat/webapps/addressbook.war

# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
```

**That's it!** Simple and effective.

---

## 🛠️ Essential Commands

### **Build and Run**
```bash
mvn clean package
docker build -t addressbook-app .
docker run -d -p 9090:8080 --name addressbook addressbook-app
```

### **Check Status**
```bash
docker ps              # Running containers
docker logs addressbook # View logs
```

### **Development Cycle**
```bash
# Make changes, then:
mvn clean package
docker build -t addressbook-app .
docker stop addressbook && docker rm addressbook
docker run -d -p 9090:8080 --name addressbook addressbook-app
```

---

## 🔍 Troubleshooting

**Container won't start:**
```bash
docker logs addressbook
```

**Application not accessible:**
```bash
docker ps | grep addressbook
curl http://localhost:9090/addressbook/
```

**Build fails:**
```bash
mvn clean package
ls target/addressbook.war
```

---

## 📋 Quick Reference

### **Project Files**
```
5.2_docker_project/
├── src/                     # Java source code
├── pom.xml                  # Maven configuration
├── Dockerfile               # Container definition
├── simple-build.sh          # Automation script
└── README.md               # This guide
```

### **URLs**
- **Application:** http://localhost:9090/addressbook/
- **Repository:** https://github.com/manikcloud/cloud-devops-learning-path

---

*Simple, clean, and effective Docker containerization!* 🎉
