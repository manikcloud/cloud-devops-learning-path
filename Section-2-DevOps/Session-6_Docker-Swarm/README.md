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

## 📁 Module Structure

### **[6.1 Swarm Basics](./6.1_swarm_basics/)**
- **[Swarm Commands](./6.1_swarm_basics/swarm-commands.md)** - Essential Docker Swarm commands
- **[Networking Concepts](./6.1_swarm_basics/networking-concepts.md)** - Swarm networking basics

### **[6.2 Swarm Project](./6.2_swarm_project/)**
- **[Hello World Web App](./6.2_swarm_project/README.md)** - Simple web service with color changes
- **[HTML File](./6.2_swarm_project/index.html)** - Custom web page
- **[Dockerfile](./6.2_swarm_project/Dockerfile)** - Container definition

---

## 🚀 Quick Start

### **Initialize Swarm**
```bash
# Initialize Docker Swarm
docker swarm init

# Check swarm status
docker node ls
```

### **Deploy Service**
```bash
# Deploy simple web service
docker service create --name web --publish 8080:80 --replicas 3 nginx

# Check service
docker service ls
docker service ps web
```

### **Scale Service**
```bash
# Scale up
docker service scale web=5

# Scale down
docker service scale web=2
```

---

## 🎯 Learning Path

### **Week 1: [Swarm Basics](./6.1_swarm_basics/)**
- Initialize Docker Swarm
- Basic service management
- Scaling and updates

### **Week 2: [Web Project](./6.2_swarm_project/)**
- Create custom web service
- Deploy with multiple replicas
- Change background colors dynamically

---

*Master container orchestration with Docker Swarm!* 🚀
