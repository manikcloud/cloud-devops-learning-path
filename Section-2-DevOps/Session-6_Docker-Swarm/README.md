# 🐝 Session-6: Docker Swarm

<div align="center">

![Docker Swarm](https://img.shields.io/badge/Docker-Swarm-blue?style=for-the-badge&logo=docker&logoColor=white)
![Orchestration](https://img.shields.io/badge/Container-Orchestration-green?style=for-the-badge&logo=docker&logoColor=white)

**🎯 Container Orchestration | 🚀 Multi-Node Deployment | 📦 Service Management**

</div>

---

## 📖 What is Docker Swarm?

Docker Swarm is Docker's built-in orchestration tool that manages multiple containers across multiple machines.

### **Why Use Docker Swarm?**
- **Scale applications** - Run multiple copies
- **High availability** - If one container fails, others continue
- **Load balancing** - Distribute traffic automatically
- **Easy management** - Simple commands to manage services

---

## 🐝 Docker Swarm Learning Journey

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        🐝 DOCKER SWARM MASTERY PATH                        │
└─────────────────────────────────────────────────────────────────────────────┘

📚 6.1 Swarm Basics              📦 6.2 Stack Project
     │                                │
     │ • Cluster Setup                │ • Multi-Service Stack
     │ • Manager & Worker Nodes       │ • Flask + Redis Demo
     │ • Service Creation             │ • Service Scaling
     │ • Load Balancing               │ • Network Management
     │ • Health Checks               │ • Production Deployment
     │                                │
     ▼                                ▼
┌─────────────────────────┐    ┌─────────────────────────┐
│    🏗️ INFRASTRUCTURE    │───►│   🚀 PRODUCTION STACK   │
│                         │    │                         │
│ • docker swarm init     │    │ • docker stack deploy   │
│ • docker node ls        │    │ • Multi-container apps   │
│ • docker service create │    │ • Service dependencies  │
│ • docker service scale  │    │ • Overlay networking    │
│ • Multi-node cluster    │    │ • Rolling updates       │
└─────────────────────────┘    └─────────────────────────┘

        ┌─────────────────────────────────────────┐
        │           🎯 SWARM ARCHITECTURE         │
        │                                         │
        │  Manager Node    ←→    Worker Node      │
        │      │                     │            │
        │   Services              Services        │
        │   Tasks                 Tasks           │
        │   Load Balancer         Containers      │
        └─────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│  🎯 Outcome: Orchestration Expert | 📦 Multi-Node Skills | 🚀 Production Ready │
└─────────────────────────────────────────────────────────────────────────────┘
```

*Master container orchestration from single-node to production multi-service stacks*

---

## 🔧 Prerequisites

### **Infrastructure Requirements**
- **2 EC2 Instances** - One manager, one worker node
- **Security Group Configuration** - Allow Swarm communication ports
- **Docker Installed** - On both EC2 instances

### **EC2 Setup**
```bash
# Instance 1: Manager Node
# Instance 2: Worker Node
# Both should have Docker installed
```

### **Security Group Rules**
Create one Security Group and add these rules:
```
# Inbound Rules:
Type: All Traffic, Protocol: All, Port: All, Source: Your IP Address
Type: All Traffic, Protocol: All, Port: All, Source: Security Group ID (self-reference)

# Outbound Rules:
Type: All Traffic, Protocol: All, Port: All, Destination: 0.0.0.0/0
```

**Simple Setup:**
- **Your IP Access** - Full access from your location
- **Inter-EC2 Communication** - All traffic between EC2 instances in same SG
- **Internet Access** - Outbound traffic allowed

### **Docker Installation (Both EC2s)**
```bash
# Amazon Linux 2
sudo yum update -y
sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
# Log out and log back in
```

---

## 📁 Module Structure

### **[6.1 Swarm Basics & Project](./6.1_swarm_basics/)**
- **[Commands & Web Project](./6.1_swarm_basics/README.md)** - Essential commands and color-changing web app

### **[6.2 Stack Project](./6.2_stack_project/)**
- **[Multi-Service Stack](./6.2_stack_project/README.md)** - Deploy web + database with docker-compose
- **[Docker Compose File](./6.2_stack_project/docker-compose.yml)** - Stack definition

---

## 🚀 Quick Start

### **Step 1: Initialize Swarm (Manager Node)**
```bash
# On EC2-1 (Manager)
docker swarm init

# Get join token
docker swarm join-token worker
```

### **Step 2: Join Worker Node**
```bash
# On EC2-2 (Worker) - use token from Step 1
docker swarm join --token SWMTKN-1-xxxxx <manager-private-ip>:2377

# Verify on manager
docker node ls
```

### **Step 3: Deploy Service**
```bash
# Deploy service across both nodes
docker service create --name web --publish 8080:80 --replicas 3 nginx

# Check service distribution
docker service ps web
```

---

## 🎯 Learning Path

### **Week 1: [Swarm Basics & Web Project](./6.1_swarm_basics/)**
- Initialize Docker Swarm
- Create interactive web service
- Scale and manage services

### **Week 2: [Stack Management](./6.2_stack_project/)**
- Deploy multi-service applications
- Use docker-compose.yml files
- Manage web + database stacks

---

*Master container orchestration with Docker Swarm!* 🚀
