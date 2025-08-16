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

## 🚀 Quick Start

### **Step 1: Build the Application**
```bash
# Navigate to project directory
cd 7.2_docker_project

# Build with Maven
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

### **Step 3: Run Container**
```bash
# Run container
docker run -d -p 8090:8080 --name addressbook addressbook-app

# Check if running
docker ps
```

### **Step 4: Access Application**
```bash
# Open in browser: http://localhost:8090/addressbook/

# Or test with curl
curl http://localhost:8090/addressbook/
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

### **Common Issues**

**Problem:** Container won't start
```bash
# Check logs
docker logs addressbook

# Common solutions:
# - Ensure WAR file exists: ls target/addressbook.war
# - Check port availability: netstat -tulpn | grep 8090
# - Rebuild image: docker build -t addressbook-app .
```

**Problem:** Application not accessible
```bash
# Check port mapping
docker ps | grep addressbook

# Should show: 0.0.0.0:8090->8080/tcp

# Test internally
docker exec addressbook curl http://localhost:8080/addressbook/
```

**Problem:** Build fails
```bash
# Ensure Maven build works first
mvn clean package

# Check if WAR file exists
ls -la target/addressbook.war

# Rebuild Docker image
docker build -t addressbook-app .
```

---

## 📋 Learning Checklist

### **✅ Skills Learned:**
- [ ] Build Java application with Maven
- [ ] Create simple Dockerfile
- [ ] Build Docker image
- [ ] Run Docker container
- [ ] Map ports for external access
- [ ] View container logs
- [ ] Debug container issues
- [ ] Stop and start containers

### **🎯 Key Concepts:**
- [ ] **Base Images** - Using pre-built images (tomcat:9.0-jdk17)
- [ ] **COPY instruction** - Adding files to image
- [ ] **EXPOSE instruction** - Documenting ports
- [ ] **CMD instruction** - Default container command
- [ ] **Port mapping** - Host port to container port
- [ ] **Container lifecycle** - Start, stop, remove

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
