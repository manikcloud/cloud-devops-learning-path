# 🐳 Essential Docker Commands - Quick Reference

## 📋 Basic Docker Commands

### **Container Management**
```bash
# Run a container
docker run hello-world
docker run -it ubuntu bash
docker run -d nginx
docker run -d -p 8080:80 nginx

# List containers
docker ps                    # Running containers
docker ps -a                 # All containers

# Stop and start containers
docker stop <container-id>
docker start <container-id>
docker restart <container-id>

# Remove containers
docker rm <container-id>
docker rm -f <container-id>  # Force remove running container
```

### **Image Management**
```bash
# List images
docker images
docker image ls

# Pull images
docker pull ubuntu
docker pull nginx:latest
docker pull node:16-alpine

# Remove images
docker rmi <image-id>
docker rmi nginx:latest

# Build image from Dockerfile
docker build -t myapp .
docker build -t myapp:v1.0 .
```

### **Container Information**
```bash
# View container logs
docker logs <container-id>
docker logs -f <container-id>  # Follow logs

# Execute commands in running container
docker exec -it <container-id> bash
docker exec <container-id> ls -la

# Inspect container details
docker inspect <container-id>
docker stats <container-id>
```

---

## 🌐 Basic Docker Networking

### **Default Networks**
```bash
# List networks
docker network ls

# Default networks:
# - bridge (default for containers)
# - host (use host networking)
# - none (no networking)
```

### **Bridge Network (Default)**
```bash
# Containers can communicate with each other
# Each container gets its own IP address
# Port mapping required for external access

# Example: Run nginx with port mapping
docker run -d -p 8080:80 --name web nginx
# Access via: http://localhost:8080
```

### **Custom Networks**
```bash
# Create custom network
docker network create mynetwork

# Run containers on custom network
docker run -d --network mynetwork --name app1 nginx
docker run -d --network mynetwork --name app2 alpine

# Containers can communicate using container names
docker exec app2 ping app1
```

### **Host Network**
```bash
# Use host's network directly
docker run -d --network host nginx
# Access via: http://localhost:80 (no port mapping needed)
```

---

## 🔧 Practical Examples

### **Example 1: Simple Web Server**
```bash
# Run nginx web server
docker run -d -p 8080:80 --name webserver nginx

# Check if running
docker ps

# View logs
docker logs webserver

# Access: http://localhost:8080
```

### **Example 2: Interactive Container**
```bash
# Run Ubuntu container interactively
docker run -it --name myubuntu ubuntu bash

# Inside container:
apt update
apt install curl -y
curl google.com
exit

# Restart and reconnect
docker start myubuntu
docker exec -it myubuntu bash
```

### **Example 3: Container Communication**
```bash
# Create network
docker network create webapp-net

# Run database container
docker run -d --network webapp-net --name db mysql:8.0

# Run web application container
docker run -d --network webapp-net --name web -p 3000:3000 node:16-alpine

# Web container can connect to db using hostname 'db'
```

---

## 📦 Volume Management

### **Basic Volume Commands**
```bash
# Create volume
docker volume create mydata

# List volumes
docker volume ls

# Use volume in container
docker run -d -v mydata:/data nginx

# Mount host directory
docker run -d -v /host/path:/container/path nginx
```

---

## 🛠️ Docker Compose Basics

### **Simple docker-compose.yml**
```yaml
version: '3.8'
services:
  web:
    image: nginx
    ports:
      - "8080:80"
    networks:
      - webnet
  
  app:
    image: node:16-alpine
    networks:
      - webnet

networks:
  webnet:
```

### **Compose Commands**
```bash
# Start services
docker-compose up -d

# Stop services
docker-compose down

# View logs
docker-compose logs

# Scale services
docker-compose up -d --scale app=3
```

---

## 🔍 Troubleshooting Commands

```bash
# Check Docker system info
docker info
docker version

# Clean up unused resources
docker system prune

# View resource usage
docker stats

# Check container processes
docker top <container-id>

# Copy files to/from container
docker cp file.txt container:/path/
docker cp container:/path/file.txt ./
```

---

## 🚀 Quick Start Workflow

```bash
# 1. Pull an image
docker pull nginx

# 2. Run container with port mapping
docker run -d -p 8080:80 --name myweb nginx

# 3. Check if running
docker ps

# 4. View logs
docker logs myweb

# 5. Access application
curl http://localhost:8080

# 6. Stop and remove
docker stop myweb
docker rm myweb
```

---

*Master these commands and you'll be ready for any Docker task!* 🚀
