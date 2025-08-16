# 🐝 Docker Stack Project - Flask + Redis Demo

## 📖 What is Docker Stack?

Docker Stack deploys multiple services together using a single docker-compose.yml file.

**Stack = Multiple Services Working Together**

This demo shows a Flask web app that counts visits using Redis.

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

### **Step 3: Build Image**
```bash
docker build -t stackdemo .
```

### **Step 4: Deploy Stack**
```bash
docker stack deploy -c docker-compose.yml mystack
```

### **Step 5: Check Stack**
```bash
# View stack
docker stack ls

# View services
docker stack services mystack

# View containers
docker service ps mystack_web
docker service ps mystack_redis
```

### **Step 6: Test**
```bash
# Access web service (visit counter)
curl http://localhost:8000

# Refresh multiple times to see counter increase
curl http://localhost:8000
curl http://localhost:8000
```

---

## 🔧 Stack Management

```bash
# Scale web service
docker service scale mystack_web=5

# Check scaling
docker service ps mystack_web

# Remove stack
docker stack rm mystack
```

---

## 📋 What This Demo Shows

- **Multi-Service App** - Flask web app + Redis database
- **Service Communication** - Web app talks to Redis by hostname
- **Load Balancing** - 3 Flask replicas share traffic
- **Persistent Counter** - Redis stores visit count
- **Single Command Deploy** - Entire stack with one command

---

## 📁 Project Files

```
6.2_stack_project/
├── app.py                # Flask application
├── requirements.txt      # Python dependencies
├── Dockerfile           # Flask container
├── docker-compose.yml   # Stack definition
└── README.md           # This guide
```

---

*Simple Flask + Redis Stack demo!* 🚀
