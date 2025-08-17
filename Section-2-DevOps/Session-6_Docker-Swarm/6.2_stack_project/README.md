# 🐝 Docker Stack Project - Flask + Redis Demo

## 📖 What is Docker Stack?

Docker Stack deploys multiple services together using a single docker-compose.yml file in Docker Swarm mode.

**Stack = Multiple Services Working Together**

This demo shows a Flask web app that counts visits using Redis database.

---

## 🏗️ Stack Architecture Overview

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        🐝 DOCKER STACK ARCHITECTURE                        │
└─────────────────────────────────────────────────────────────────────────────┘

                            🌐 External Traffic
                                    │
                                    │ Port 8000
                                    ▼
                        ┌─────────────────────────┐
                        │    🔄 LOAD BALANCER     │
                        │   (Built-in Swarm)     │
                        └─────────────────────────┘
                                    │
                    ┌───────────────┼───────────────┐
                    │               │               │
                    ▼               ▼               ▼
            ┌─────────────┐ ┌─────────────┐ ┌─────────────┐
            │ 🐍 Flask-1  │ │ 🐍 Flask-2  │ │ 🐍 Flask-3  │
            │   Web App   │ │   Web App   │ │   Web App   │
            │ Port: 8000  │ │ Port: 8000  │ │ Port: 8000  │
            └─────────────┘ └─────────────┘ └─────────────┘
                    │               │               │
                    └───────────────┼───────────────┘
                                    │
                            📡 Overlay Network
                            (webnet - encrypted)
                                    │
                                    ▼
                        ┌─────────────────────────┐
                        │    🗄️ REDIS DATABASE    │
                        │     (Single Instance)   │
                        │   • Visit Counter       │
                        │   • In-Memory Storage   │
                        │   • Persistent Data     │
                        └─────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                            📋 SERVICE DETAILS                              │
├─────────────────────────────────────────────────────────────────────────────┤
│  🐍 Web Service (mystack_web):                                             │
│     • Image: stackdemo (custom Flask app)                                  │
│     • Replicas: 3 (High Availability)                                      │
│     • Port: 8000:8000 (External access)                                    │
│     • Network: webnet (Overlay)                                            │
│     • Dependencies: redis                                                   │
│                                                                             │
│  🗄️ Redis Service (mystack_redis):                                         │
│     • Image: redis:alpine (Official Redis)                                 │
│     • Replicas: 1 (Single instance)                                        │
│     • Network: webnet (Overlay)                                            │
│     • Storage: In-memory + persistence                                     │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│  🎯 Benefits: Load Balancing | 🔄 Auto-Scaling | 🛡️ High Availability      │
└─────────────────────────────────────────────────────────────────────────────┘
```

*Complete Docker Stack showing Flask web application with Redis backend and built-in load balancing*

---

## 🚀 Step-by-Step Guide

### **Step 1: Prerequisites**
```bash
# Ensure Docker is installed and running
docker --version

# Initialize Docker Swarm (if not already done)
docker swarm init

# Verify swarm mode
docker node ls
```

### **Step 2: Clone Repository**
```bash
# Clone the repository
git clone https://github.com/manikcloud/cloud-devops-learning-path.git

# Navigate to project directory
cd cloud-devops-learning-path/Section-2-DevOps/Session-6_Docker-Swarm/6.2_stack_project

# List project files
ls -la
```

### **Step 3: Build Flask Application Image**
```bash
# Build the Flask app image
docker build -t stackdemo .

# Verify image is created
docker images | grep stackdemo
```

### **Step 4: Deploy the Stack**
```bash
# Deploy the complete stack (Flask + Redis)
docker stack deploy -c docker-compose.yml mystack

# Wait for deployment (30-60 seconds)
sleep 30
```

### **Step 5: Verify Deployment**
```bash
# Check stack status
docker stack ls

# Check services in the stack
docker stack services mystack

# Check individual service containers
docker service ps mystack_web
docker service ps mystack_redis
```

### **Step 6: Test the Application**
```bash
# Test the visit counter (should show: Hello World! I have been seen 1 times.)
curl http://localhost:8000

# Test again (counter should increment)
curl http://localhost:8000

# Test multiple times to see counter increase
for i in {1..5}; do curl http://localhost:8000; done
```

---

## 🎯 Expected Application Outcomes

### **✅ Successful Deployment Indicators:**

#### **1. Stack Status:**
```bash
$ docker stack ls
NAME      SERVICES   ORCHESTRATOR
mystack   2          Swarm
```

#### **2. Service Status:**
```bash
$ docker stack services mystack
ID             NAME           MODE         REPLICAS   IMAGE           PORTS
abc123def456   mystack_redis  replicated   1/1        redis:alpine    
xyz789uvw012   mystack_web    replicated   3/3        stackdemo       *:8000->8000/tcp
```

#### **3. Application Response:**
```bash
$ curl http://localhost:8000
Hello World! I have been seen 1 times.

$ curl http://localhost:8000
Hello World! I have been seen 2 times.

$ curl http://localhost:8000
Hello World! I have been seen 3 times.
```

### **🔍 What Each Test Demonstrates:**

#### **Service Communication:**
- Flask app successfully connects to Redis using hostname `redis`
- Data persists across requests (counter increments)

#### **Load Balancing:**
- 3 Flask replicas handle requests
- Traffic distributed across containers
- All replicas share same Redis data

#### **High Availability:**
- If one Flask container fails, others continue serving
- Redis maintains state across Flask container restarts

---

## 🔧 Stack Management Commands

### **Scaling Services:**
```bash
# Scale web service to 5 replicas
docker service scale mystack_web=5

# Verify scaling
docker service ps mystack_web

# Test load balancing with more replicas
for i in {1..10}; do curl http://localhost:8000; done
```

### **Monitoring:**
```bash
# View service logs
docker service logs mystack_web
docker service logs mystack_redis

# Monitor real-time logs
docker service logs -f mystack_web
```

### **Cleanup:**
```bash
# Remove the entire stack
docker stack rm mystack

# Verify removal
docker stack ls

# Remove the custom image (optional)
docker rmi stackdemo
```

---

## 📋 Troubleshooting

### **Common Issues & Solutions:**

#### **Services not starting (0/1 or 0/3 replicas):**
```bash
# Check service logs for errors
docker service logs mystack_web
docker service logs mystack_redis

# Check node resources
docker node ls
free -h
```

#### **Application not accessible:**
```bash
# Verify services are running
docker stack services mystack

# Check if ports are bound
netstat -tlnp | grep 8000

# Test from inside swarm network
docker exec -it $(docker ps -q -f name=mystack_web) curl http://redis:6379
```

#### **Counter not incrementing:**
```bash
# Check Redis connectivity
docker service logs mystack_redis

# Verify network connectivity
docker network ls | grep mystack
```

---

## 📁 Project Structure

```
6.2_stack_project/
├── app.py                # Flask application with Redis counter
├── requirements.txt      # Python dependencies (flask, redis)
├── Dockerfile           # Flask container definition
├── docker-compose.yml   # Stack definition (Flask + Redis)
└── README.md           # This comprehensive guide
```

---

## 🎓 Learning Outcomes

After completing this demo, you will understand:

- **Docker Stack Deployment** - How to deploy multi-service applications
- **Service Discovery** - How containers communicate by service name
- **Load Balancing** - How traffic distributes across replicas
- **Data Persistence** - How services share data through databases
- **Container Orchestration** - Managing multiple containers as a unit

---

*Complete Flask + Redis Docker Stack demonstration!* 🚀
