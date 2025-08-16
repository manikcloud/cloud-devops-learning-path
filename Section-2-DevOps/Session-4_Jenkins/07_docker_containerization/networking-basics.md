# 🌐 Docker Networking Basics - Simple Guide

## 📖 What is Docker Networking?

Docker networking allows containers to communicate with each other and the outside world. Think of it like connecting computers in an office - they need a network to talk to each other!

---

## 🏗️ Network Types

### **1. Bridge Network (Default)**
```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│ Container A │    │ Container B │    │ Container C │
│   App1      │    │   App2      │    │   Database  │
└─────────────┘    └─────────────┘    └─────────────┘
       │                   │                   │
       └───────────────────┼───────────────────┘
                           │
                    ┌─────────────┐
                    │   Bridge    │
                    │  Network    │
                    └─────────────┘
                           │
                    ┌─────────────┐
                    │    Host     │
                    │  Machine    │
                    └─────────────┘
```

**How it works:**
- Default network for containers
- Containers get their own IP addresses
- Need port mapping to access from outside
- Containers can talk to each other

**Example:**
```bash
# Run two containers on default bridge
docker run -d --name web nginx
docker run -d --name db mysql:8.0

# They can communicate using IP addresses
docker exec web ping db  # This works!
```

### **2. Host Network**
```
┌─────────────┐
│ Container   │
│   App       │ ← Uses host's network directly
└─────────────┘
       │
┌─────────────┐
│    Host     │
│  Network    │
└─────────────┘
```

**How it works:**
- Container uses host's network directly
- No isolation between container and host
- No port mapping needed
- Faster performance

**Example:**
```bash
# Run nginx using host network
docker run -d --network host nginx
# Access directly via: http://localhost:80
```

### **3. Custom Networks**
```
┌─────────────┐    ┌─────────────┐
│ Container A │    │ Container B │
│   Web App   │    │  Database   │
└─────────────┘    └─────────────┘
       │                   │
       └───────────────────┘
                │
        ┌─────────────┐
        │   Custom    │
        │  Network    │
        │ "mynetwork" │
        └─────────────┘
```

**How it works:**
- You create your own network
- Better isolation and control
- Containers can use names to communicate
- Recommended for multi-container apps

**Example:**
```bash
# Create custom network
docker network create myapp-network

# Run containers on custom network
docker run -d --network myapp-network --name web nginx
docker run -d --network myapp-network --name db mysql:8.0

# Now they can talk using names!
docker exec web ping db  # Works using container name!
```

---

## 🔧 Practical Examples

### **Example 1: Simple Web Application**
```bash
# Create a network for our app
docker network create webapp-net

# Run database
docker run -d \
  --network webapp-net \
  --name database \
  -e MYSQL_ROOT_PASSWORD=secret \
  mysql:8.0

# Run web application
docker run -d \
  --network webapp-net \
  --name webapp \
  -p 3000:3000 \
  node:16-alpine

# Web app can connect to database using hostname 'database'
```

### **Example 2: Load Balancer Setup**
```bash
# Create network
docker network create lb-net

# Run multiple web servers
docker run -d --network lb-net --name web1 nginx
docker run -d --network lb-net --name web2 nginx
docker run -d --network lb-net --name web3 nginx

# Run load balancer (nginx proxy)
docker run -d \
  --network lb-net \
  --name loadbalancer \
  -p 80:80 \
  nginx
```

---

## 📊 Port Mapping Explained

### **Without Port Mapping:**
```
Host Machine (your computer)
├── Port 80: Not accessible
├── Port 8080: Not accessible
└── Docker Container
    └── Port 80: nginx running (only inside container)
```

### **With Port Mapping:**
```bash
docker run -d -p 8080:80 nginx
```
```
Host Machine (your computer)
├── Port 8080 ──────┐
└── Docker Container │
    └── Port 80 ←────┘ nginx running (accessible from outside)
```

**Access via:** `http://localhost:8080`

---

## 🛠️ Common Networking Commands

### **Network Management**
```bash
# List all networks
docker network ls

# Create custom network
docker network create mynetwork

# Inspect network details
docker network inspect mynetwork

# Remove network
docker network rm mynetwork

# Connect running container to network
docker network connect mynetwork container-name

# Disconnect container from network
docker network disconnect mynetwork container-name
```

### **Container Communication Testing**
```bash
# Test connectivity between containers
docker exec container1 ping container2

# Check container's IP address
docker inspect container-name | grep IPAddress

# Test port connectivity
docker exec container1 telnet container2 80
```

---

## 🎯 Real-World Scenarios

### **Scenario 1: WordPress with Database**
```bash
# Create network
docker network create wordpress-net

# Run MySQL database
docker run -d \
  --network wordpress-net \
  --name wp-database \
  -e MYSQL_ROOT_PASSWORD=rootpass \
  -e MYSQL_DATABASE=wordpress \
  -e MYSQL_USER=wpuser \
  -e MYSQL_PASSWORD=wppass \
  mysql:8.0

# Run WordPress
docker run -d \
  --network wordpress-net \
  --name wp-site \
  -p 8080:80 \
  -e WORDPRESS_DB_HOST=wp-database \
  -e WORDPRESS_DB_USER=wpuser \
  -e WORDPRESS_DB_PASSWORD=wppass \
  -e WORDPRESS_DB_NAME=wordpress \
  wordpress

# Access: http://localhost:8080
```

### **Scenario 2: Microservices Architecture**
```bash
# Create network for microservices
docker network create microservices-net

# User service
docker run -d --network microservices-net --name user-service user-app:latest

# Order service  
docker run -d --network microservices-net --name order-service order-app:latest

# API Gateway (exposed to outside)
docker run -d \
  --network microservices-net \
  --name api-gateway \
  -p 80:80 \
  gateway-app:latest

# Services communicate using container names:
# user-service, order-service, etc.
```

---

## 🔍 Troubleshooting Network Issues

### **Common Problems & Solutions**

**Problem:** Container can't connect to another container
```bash
# Check if containers are on same network
docker inspect container1 | grep NetworkMode
docker inspect container2 | grep NetworkMode

# Solution: Put them on same custom network
docker network create shared-net
docker network connect shared-net container1
docker network connect shared-net container2
```

**Problem:** Can't access container from host
```bash
# Check port mapping
docker ps

# Solution: Add port mapping
docker run -d -p 8080:80 nginx
```

**Problem:** DNS resolution not working
```bash
# Test DNS resolution
docker exec container1 nslookup container2

# Solution: Use custom network (bridge doesn't have DNS)
docker network create --driver bridge mynet
```

---

## 📋 Quick Reference

### **Network Types Summary**
| Network Type | Use Case | Container Communication | External Access |
|--------------|----------|------------------------|-----------------|
| **Bridge** | Default, simple apps | IP addresses | Port mapping required |
| **Host** | High performance | Host network | Direct access |
| **Custom** | Multi-container apps | Container names | Port mapping required |
| **None** | Isolated containers | No networking | No access |

### **Essential Commands**
```bash
# Quick network setup
docker network create mynet
docker run -d --network mynet --name app1 nginx
docker run -d --network mynet --name app2 alpine
docker exec app2 ping app1

# Quick cleanup
docker network rm mynet
```

---

*Understanding Docker networking is key to building scalable, communicating applications!* 🚀
