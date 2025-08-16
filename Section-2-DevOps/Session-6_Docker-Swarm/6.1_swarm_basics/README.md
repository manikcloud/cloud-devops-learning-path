# 🐝 Docker Swarm Basics

## 📋 Essential Commands

### **Initialize Swarm**
```bash
# Initialize swarm mode
docker swarm init

# Join as worker (use token from init output)
docker swarm join --token <token> <manager-ip>:2377

# List nodes
docker node ls
```

### **Service Management**
```bash
# Create service
docker service create --name web --publish 8080:80 nginx

# List services
docker service ls

# Check service details
docker service ps web

# Scale service
docker service scale web=3

# Update service
docker service update --image nginx:alpine web

# Remove service
docker service rm web
```

### **Stack Management**
```bash
# Deploy stack from compose file
docker stack deploy -c docker-compose.yml mystack

# List stacks
docker stack ls

# List stack services
docker stack services mystack

# Remove stack
docker stack rm mystack
```

---

## 🌐 Swarm Networking

### **Network Types**
- **Ingress** - Load balancing for published ports
- **Overlay** - Multi-host networking
- **Bridge** - Single host networking

### **Network Commands**
```bash
# Create overlay network
docker network create --driver overlay mynetwork

# List networks
docker network ls

# Inspect network
docker network inspect mynetwork
```

---

## 🚀 Quick Examples

### **Example 1: Web Service**
```bash
docker swarm init
docker service create --name web --publish 8080:80 --replicas 3 nginx
curl http://localhost:8080
```

### **Example 2: Database Service**
```bash
docker service create --name db --replicas 1 mysql:8.0
docker service ps db
```

---

*Simple Docker Swarm fundamentals!* 🚀
