# 🐝 Docker Swarm Commands - Quick Reference

## 🏗️ Cluster Management

### **Initialize Swarm**
```bash
# Initialize swarm on manager node
docker swarm init

# Initialize with specific IP (if multiple interfaces)
docker swarm init --advertise-addr 192.168.1.100

# Get join tokens
docker swarm join-token worker    # For worker nodes
docker swarm join-token manager   # For manager nodes
```

### **Join Nodes to Swarm**
```bash
# Join as worker node (run on worker machine)
docker swarm join --token SWMTKN-1-xxx... 192.168.1.100:2377

# Join as manager node (run on manager machine)
docker swarm join --token SWMTKN-1-xxx... 192.168.1.100:2377

# Leave swarm
docker swarm leave
docker swarm leave --force  # For manager nodes
```

### **Node Management**
```bash
# List all nodes
docker node ls

# Inspect node details
docker node inspect <node-id>
docker node inspect self

# Promote worker to manager
docker node promote <node-id>

# Demote manager to worker
docker node demote <node-id>

# Remove node from swarm
docker node rm <node-id>

# Update node availability
docker node update --availability drain <node-id>    # Stop scheduling
docker node update --availability active <node-id>   # Resume scheduling
docker node update --availability pause <node-id>    # Pause scheduling
```

---

## 🔄 Service Management

### **Create Services**
```bash
# Create simple service
docker service create --name web nginx

# Create service with replicas
docker service create --name web --replicas 3 nginx

# Create service with port mapping
docker service create --name web --replicas 3 -p 8080:80 nginx

# Create global service (one per node)
docker service create --name monitoring --mode global alpine:latest

# Create service with resource limits
docker service create \
  --name web \
  --replicas 3 \
  --limit-cpu 0.5 \
  --limit-memory 512M \
  nginx
```

### **Service Operations**
```bash
# List services
docker service ls

# Inspect service
docker service inspect web
docker service inspect --pretty web

# View service logs
docker service logs web
docker service logs -f web  # Follow logs

# Scale service
docker service scale web=5
docker service scale web=1

# Update service
docker service update --image nginx:alpine web
docker service update --replicas 5 web

# Remove service
docker service rm web
```

### **Service Tasks**
```bash
# List tasks for a service
docker service ps web

# List all tasks
docker service ps $(docker service ls -q)

# View task details
docker inspect <task-id>
```

---

## 🌐 Network Management

### **Overlay Networks**
```bash
# Create overlay network
docker network create --driver overlay mynetwork

# Create encrypted overlay network
docker network create --driver overlay --opt encrypted mynetwork

# List networks
docker network ls

# Inspect network
docker network inspect mynetwork

# Remove network
docker network rm mynetwork
```

### **Service with Custom Network**
```bash
# Create network
docker network create --driver overlay webapp-net

# Create services on custom network
docker service create \
  --name web \
  --network webapp-net \
  --replicas 3 \
  -p 8080:80 \
  nginx

docker service create \
  --name db \
  --network webapp-net \
  mysql:8.0
```

---

## 📊 Service Types Examples

### **Replicated Services**
```bash
# Web application with 3 replicas
docker service create \
  --name webapp \
  --replicas 3 \
  -p 8080:80 \
  --update-delay 10s \
  --update-parallelism 1 \
  nginx

# Database with 1 replica (stateful)
docker service create \
  --name database \
  --replicas 1 \
  --mount type=volume,source=db-data,target=/var/lib/mysql \
  mysql:8.0

# API service with load balancing
docker service create \
  --name api \
  --replicas 5 \
  -p 3000:3000 \
  node:16-alpine
```

### **Global Services**
```bash
# Monitoring agent on every node
docker service create \
  --name node-exporter \
  --mode global \
  --mount type=bind,source=/proc,target=/host/proc,readonly \
  --mount type=bind,source=/sys,target=/host/sys,readonly \
  prom/node-exporter

# Log collector on every node
docker service create \
  --name log-collector \
  --mode global \
  --mount type=bind,source=/var/log,target=/var/log,readonly \
  fluentd:latest

# Security scanner on every node
docker service create \
  --name security-agent \
  --mode global \
  security-scanner:latest
```

---

## 🔄 Rolling Updates

