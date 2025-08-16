# 🐳 Docker Project - Address Book Application

<div align="center">

![Docker](https://img.shields.io/badge/Docker-Simple-blue?style=for-the-badge&logo=docker&logoColor=white)
![Tomcat](https://img.shields.io/badge/Tomcat-9.0-orange?style=for-the-badge&logo=apache&logoColor=white)
![Java](https://img.shields.io/badge/Java-17-red?style=for-the-badge&logo=java&logoColor=white)

**🎯 Simple Docker Setup | 🚀 Just Dockerfile | 📦 Easy to Understand**

</div>

---

## 📖 Project Overview

This project demonstrates **containerizing a Java web application** using Docker with a simple Dockerfile approach. We're using the Address Book application from Jenkins project and running it in a Tomcat container.

### **🎯 Why Simple Dockerfile?**
- **Easy to understand** - No complex orchestration
- **Learning focused** - Understand Docker basics first
- **Single container** - Perfect for simple applications
- **Direct approach** - Build, run, done!

---

## 🏗️ Project Structure

```
7.2_docker_project/
├── src/                     # Java source code
├── pom.xml                  # Maven configuration
├── Dockerfile               # Simple Docker image definition
└── README.md               # This guide
```

**Clean and Simple!** No unnecessary files or complex configurations.

---

## 🚀 Complete Step-by-Step Guide

### **Prerequisites**
Before starting, ensure you have:
- **Git** installed
- **Docker** installed and running
- **Maven** installed (for building Java application)
- **Java 17** or higher

### **Step 1: Clone the Repository**
```bash
# Clone the complete learning path repository
git clone https://github.com/manikcloud/cloud-devops-learning-path.git

# Navigate to the Docker project directory
cd cloud-devops-learning-path/Section-2-DevOps/Session-5_Docker/5.2_docker_project

# Verify you're in the right directory
ls -la
# You should see: Dockerfile, pom.xml, src/, README.md, simple-build.sh
```

### **Step 2: Verify Prerequisites**
```bash
# Check Docker is running
docker --version
docker info

# Check Maven is installed
mvn --version

# Check Java version
java -version
```

### **Step 3: Build the Java Application**
```bash
# Clean and build the application with Maven
mvn clean package

# This will:
# - Download dependencies
# - Compile Java source code
# - Run tests
# - Create WAR file in target/ directory

# Verify WAR file is created
ls -la target/addressbook.war
# Should show: addressbook.war file
```

### **Step 4: Build Docker Image**
```bash
# Build Docker image using the Dockerfile
docker build -t addressbook-app .

# This will:
# - Use tomcat:9.0-jdk17 as base image
# - Copy WAR file to Tomcat webapps directory
# - Configure container to run Tomcat

# Verify image is created
docker images | grep addressbook-app
# Should show: addressbook-app image
```

### **Step 5: Run Docker Container**
```bash
# Run container with port mapping
docker run -d -p 8090:8080 --name addressbook addressbook-app

# Explanation:
# -d: Run in detached mode (background)
# -p 8090:8080: Map host port 8090 to container port 8080
# --name addressbook: Give container a friendly name
# addressbook-app: Use our built image

# Check if container is running
docker ps
# Should show: addressbook container running
```

### **Step 6: Verify Application is Running**
```bash
# Check container logs
docker logs addressbook

# Wait for Tomcat to fully start (look for "Server startup" message)
# Then test the application

# Test with curl
curl http://localhost:8090/addressbook/

# Or open in browser
# Navigate to: http://localhost:8090/addressbook/
```

### **Step 7: Alternative - Use Automation Script**
```bash
# For convenience, use the provided script that does everything
chmod +x simple-build.sh
./simple-build.sh

# This script will:
# 1. Build the Java application
# 2. Build the Docker image
# 3. Stop any existing container
# 4. Start new container
# 5. Test the application
```
```

### **Step 8: Explore the Application**
```bash
# Once the application is running, you can:

# 1. Access the main page
curl http://localhost:8090/addressbook/

# 2. Open in browser and explore features
# Navigate to: http://localhost:8090/addressbook/
# - Add new contacts
# - Search contacts
# - Edit existing contacts
# - Test the registration form (background color change)

# 3. Check application logs
docker logs -f addressbook
# Press Ctrl+C to stop following logs
```

### **Step 9: Container Management**
```bash
# View running containers
docker ps

# Stop the container
docker stop addressbook

# Start the container again
docker start addressbook

# Restart the container
docker restart addressbook

# View container details
docker inspect addressbook

# Check resource usage
docker stats addressbook
```

### **Step 10: Development Workflow**
```bash
# When you make code changes:

# 1. Stop and remove existing container
docker stop addressbook
docker rm addressbook

# 2. Rebuild the application
mvn clean package

# 3. Rebuild Docker image
docker build -t addressbook-app .

# 4. Run new container
docker run -d -p 8090:8080 --name addressbook addressbook-app

# 5. Test your changes
curl http://localhost:8090/addressbook/
```

### **Step 11: Cleanup (When Done)**
```bash
# Stop and remove container
docker stop addressbook
docker rm addressbook

# Remove Docker image
docker rmi addressbook-app

# Clean up Maven build files
mvn clean

# Verify cleanup
docker ps -a
docker images
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

### **Why This Approach?**
- ✅ **Easy to understand** - Clear, simple steps
- ✅ **No complexity** - Just Docker basics
- ✅ **Perfect for learning** - Focus on core concepts
- ✅ **Production ready** - Works in real environments
- ✅ **Maintainable** - Easy to modify and update

---

## 🛠️ Essential Commands

### **Build and Run Workflow**
```bash
# 1. Build Java application
mvn clean package

# 2. Build Docker image
docker build -t addressbook-app .

# 3. Run container
docker run -d -p 8090:8080 --name addressbook addressbook-app

# 4. Check status
docker ps

# 5. View logs
docker logs addressbook

# 6. Stop container
docker stop addressbook

# 7. Remove container
docker rm addressbook
```

### **Development Cycle**
```bash
# Make code changes, then:
mvn clean package
docker build -t addressbook-app .
docker stop addressbook
docker rm addressbook
docker run -d -p 8090:8080 --name addressbook addressbook-app
```

---

## 🔧 Container Management

### **Basic Operations**
```bash
# Start stopped container
docker start addressbook

# Stop running container
docker stop addressbook

# Restart container
docker restart addressbook

# View container logs
docker logs addressbook
docker logs -f addressbook  # Follow logs

# Execute commands inside container
docker exec -it addressbook bash

# Check container details
docker inspect addressbook
```

### **Debugging**
```bash
# Check if container is running
docker ps

# View container logs for errors
docker logs addressbook | grep -i error

# Check Tomcat logs inside container
docker exec addressbook tail -f /usr/local/tomcat/logs/catalina.out

# Test application inside container
docker exec addressbook curl http://localhost:8080/addressbook/
```

---

## 🎯 Testing the Application

### **Verify Everything Works**
```bash
# 1. Check container is running
docker ps | grep addressbook

# 2. Test application response
curl -I http://localhost:8090/addressbook/

# 3. Check logs for any errors
docker logs addressbook

# 4. Access via browser
# Navigate to: http://localhost:8090/addressbook/
```

---

## 🔍 Troubleshooting

### **Common Issues and Solutions**

#### **Issue 1: Repository Clone Problems**
```bash
# Problem: Git clone fails
# Solution: Check internet connection and Git installation
git --version
ping github.com

# Alternative: Download ZIP file
# Go to: https://github.com/manikcloud/cloud-devops-learning-path
# Click "Code" → "Download ZIP"
```

#### **Issue 2: Maven Build Fails**
```bash
# Problem: mvn command not found
# Solution: Install Maven
# Ubuntu/Debian:
sudo apt update && sudo apt install maven -y

# CentOS/RHEL:
sudo yum install maven -y

# Verify installation
mvn --version
```

#### **Issue 3: Docker Build Fails**
```bash
# Problem: Docker daemon not running
# Solution: Start Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Problem: Permission denied
# Solution: Add user to docker group
sudo usermod -aG docker $USER
# Log out and log back in

# Verify Docker is working
docker run hello-world
```

#### **Issue 4: Container Won't Start**
```bash
# Check container logs for errors
docker logs addressbook

# Common solutions:
# - Ensure WAR file exists: ls target/addressbook.war
# - Check port availability: netstat -tulpn | grep 8090
# - Rebuild image: docker build -t addressbook-app .
```

#### **Issue 5: Application Not Accessible**
```bash
# Check if container is running
docker ps | grep addressbook

# Check port mapping
docker port addressbook

# Test internally
docker exec addressbook curl http://localhost:8080/addressbook/

# Check firewall settings
sudo ufw status
```

#### **Issue 6: Java Version Issues**
```bash
# Check Java version
java -version

# Install Java 17 if needed
# Ubuntu/Debian:
sudo apt install openjdk-17-jdk -y

# CentOS/RHEL:
sudo yum install java-17-openjdk-devel -y

# Set JAVA_HOME if needed
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
```

---

## 📋 Quick Reference

### **Essential Commands Summary**
```bash
# Complete workflow in one go
git clone https://github.com/manikcloud/cloud-devops-learning-path.git
cd cloud-devops-learning-path/Section-2-DevOps/Session-5_Docker/5.2_docker_project
mvn clean package
docker build -t addressbook-app .
docker run -d -p 8090:8080 --name addressbook addressbook-app
curl http://localhost:8090/addressbook/

# Or use the automation script
./simple-build.sh
```

### **Useful Docker Commands**
```bash
# Container lifecycle
docker ps                           # List running containers
docker ps -a                        # List all containers
docker logs addressbook             # View container logs
docker exec -it addressbook bash    # Access container shell
docker stop addressbook             # Stop container
docker start addressbook            # Start container
docker restart addressbook          # Restart container
docker rm addressbook               # Remove container

# Image management
docker images                       # List images
docker build -t addressbook-app .   # Build image
docker rmi addressbook-app          # Remove image
docker system prune                 # Clean up unused resources
```

### **Application URLs**
- **Main Application:** http://localhost:8090/addressbook/
- **Registration Form:** http://localhost:8090/addressbook/ (click Registration)
- **GitHub Repository:** https://github.com/manikcloud/cloud-devops-learning-path

### **Project Structure**
```
5.2_docker_project/
├── src/                     # Java source code
│   ├── main/java/          # Application code
│   └── test/java/          # Test code
├── pom.xml                 # Maven configuration
├── Dockerfile              # Container definition
├── simple-build.sh         # Automation script
└── README.md              # This guide
```

---

## 🚀 Next Steps

### **After Mastering This:**
1. **Try different base images** - Alpine, Ubuntu, etc.
2. **Add environment variables** - Configure application
3. **Mount volumes** - Persist data
4. **Multi-stage builds** - Optimize image size
5. **Health checks** - Monitor container health
6. **Docker networks** - Connect multiple containers

### **Advanced Topics:**
- Docker Compose (for multi-container apps)
- Docker Swarm (for orchestration)
- Kubernetes deployment
- CI/CD integration with Docker

---

## 🏆 Success Criteria

**You've mastered Docker basics when:**
- ✅ You can build the image without errors
- ✅ Container starts and runs properly
- ✅ Application is accessible via browser
- ✅ You can debug container issues
- ✅ You understand each Dockerfile instruction
- ✅ You can modify and rebuild easily

---

*Simple, clean, and effective Docker containerization!* 🎉
