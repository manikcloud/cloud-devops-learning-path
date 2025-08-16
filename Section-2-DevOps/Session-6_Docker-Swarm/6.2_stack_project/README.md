# 🐝 Docker Stack Project - Multi-Service App

## 📖 What is Docker Stack?

Docker Stack is a feature that allows you to deploy and manage multi-service applications in Docker Swarm mode using a single `docker-compose.yml` file.

### **Key Concepts:**

#### **🔄 Stack vs Service vs Container**
- **Container** - Single running instance of an image
- **Service** - One or more containers of the same image (replicas)
- **Stack** - Group of related services that work together

#### **🎯 Why Use Docker Stack?**
- **Multi-Service Apps** - Deploy web + database + cache together
- **Single Command** - Deploy entire application stack at once
- **Service Dependencies** - Services can communicate by name
- **Declarative** - Define desired state in YAML file
- **Version Control** - Track changes to your application architecture

#### **📋 Stack vs Docker Compose**
| Feature | Docker Compose | Docker Stack |
|---------|----------------|--------------|
| **Environment** | Single host | Swarm cluster |
| **Scaling** | Manual | Automatic |
| **Load Balancing** | External | Built-in |
| **High Availability** | No | Yes |
| **Production Ready** | Development | Production |

### **🌐 How Stack Works**
```
docker stack deploy -c docker-compose.yml mystack
                    ↓
            Creates Services
                    ↓
        Distributes Across Nodes
                    ↓
          Load Balances Traffic
```

---

## 🚀 Simple Stack with Web + Database

This project deploys a multi-service application using Docker Stack with docker-compose.yml.

---

## 🚀 Quick Steps

### **Step 1: Initialize Swarm**
```bash
# Initialize swarm (if not already done)
docker swarm init

# Verify swarm
docker node ls
```

### **Step 2: Deploy Stack**
```bash
# Deploy stack from compose file
docker stack deploy -c docker-compose.yml mystack

# Check stack
docker stack ls
```

### **Step 3: Check Services**
```bash
# List stack services
docker stack services mystack

# Check service details
docker service ps mystack_web
docker service ps mystack_db
```

### **Step 4: Test Application**
```bash
# Access web service
curl http://localhost:8080

# Or open in browser
# http://localhost:8080
```

---

## 🔧 Stack Management

### **View Stack Info**
```bash
# List all stacks
docker stack ls

# List services in stack
docker stack services mystack

# Check service logs
docker service logs mystack_web
```

### **Scale Services**
```bash
# Scale web service
docker service scale mystack_web=5

# Check scaling
docker service ps mystack_web
```

### **Remove Stack**
```bash
# Remove entire stack
docker stack rm mystack

# Verify removal
docker stack ls
```

---

## 📋 What's Included

### **Services:**
- **Web Service** - 3 nginx replicas on port 8080
- **Database Service** - 1 MySQL replica with password

### **Network:**
- **Overlay Network** - Services can communicate by name
- **webnet** - Custom network for the stack

### **Stack Benefits in This Project:**
- **Single Command Deployment** - `docker stack deploy -c docker-compose.yml mystack`
- **Service Discovery** - Web service can connect to database using hostname `db`
- **Load Balancing** - Traffic distributed across 3 web replicas
- **High Availability** - If one container fails, others continue
- **Scaling** - Easy to scale services up or down

---

## 📁 Project Files

```
6.2_stack_project/
├── docker-compose.yml     # Stack definition
└── README.md             # This guide
```

---

## 🎯 Real-World Stack Examples

### **E-commerce Application Stack:**
```yaml
services:
  frontend:    # React/Angular app
  backend:     # Node.js/Python API
  database:    # PostgreSQL/MySQL
  cache:       # Redis
  search:      # Elasticsearch
```

### **Monitoring Stack:**
```yaml
services:
  prometheus:  # Metrics collection
  grafana:     # Visualization
  alertmanager: # Alerting
  node-exporter: # System metrics
```

### **Our Simple Stack:**
```yaml
services:
  web:         # Nginx web server
  db:          # MySQL database
```

---

*Simple multi-service deployment with Docker Stack!* 🚀