### **Update Strategies**
```bash
# Update service image
docker service update --image nginx:alpine webapp

# Rolling update with custom settings
docker service update \
  --image nginx:alpine \
  --update-delay 30s \
  --update-parallelism 2 \
  --update-failure-action rollback \
  webapp

# Rollback to previous version
docker service rollback webapp

# Update with zero downtime
docker service update \
  --image myapp:v2 \
  --update-delay 10s \
  --update-parallelism 1 \
  --update-order start-first \
  webapp
```

---

## 🎯 Practical Examples

### **Example 1: Simple Web Application**
```bash
# Initialize swarm
docker swarm init

# Create overlay network
docker network create --driver overlay webapp-net

# Deploy web service
docker service create \
  --name web \
  --network webapp-net \
  --replicas 3 \
  -p 8080:80 \
  nginx

# Check deployment
docker service ls
docker service ps web
```

### **Example 2: Multi-Tier Application**
```bash
# Create network
docker network create --driver overlay app-net

# Database service (1 replica for consistency)
docker service create \
  --name database \
  --network app-net \
  --replicas 1 \
  --env MYSQL_ROOT_PASSWORD=secret \
  --env MYSQL_DATABASE=myapp \
  mysql:8.0

# Backend API service
docker service create \
  --name api \
  --network app-net \
  --replicas 3 \
  -p 3000:3000 \
  myapi:latest

# Frontend web service
docker service create \
  --name frontend \
  --network app-net \
  --replicas 2 \
  -p 80:80 \
  myfrontend:latest

# Monitoring (global service)
docker service create \
  --name monitoring \
  --mode global \
  --network app-net \
  -p 9090:9090 \
  prometheus:latest
```

### **Example 3: Load Balanced Web Farm**
```bash
# Create web service with 5 replicas
docker service create \
  --name webfarm \
  --replicas 5 \
  -p 8080:80 \
  --update-delay 10s \
  --update-parallelism 2 \
  nginx

# Scale up during high traffic
docker service scale webfarm=10

# Update to new version with rolling update
docker service update --image nginx:alpine webfarm

# Scale down after traffic reduces
docker service scale webfarm=3
```

---

## 🔍 Monitoring and Troubleshooting

### **Service Health**
```bash
# Check service status
docker service ls
docker service ps <service-name>

# View service logs
docker service logs <service-name>
docker service logs -f --tail 100 <service-name>

# Inspect service configuration
docker service inspect <service-name>
docker service inspect --pretty <service-name>
```

### **Node Health**
```bash
# Check node status
docker node ls

# View node details
docker node inspect <node-id>

# Check node resource usage
docker system df
docker system events
```

### **Network Troubleshooting**
```bash
# List networks
docker network ls

# Inspect overlay network
docker network inspect <network-name>

# Test connectivity between services
docker exec <container-id> ping <service-name>
```

---

## 🛠️ Stack Deployment (Docker Compose)

### **docker-compose.yml for Swarm**
```yaml
version: '3.8'
services:
  web:
    image: nginx
    ports:
      - "8080:80"
    deploy:
      replicas: 3
      update_config:
        parallelism: 1
        delay: 10s
      restart_policy:
        condition: on-failure
    networks:
      - webnet

  api:
    image: myapi:latest
    deploy:
      replicas: 2
    networks:
      - webnet

  monitoring:
    image: prometheus:latest
    deploy:
      mode: global
    networks:
      - webnet

networks:
  webnet:
    driver: overlay
```

### **Stack Commands**
```bash
# Deploy stack
docker stack deploy -c docker-compose.yml myapp

# List stacks
docker stack ls

# List stack services
docker stack services myapp

# View stack tasks
docker stack ps myapp

# Remove stack
docker stack rm myapp
```

---

## 📋 Quick Reference

### **Essential Commands**
```bash
# Cluster setup
docker swarm init
docker swarm join-token worker

# Service management
docker service create --name web --replicas 3 -p 8080:80 nginx
docker service ls
docker service scale web=5
docker service update --image nginx:alpine web

# Monitoring
docker node ls
docker service ps web
docker service logs web
```

### **Service Types Quick Guide**
```bash
# Replicated service (default)
docker service create --name web --replicas 3 nginx

# Global service (one per node)
docker service create --name monitoring --mode global alpine
```

---

*Master these commands to orchestrate containers at scale with Docker Swarm!* 🚀
