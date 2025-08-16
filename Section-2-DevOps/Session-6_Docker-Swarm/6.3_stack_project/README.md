# 🐝 Docker Stack Project - Multi-Service App

## 📖 Simple Stack with Web + Database

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

---

## 📁 Project Files

```
6.3_stack_project/
├── docker-compose.yml     # Stack definition
└── README.md             # This guide
```

---

*Simple multi-service deployment with Docker Stack!* 🚀
