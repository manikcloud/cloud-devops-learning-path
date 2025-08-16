# 🌐 Docker Swarm Networking - Simple Guide

## 📖 What is Swarm Networking?

Docker Swarm networking allows containers running across multiple machines to communicate with each other as if they were on the same machine. It's like creating a virtual network that spans multiple computers!

---

## 🏗️ Swarm Network Types

### **1. Overlay Networks**
```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   Node 1    │    │   Node 2    │    │   Node 3    │
│ ┌─────────┐ │    │ ┌─────────┐ │    │ ┌─────────┐ │
│ │Container│ │    │ │Container│ │    │ │Container│ │
│ │   Web   │ │    │ │   API   │ │    │ │   DB    │ │
│ └─────────┘ │    │ └─────────┘ │    │ └─────────┘ │
└─────────────┘    └─────────────┘    └─────────────┘
       │                   │                   │
       └───────────────────┼───────────────────┘
                           │
                  ┌─────────────┐
                  │   Overlay   │
                  │  Network    │
                  │ "mynetwork" │
                  └─────────────┘
```

**How it works:**
- Spans multiple Docker hosts
- Containers can communicate using service names
- Encrypted by default
- Automatic load balancing

**Example:**
```bash
# Create overlay network
docker network create --driver overlay myapp-net

# Deploy services on the network
docker service create --name web --network myapp-net --replicas 3 nginx
docker service create --name api --network myapp-net --replicas 2 node:16
docker service create --name db --network myapp-net --replicas 1 mysql:8.0

# Services can communicate using names: web, api, db
```

### **2. Ingress Network (Built-in)**
```
                    Internet
                       │
                ┌─────────────┐
                │   Port      │
                │   8080      │
                └─────────────┘
                       │
              ┌─────────────────┐
              │ Ingress Network │
              │ Load Balancer   │
              └─────────────────┘
                       │
        ┌──────────────┼──────────────┐
        │              │              │
   ┌─────────┐    ┌─────────┐    ┌─────────┐
   │ Node 1  │    │ Node 2  │    │ Node 3  │
   │ Web:80  │    │ Web:80  │    │ Web:80  │
   └─────────┘    └─────────┘    └─────────┘
```

**How it works:**
- Default network for published ports
- Automatic load balancing
- Routes traffic to healthy containers
- Works across all nodes

**Example:**
```bash
# Service with published port uses ingress automatically
docker service create --name web --replicas 3 -p 8080:80 nginx
# Traffic to any node:8080 gets load balanced to all replicas
```

---

## 🔧 Practical Networking Examples

### **Example 1: Simple Web Application**
```bash
# Create custom overlay network
docker network create --driver overlay webapp-net

# Database service (internal only)
docker service create \
  --name database \
  --network webapp-net \
  --env MYSQL_ROOT_PASSWORD=secret \
  mysql:8.0

# Web service (exposed to internet)
docker service create \
  --name web \
  --network webapp-net \
  --replicas 3 \
  -p 8080:80 \
  nginx

# Web containers can connect to database using hostname 'database'
```

### **Example 2: Microservices Architecture**
```bash
# Create network for microservices
docker network create --driver overlay microservices-net

# User service (internal)
docker service create \
  --name user-service \
  --network microservices-net \
  --replicas 2 \
  user-app:latest

# Order service (internal)
docker service create \
  --name order-service \
  --network microservices-net \
  --replicas 2 \
  order-app:latest

# API Gateway (public facing)
docker service create \
  --name api-gateway \
  --network microservices-net \
  --replicas 2 \
  -p 80:80 \
  gateway:latest

# Services communicate using names:
# user-service, order-service, api-gateway
```

### **Example 3: Multi-Network Setup**
```bash
# Frontend network (public)
docker network create --driver overlay frontend-net

# Backend network (private)
docker network create --driver overlay backend-net

# Database (backend only)
docker service create \
  --name database \
  --network backend-net \
  mysql:8.0

# API (both networks)
docker service create \
  --name api \
  --network frontend-net \
  --network backend-net \
  --replicas 3 \
  api-app:latest

# Web frontend (frontend only)
docker service create \
  --name web \
  --network frontend-net \
  --replicas 2 \
  -p 8080:80 \
  web-app:latest
```

---

## 🔍 Service Discovery

### **How Services Find Each Other**
```bash
# Services can communicate using service names
docker service create --name web --network mynet nginx
docker service create --name api --network mynet node:16
docker service create --name db --network mynet mysql:8.0

# Inside any container:
# curl http://web/        # Connects to web service
# curl http://api:3000/   # Connects to api service  
# mysql -h db -u root     # Connects to database service
```

### **DNS Resolution Example**
```bash
# Create test network and services
docker network create --driver overlay test-net
docker service create --name web --network test-net --replicas 3 nginx
docker service create --name test --network test-net alpine sleep 3600

# Test DNS resolution
docker exec $(docker ps -q -f name=test) nslookup web
# Returns IP addresses of all web service replicas
```

---

