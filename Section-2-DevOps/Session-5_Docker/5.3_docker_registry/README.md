# 🏪 Docker Registry - Push to Docker Hub

<div align="center">

![Docker Hub](https://img.shields.io/badge/Docker-Hub-blue?style=for-the-badge&logo=docker&logoColor=white)
![Registry](https://img.shields.io/badge/Registry-Push%2FPull-green?style=for-the-badge&logo=docker&logoColor=white)

**🎯 Share Your Images | 🚀 Docker Hub Integration | 📦 Image Distribution**

</div>

---

## 📖 What is Docker Registry?

Docker Registry is a service that stores and distributes Docker images. **Docker Hub** is the default public registry where you can:
- **Store your images** - Share with the world
- **Pull public images** - Use community images
- **Collaborate** - Team access to private repositories

---

## 🚀 Quick Steps to Push to Docker Hub

### **Step 1: Create Docker Hub Account**
1. Go to [hub.docker.com](https://hub.docker.com)
2. Click "Sign Up" 
3. Create your account (remember your username!)

### **Step 2: Login from Command Line**
```bash
# Login to Docker Hub
docker login

# Enter your Docker Hub username and password
# Username: your-dockerhub-username
# Password: your-dockerhub-password
```

### **Step 3: Build and Tag Your Image**
```bash
# Navigate to your project (use the Address Book from 5.2)
cd ../5.2_docker_project

# Build the application
mvn clean package

# Build image with your Docker Hub username
docker build -t your-username/addressbook-app .

# Example: docker build -t johnsmith/addressbook-app .
```

### **Step 4: Push to Docker Hub**
```bash
# Push your image to Docker Hub
docker push your-username/addressbook-app

# Example: docker push johnsmith/addressbook-app
```

### **Step 5: Verify on Docker Hub**
1. Go to [hub.docker.com](https://hub.docker.com)
2. Login to your account
3. Check your repositories
4. You should see your `addressbook-app` image!

---

## 🔧 Complete Example

### **Using Address Book Project**
```bash
# 1. Login to Docker Hub
docker login

# 2. Navigate to project
cd ../5.2_docker_project

# 3. Build Java application
mvn clean package

# 4. Build and tag image (replace 'yourusername' with your Docker Hub username)
docker build -t yourusername/addressbook-app:latest .

# 5. Push to Docker Hub
docker push yourusername/addressbook-app:latest

# 6. Test pulling your image
docker pull yourusername/addressbook-app:latest

# 7. Run from Docker Hub
docker run -d -p 9090:8080 --name my-app yourusername/addressbook-app:latest
```

---

## 🏷️ Image Tagging

### **Tag Versions**
```bash
# Tag with version
docker build -t yourusername/addressbook-app:v1.0 .
docker build -t yourusername/addressbook-app:latest .

# Push specific version
docker push yourusername/addressbook-app:v1.0
docker push yourusername/addressbook-app:latest
```

### **Tag Existing Image**
```bash
# Tag existing image
docker tag addressbook-app yourusername/addressbook-app:v1.0
docker tag addressbook-app yourusername/addressbook-app:latest

# Push tagged images
docker push yourusername/addressbook-app:v1.0
docker push yourusername/addressbook-app:latest
```

---

## 📥 Pull and Use Images

### **Pull Your Image**
```bash
# Pull your image from Docker Hub
docker pull yourusername/addressbook-app

# Run your image
docker run -d -p 9090:8080 --name addressbook yourusername/addressbook-app

# Access application
# http://localhost:9090/addressbook/
```

### **Pull Public Images**
```bash
# Pull popular images
docker pull nginx
docker pull mysql:8.0
docker pull node:16-alpine
docker pull ubuntu:20.04
```

---

## 🔍 Registry Commands

### **Login/Logout**
```bash
# Login to Docker Hub
docker login

# Login to specific registry
docker login registry.example.com

# Logout
docker logout
```

### **Search Images**
```bash
# Search Docker Hub
docker search nginx
docker search mysql
docker search node
```

### **Image Information**
```bash
# List local images
docker images

# Remove local image
docker rmi yourusername/addressbook-app

# Pull specific tag
docker pull yourusername/addressbook-app:v1.0
```

---

## 🔒 Private Repositories

### **Create Private Repository**
1. Go to Docker Hub
2. Click "Create Repository"
3. Choose "Private"
4. Name your repository

### **Push to Private Repository**
```bash
# Same commands work for private repos
docker build -t yourusername/private-app .
docker push yourusername/private-app
```

### **Access Private Repository**
```bash
# Must be logged in to pull private images
docker login
docker pull yourusername/private-app
```

---

## 🚀 Automation Script

### **push-to-hub.sh**
```bash
#!/bin/bash

# Simple script to build and push to Docker Hub

echo "Building and pushing to Docker Hub..."

# Get Docker Hub username
read -p "Enter your Docker Hub username: " USERNAME

# Build application
echo "Building Java application..."
mvn clean package

# Build Docker image
echo "Building Docker image..."
docker build -t $USERNAME/addressbook-app:latest .

# Push to Docker Hub
echo "Pushing to Docker Hub..."
docker push $USERNAME/addressbook-app:latest

echo "Done! Check your Docker Hub account."
echo "Run with: docker run -d -p 9090:8080 $USERNAME/addressbook-app"
```

### **Make Script Executable**
```bash
chmod +x push-to-hub.sh
./push-to-hub.sh
```

---

## 📋 Quick Reference

### **Essential Commands**
```bash
# Login and push workflow
docker login
docker build -t username/image-name .
docker push username/image-name

# Pull and run
docker pull username/image-name
docker run -d -p 9090:8080 username/image-name
```

### **Image Naming Convention**
```
username/repository:tag
├── username: Your Docker Hub username
├── repository: Image name
└── tag: Version (latest, v1.0, etc.)
```

### **Common Tags**
- `latest` - Most recent version
- `v1.0`, `v2.0` - Version numbers
- `stable` - Stable release
- `dev` - Development version

---

## 🎯 Success Checklist

- [ ] Created Docker Hub account
- [ ] Successfully logged in with `docker login`
- [ ] Built image with proper naming: `username/image-name`
- [ ] Pushed image to Docker Hub
- [ ] Verified image appears in Docker Hub web interface
- [ ] Successfully pulled and ran image from Docker Hub
- [ ] Tested application works: http://localhost:9090/addressbook/

---

*Share your containerized applications with the world using Docker Hub!* 🚀
