# 🐝 Docker Swarm Basics

## 📋 Essential Commands

### **Initialize Swarm (Multi-Node)**
```bash
# On Manager Node (EC2-1)
docker swarm init

# Get worker join token
docker swarm join-token worker

# On Worker Node (EC2-2) - use token from above
docker swarm join --token <token> <manager-private-ip>:2377

# Verify nodes (on manager)
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

### **Example 1: Multi-Node Web Service**
```bash
# On manager node
docker swarm init
docker swarm join-token worker

# On worker node (use actual token and private IP)
docker swarm join --token SWMTKN-1-xxxxx 172.31.1.100:2377

# Deploy service across nodes
docker service create --name web --publish 8080:80 --replicas 4 nginx
docker service ps web
```

### **Example 2: Check Node Distribution**
```bash
# See which containers run on which nodes
docker service ps web

# Scale and watch distribution
docker service scale web=6
docker service ps web
```

---

## 🔍 Troubleshooting

### **Common Issues**
```bash
# If join fails:
# 1. Check network connectivity
ping <manager-private-ip>

# 2. Verify Docker is running
sudo systemctl status docker

# 3. Start Docker if stopped
sudo systemctl start docker

# 4. Check security group ports (2377, 7946, 4789)

# 5. Regenerate token if needed (on manager)
docker swarm join-token --rotate worker
```

---

*Simple Docker Swarm fundamentals!* 🚀
