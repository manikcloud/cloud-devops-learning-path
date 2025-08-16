# 🐳 Final Docker Project - Address Book Application

<div align="center">

![Docker](https://img.shields.io/badge/Docker-Containerized-blue?style=for-the-badge&logo=docker&logoColor=white)
![Tomcat](https://img.shields.io/badge/Tomcat-9.0-orange?style=for-the-badge&logo=apache&logoColor=white)
![Java](https://img.shields.io/badge/Java-17-red?style=for-the-badge&logo=java&logoColor=white)

**🎯 Containerize Java Web App | 🚀 Docker + Tomcat | 📦 Production Ready**

</div>

---

## 📖 Project Overview

This is the **final Docker project** that demonstrates containerizing a real Java web application (Address Book) using Docker and Tomcat. We're using the same application from the Jenkins 6.2 pipeline project, but now running it in a Docker container.

### **🎯 What You'll Learn:**
- **Containerize Java applications** with Docker
- **Use Tomcat as application server** in containers
- **Build Docker images** from Dockerfiles
- **Deploy with Docker Compose** for easy management
- **Apply Docker best practices** for Java web apps

---

## 🏗️ Project Structure

```
final_docker_project/
├── src/                     # Java source code (from 6.2 project)
├── pom.xml                  # Maven configuration
├── Dockerfile               # Docker image definition
├── docker-compose.yml      # Multi-container orchestration
├── README.md               # This file
└── target/                 # Maven build output (after build)
    └── addressbook.war     # WAR file for deployment
```

---

## 🚀 Quick Start

### **Step 1: Build the Application**
```bash
# Navigate to project directory
cd final_docker_project

# Build with Maven (creates WAR file)
mvn clean package

# Verify WAR file is created
ls -la target/addressbook.war
```

### **Step 2: Build Docker Image**
```bash
# Build Docker image
docker build -t addressbook-app .

# Verify image is created
docker images | grep addressbook-app
```

### **Step 3: Run with Docker**
```bash
# Run container directly
docker run -d -p 8090:8080 --name addressbook addressbook-app

# Or use Docker Compose (recommended)
docker-compose up -d

# Check if running
docker ps
```

### **Step 4: Access Application**
```bash
# Open in browser
http://localhost:8090/addressbook/

# Or test with curl
curl http://localhost:8090/addressbook/
```

---

## 🐳 Docker Configuration

### **Dockerfile Explained**
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

**Key Points:**
- **Base Image:** `tomcat:9.0-jdk17` (includes Java 17 + Tomcat 9)
- **Clean Slate:** Removes default Tomcat webapps
- **App Deployment:** Copies our WAR file to webapps directory
- **Port Exposure:** Makes port 8080 available
- **Startup Command:** Runs Tomcat in foreground

### **Docker Compose Configuration**
```yaml
version: '3.8'

services:
  addressbook:
    build: .
    container_name: addressbook-app
    ports:
      - "8090:8080"
    environment:
      - JAVA_OPTS=-Xmx512m -Xms256m
    restart: unless-stopped
    networks:
      - app-network

networks:
  app-network:
    driver: bridge
```

**Benefits:**
- **Easy Management:** Single command to start/stop
- **Port Mapping:** Host port 8090 → Container port 8080
- **Resource Limits:** JVM memory configuration
- **Auto Restart:** Container restarts if it crashes
- **Custom Network:** Isolated network for the application

---

## 🛠️ Development Workflow

### **Build and Test Cycle**
```bash
# 1. Make code changes
# Edit files in src/ directory

# 2. Rebuild application
mvn clean package

# 3. Rebuild Docker image
docker build -t addressbook-app .

# 4. Restart container
docker-compose down
docker-compose up -d

# 5. Test changes
curl http://localhost:8090/addressbook/
```

### **Debugging Container**
```bash
# View container logs
docker logs addressbook-app
docker-compose logs -f

# Execute commands inside container
docker exec -it addressbook-app bash

# Check Tomcat logs inside container
docker exec addressbook-app tail -f /usr/local/tomcat/logs/catalina.out

# Check running processes
docker exec addressbook-app ps aux
```

---

## 🔧 Docker Commands Reference

### **Image Management**
```bash
# Build image
docker build -t addressbook-app .

# List images
docker images

# Remove image
docker rmi addressbook-app

# Tag image for registry
docker tag addressbook-app myregistry/addressbook-app:v1.0
```

### **Container Management**
```bash
# Run container
docker run -d -p 8090:8080 --name addressbook addressbook-app

# Stop container
docker stop addressbook

# Start container
docker start addressbook

# Remove container
docker rm addressbook

# View container details
docker inspect addressbook
```

### **Docker Compose Commands**
```bash
# Start services
docker-compose up -d

# Stop services
docker-compose down

# View logs
docker-compose logs -f

# Rebuild and restart
docker-compose up -d --build

# Scale services (if needed)
docker-compose up -d --scale addressbook=2
```

---

## 🎯 Testing the Application

### **Basic Functionality Test**
```bash
# Test home page
curl http://localhost:8090/addressbook/

# Test with browser
# Navigate to: http://localhost:8090/addressbook/
# Should see Address Book application interface
```

### **Container Health Check**
```bash
# Check if container is running
docker ps | grep addressbook

# Check container resource usage
docker stats addressbook-app

# Check container logs for errors
docker logs addressbook-app | grep -i error
```

---

## 🚀 Production Considerations

### **Image Optimization**
```dockerfile
# Multi-stage build for smaller images
FROM maven:3.8-openjdk-17 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package

FROM tomcat:9.0-jdk17
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=builder /app/target/addressbook.war /usr/local/tomcat/webapps/addressbook.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
```

### **Security Enhancements**
```dockerfile
# Run as non-root user
RUN groupadd -r tomcat && useradd -r -g tomcat tomcat
RUN chown -R tomcat:tomcat /usr/local/tomcat
USER tomcat
```

### **Health Checks**
```dockerfile
# Add health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8080/addressbook/ || exit 1
```

---

## 🔍 Troubleshooting

### **Common Issues**

**Issue:** Container won't start
```bash
# Check logs
docker logs addressbook-app

# Common causes:
# - WAR file not found (run mvn clean package first)
# - Port already in use (change port mapping)
# - Insufficient memory (adjust JAVA_OPTS)
```

**Issue:** Application not accessible
```bash
# Check port mapping
docker ps | grep addressbook

# Test container internally
docker exec addressbook-app curl http://localhost:8080/addressbook/

# Check firewall/network settings
```

**Issue:** Build fails
```bash
# Ensure Maven build succeeds first
mvn clean package

# Check Dockerfile syntax
docker build -t test .

# Verify base image availability
docker pull tomcat:9.0-jdk17
```

---

## 📋 Project Checklist

### **✅ Completion Criteria:**
- [ ] Maven build creates WAR file successfully
- [ ] Docker image builds without errors
- [ ] Container starts and runs properly
- [ ] Application accessible via browser
- [ ] Docker Compose works correctly
- [ ] Container logs show no errors
- [ ] Application functions as expected

### **🎯 Learning Objectives Met:**
- [ ] Understand Dockerfile structure and commands
- [ ] Successfully containerize Java web application
- [ ] Use Docker Compose for application management
- [ ] Apply Docker networking concepts
- [ ] Implement container debugging techniques
- [ ] Follow Docker best practices

---

## 🏆 Next Steps

### **Enhancements to Try:**
1. **Add Database:** Integrate MySQL container with Docker Compose
2. **Load Balancing:** Add nginx reverse proxy
3. **Monitoring:** Add Prometheus and Grafana containers
4. **CI/CD Integration:** Build images in Jenkins pipeline
5. **Registry Push:** Push images to Docker Hub or private registry

### **Advanced Topics:**
- Multi-stage builds for optimization
- Container security scanning
- Docker secrets management
- Container orchestration with Docker Swarm
- Kubernetes deployment

---

*Congratulations! You've successfully containerized a Java web application with Docker and Tomcat!* 🎉
