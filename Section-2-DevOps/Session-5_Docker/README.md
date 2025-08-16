# 🐳 Module 5: Docker and Containerization

<div align="center">

![Docker](https://img.shields.io/badge/Docker-Containerization-blue?style=for-the-badge&logo=docker&logoColor=white)
![Learning](https://img.shields.io/badge/Level-Beginner-green?style=for-the-badge&logo=graduation-cap&logoColor=white)
![Hands-On](https://img.shields.io/badge/Type-Hands--On-orange?style=for-the-badge&logo=tools&logoColor=white)

**🎯 Master Container Fundamentals | 🚀 Cloud Native Development | 📦 Containerization Journey**

</div>

---

## 📖 Module Overview

This module will help you **master the core fundamentals of continuous deployment using Docker**. We will simplify and accelerate cloud native application development and start your containerization journey.

### **🎯 What You'll Learn:**
- **Container Fundamentals** - Understanding containerization concepts
- **Docker Basics** - Installation, configuration, and core commands
- **Container Management** - Creating, running, and managing containers
- **Image Creation** - Building custom Docker images
- **Networking** - Container networking and communication
- **Docker Compose** - Multi-container applications

---

## 🔧 Docker Installation

### **Amazon Linux 2/2023**
```bash
# Update system
sudo yum update -y

# Install Docker
sudo yum install docker -y

# Start Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Add user to docker group (avoid sudo)
sudo usermod -aG docker $USER

# Verify installation
docker --version
docker run hello-world

# Note: Log out and log back in for group changes to take effect
```

### **Ubuntu/Debian**
```bash
# Update system
sudo apt update

# Install prerequisites
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y

# Add Docker GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package index
sudo apt update

# Install Docker
sudo apt install docker-ce docker-ce-cli containerd.io -y

# Start Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Add user to docker group
sudo usermod -aG docker $USER

# Verify installation
docker --version
docker run hello-world

# Note: Log out and log back in for group changes to take effect
```

### **Quick Installation (Alternative)**
```bash
# Universal installer script (works on most Linux distributions)
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Add user to docker group
sudo usermod -aG docker $USER

# Start Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Verify installation
docker --version
docker run hello-world
```

---

## 📚 Learning Topics

### **🔧 Installation and Configuration**
- Docker installation on different platforms
- Docker daemon configuration
- Basic Docker commands and CLI usage
- Docker system management

### **📦 Managing Containers**
- Container lifecycle management
- Running and stopping containers
- Container logs and monitoring
- Resource management and limits

### **🌐 Node Networking**
- Docker networking concepts
- Bridge, host, and overlay networks
- Container-to-container communication
- Port mapping and exposure

### **🏗️ Build Process in Docker**
- Understanding Docker build context
- Layer caching and optimization
- Multi-stage builds
- Build arguments and environment variables

### **📝 Writing Dockerfiles and Docker Compose**
- Dockerfile syntax and best practices
- Creating efficient Docker images
- Docker Compose file structure
- Multi-container application orchestration

### **🖼️ Managing Local Images and Customization**
- Image management commands
- Tagging and versioning images
- Image cleanup and optimization
- Custom image creation

### **🏪 Docker Registry and Private Registry**
- Understanding Docker Hub
- Pushing and pulling images
- Setting up private registries
- Image security and scanning

---

## 🚀 Hands-On Projects

### **Project 1: First Container**
- Install Docker
- Run your first container
- Basic container operations

### **Project 2: Custom Application**
- Create a simple web application
- Write a Dockerfile
- Build and run custom image

### **Project 3: Multi-Container App**
- Design multi-service application
- Create Docker Compose file
- Deploy and manage services

### **Project 4: Registry Operations**
- Push images to Docker Hub
- Set up local registry
- Manage image versions

---

## 🎯 Learning Outcomes

By the end of this module, you will:

- ✅ **Understand containerization** concepts and benefits
- ✅ **Install and configure** Docker on your system
- ✅ **Create and manage** Docker containers effectively
- ✅ **Build custom images** using Dockerfiles
- ✅ **Deploy multi-container** applications with Docker Compose
- ✅ **Work with registries** for image distribution
- ✅ **Apply best practices** for container security and optimization

---

## 📋 Prerequisites

### **System Requirements:**
- Linux, macOS, or Windows with WSL2
- Minimum 4GB RAM (8GB recommended)
- 20GB free disk space
- Internet connection for downloading images

### **Knowledge Prerequisites:**
- Basic Linux command line skills
- Understanding of web applications
- Familiarity with text editors
- Basic networking concepts

---

## 🛠️ Tools and Technologies

### **Core Tools:**
- **Docker Engine** - Container runtime
- **Docker CLI** - Command line interface
- **Docker Compose** - Multi-container orchestration
- **Docker Hub** - Public registry

### **Development Tools:**
- **VS Code** - Code editor with Docker extension
- **Git** - Version control
- **Text Editor** - For Dockerfile creation

---

## 📖 Study Path

### **Week 1: Docker Fundamentals**
- Container concepts and benefits
- Docker installation and setup
- Basic container operations
- Image management

### **Week 2: Building Images**
- Dockerfile creation
- Build process optimization
- Custom image development
- Best practices

### **Week 3: Multi-Container Applications**
- Docker Compose introduction
- Service orchestration
- Networking and volumes
- Environment management

### **Week 4: Registry and Deployment**
- Docker Hub operations
- Private registry setup
- Image distribution
- Production considerations

---

## 🎉 Getting Started

### **Quick Start Commands:**
```bash
# Install Docker (Ubuntu/Debian)
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Verify installation
docker --version
docker run hello-world

# Basic container operations
docker ps
docker images
docker pull nginx
docker run -d -p 8080:80 nginx
```

### **First Dockerfile:**
```dockerfile
FROM node:16-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
```

---

## 🏆 Success Metrics

### **Module Completion Indicators:**
- ✅ Docker installed and running
- ✅ Successfully run multiple containers
- ✅ Built custom Docker images
- ✅ Created Docker Compose applications
- ✅ Pushed images to registry
- ✅ Demonstrated container networking

### **Practical Skills Gained:**
- Container lifecycle management
- Image creation and optimization
- Multi-container orchestration
- Registry operations
- Troubleshooting containers

---

*Start your containerization journey and master the technology that powers modern cloud applications!* 🚀
