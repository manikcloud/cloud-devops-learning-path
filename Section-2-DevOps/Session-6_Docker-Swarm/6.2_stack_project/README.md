# 🐝 Docker Stack Project - Simple Demo

## 📖 What is Docker Stack?

Docker Stack deploys multiple services together using a single docker-compose.yml file.

**Stack = Multiple Services Working Together**

---

## 🚀 Simple Steps

### **Step 1: Clone Repository**
```bash
git clone https://github.com/manikcloud/cloud-devops-learning-path.git
cd cloud-devops-learning-path/Section-2-DevOps/Session-6_Docker-Swarm/6.2_stack_project
```

### **Step 2: Initialize Swarm**
```bash
docker swarm init
```

### **Step 3: Deploy Stack**
```bash
docker stack deploy -c docker-compose.yml mystack
```

### **Step 4: Check Stack**
```bash
# View stack
docker stack ls

# View services
docker stack services mystack

# View containers
docker service ps mystack_web
docker service ps mystack_db
```

### **Step 5: Test**
```bash
# Access web service
curl http://localhost:8080

# Or open browser: http://localhost:8080
```

---

## 🔧 Stack Management

```bash
# Scale web service
docker service scale mystack_web=5

# Remove stack
docker stack rm mystack
```

---

## 📋 What This Demo Shows

- **Multi-Service Deployment** - Web + Database together
- **Load Balancing** - 3 nginx replicas
- **Service Discovery** - Services can talk to each other
- **Single Command** - Deploy entire stack at once

---

*Simple Docker Stack demo!* 🚀