## ⚖️ Load Balancing

### **Ingress Load Balancing**
```bash
# Create service with published port
docker service create --name web --replicas 5 -p 8080:80 nginx

# Traffic distribution:
# Request to Node1:8080 → Any of 5 web containers
# Request to Node2:8080 → Any of 5 web containers  
# Request to Node3:8080 → Any of 5 web containers
```

### **Internal Load Balancing**
```bash
# Services on same network get automatic load balancing
docker network create --driver overlay app-net
docker service create --name web --network app-net --replicas 3 nginx
docker service create --name client --network app-net alpine sleep 3600

# From client container:
# curl http://web/  # Automatically load balanced across 3 web replicas
```

---

## 🛠️ Network Commands

### **Network Management**
```bash
# List networks
docker network ls

# Create overlay network
docker network create --driver overlay mynetwork

# Create encrypted overlay network
docker network create --driver overlay --opt encrypted secure-net

# Inspect network
docker network inspect mynetwork

# Remove network
docker network rm mynetwork
```

### **Service Network Operations**
```bash
# Create service on specific network
docker service create --name web --network mynet nginx

# Add service to additional network
docker service update --network-add newnet web

# Remove service from network
docker service update --network-rm oldnet web

# Update service network
docker service update --network-rm oldnet --network-add newnet web
```

---

## 🔒 Network Security

### **Network Isolation**
```bash
# Services on different networks cannot communicate
docker network create --driver overlay frontend-net
docker network create --driver overlay backend-net

# Frontend services
docker service create --name web --network frontend-net nginx
docker service create --name lb --network frontend-net haproxy

# Backend services  
docker service create --name api --network backend-net node:16
docker service create --name db --network backend-net mysql:8.0

# web cannot directly access db (different networks)
```

### **Encrypted Networks**
```bash
# Create encrypted overlay network
docker network create \
  --driver overlay \
  --opt encrypted \
  secure-network

# All traffic on this network is encrypted
docker service create --name secure-app --network secure-network myapp:latest
```

---

## 🎯 Real-World Scenarios

### **Scenario 1: E-commerce Application**
```bash
# Create networks
docker network create --driver overlay public-net
docker network create --driver overlay private-net

# Public services
docker service create \
  --name web-frontend \
  --network public-net \
  --replicas 3 \
  -p 80:80 \
  ecommerce-web:latest

docker service create \
  --name api-gateway \
  --network public-net \
  --network private-net \
  --replicas 2 \
  -p 8080:8080 \
  api-gateway:latest

# Private services
docker service create \
  --name user-service \
  --network private-net \
  --replicas 2 \
  user-service:latest

docker service create \
  --name order-service \
  --network private-net \
  --replicas 2 \
  order-service:latest

docker service create \
  --name database \
  --network private-net \
  --replicas 1 \
  postgres:13
```

### **Scenario 2: Monitoring Stack**
```bash
# Create monitoring network
docker network create --driver overlay monitoring-net

# Prometheus (collects metrics)
docker service create \
  --name prometheus \
  --network monitoring-net \
  -p 9090:9090 \
  prometheus:latest

# Grafana (visualizes metrics)
docker service create \
  --name grafana \
  --network monitoring-net \
  -p 3000:3000 \
  grafana/grafana:latest

# Node exporters (global service - one per node)
docker service create \
  --name node-exporter \
  --mode global \
  --network monitoring-net \
  --mount type=bind,source=/proc,target=/host/proc,readonly \
  --mount type=bind,source=/sys,target=/host/sys,readonly \
  prom/node-exporter
```

---

## 🔍 Troubleshooting Network Issues

### **Common Problems & Solutions**

**Problem:** Service can't connect to another service
```bash
# Check if services are on same network
docker service inspect web | grep -A 10 Networks
docker service inspect api | grep -A 10 Networks

# Solution: Add services to same network
docker service update --network-add shared-net web
docker service update --network-add shared-net api
```

**Problem:** External traffic can't reach service
```bash
# Check if port is published
docker service ls

# Solution: Publish port
docker service update --publish-add 8080:80 web
```

**Problem:** Load balancing not working
```bash
# Check service replicas
docker service ps web

# Check ingress network
docker network inspect ingress

# Test from multiple nodes
curl node1:8080
curl node2:8080
curl node3:8080
```

---

## 📋 Quick Reference

### **Network Types Summary**
| Network Type | Scope | Use Case | Communication |
|--------------|-------|----------|---------------|
| **Overlay** | Multi-host | Service-to-service | Service names |
| **Ingress** | Multi-host | External access | Load balanced |
| **Bridge** | Single host | Local containers | Container names |

### **Essential Commands**
```bash
# Create overlay network
docker network create --driver overlay mynet

# Deploy service on network
docker service create --name web --network mynet --replicas 3 nginx

# Test connectivity
docker exec <container> ping <service-name>

# Check network details
docker network inspect mynet
```

---

*Master Swarm networking to build scalable, communicating applications across multiple hosts!* 🚀
