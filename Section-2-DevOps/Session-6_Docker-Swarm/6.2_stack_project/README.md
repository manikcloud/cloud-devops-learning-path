# 🐝 6.2 Docker Stack Project - Flask + Redis Demo

<div align="center">

![Docker Stack](https://img.shields.io/badge/Docker-Stack-blue?style=for-the-badge&logo=docker&logoColor=white)
![Flask](https://img.shields.io/badge/Flask-Web_App-green?style=for-the-badge&logo=flask&logoColor=white)
![Redis](https://img.shields.io/badge/Redis-Database-red?style=for-the-badge&logo=redis&logoColor=white)

**🎯 Multi-Service Stack | 🚀 Flask + Redis | 📊 Production Deployment**

</div>

---

## 📋 **What You'll Build**

A production-ready multi-service application featuring:
- ✅ **Flask web application** with visit counter
- ✅ **Redis database** for data persistence
- ✅ **Load balancing** across multiple Flask replicas
- ✅ **Service discovery** and inter-service communication
- ✅ **Overlay networking** for secure communication

---

## 🏗️ **Stack Architecture**

### **Complete Application Flow:**

```mermaid
graph TB
    subgraph "🌐 External Access"
        U[User Browser<br/>Port 8000]
    end
    
    subgraph "🐝 Docker Swarm Cluster"
        subgraph "Load Balancer"
            LB[Swarm Load Balancer<br/>Port 8000]
        end
        
        subgraph "Flask Web Service (3 replicas)"
            F1[Flask App 1<br/>Container]
            F2[Flask App 2<br/>Container]
            F3[Flask App 3<br/>Container]
        end
        
        subgraph "Redis Database Service"
            R1[Redis Database<br/>Single Instance]
        end
        
        subgraph "Overlay Network (webnet)"
            N1[Encrypted Communication]
        end
    end
    
    U --> LB
    LB --> F1
    LB --> F2
    LB --> F3
    
    F1 -.->|redis:6379| R1
    F2 -.->|redis:6379| R1
    F3 -.->|redis:6379| R1
    
    F1 --- N1
    F2 --- N1
    F3 --- N1
    R1 --- N1
```

### **Service Communication Flow:**

```mermaid
sequenceDiagram
    participant User
    participant LoadBalancer
    participant Flask1
    participant Flask2
    participant Flask3
    participant Redis
    
    User->>LoadBalancer: GET /
    LoadBalancer->>Flask1: Route request
    Flask1->>Redis: GET visit_count
    Redis-->>Flask1: Return count: 5
    Flask1->>Redis: INCR visit_count
    Redis-->>Flask1: New count: 6
    Flask1-->>LoadBalancer: "Hello World! I have been seen 6 times."
    LoadBalancer-->>User: Response
    
    Note over Flask1,Flask3: All Flask replicas share same Redis data
    Note over Redis: Persistent visit counter across all requests
```

### **Docker Stack Components:**

```mermaid
graph LR
    subgraph "Docker Stack: mystack"
        subgraph "Services"
            WS[Web Service<br/>mystack_web]
            RS[Redis Service<br/>mystack_redis]
        end
        
        subgraph "Networks"
            ON[Overlay Network<br/>webnet]
        end
        
        subgraph "Images"
            SI[stackdemo<br/>Custom Flask]
            RI[redis:alpine<br/>Official Redis]
        end
    end
    
    WS --> SI
    RS --> RI
    WS --- ON
    RS --- ON
```

---

## 🚀 **Step-by-Step Deployment**

### **Prerequisites:**
```bash
# Ensure Docker Swarm is initialized
docker swarm init

# Verify swarm mode
docker node ls
```

### **Step 1: Get Project Files**

```bash
# Clone repository
git clone https://github.com/manikcloud/cloud-devops-learning-path.git

# Navigate to stack project
cd cloud-devops-learning-path/Section-2-DevOps/Session-6_Docker-Swarm/6.2_stack_project

# Check project structure
ls -la
# Expected: app.py, requirements.txt, Dockerfile, docker-compose.yml, README.md
```

### **Step 2: Build Flask Application**

```bash
# Build the Flask app image
docker build -t stackdemo .

# Verify image creation
docker images | grep stackdemo

# Expected output:
# stackdemo    latest    abc123def456    2 minutes ago    200MB
```

### **Step 3: Deploy Complete Stack**

```bash
# Deploy Flask + Redis stack
docker stack deploy -c docker-compose.yml mystack

# Wait for services to start (30-60 seconds)
echo "Waiting for services to start..."
sleep 45
```

### **Step 4: Verify Stack Deployment**

```bash
# Check stack status
docker stack ls

# Expected output:
# NAME      SERVICES   ORCHESTRATOR
# mystack   2          Swarm

# Check individual services
docker stack services mystack

# Expected output:
# ID        NAME           MODE         REPLICAS   IMAGE           PORTS
# abc123    mystack_redis  replicated   1/1        redis:alpine    
# def456    mystack_web    replicated   3/3        stackdemo       *:8000->8000/tcp
```

### **Step 5: Test Application Functionality**

```bash
# Test visit counter (first visit)
curl http://localhost:8000
# Expected: "Hello World! I have been seen 1 times."

# Test again (counter should increment)
curl http://localhost:8000
# Expected: "Hello World! I have been seen 2 times."

# Test multiple times to verify persistence
for i in {1..5}; do 
  echo "Visit $i: $(curl -s http://localhost:8000)"
done
```

---

## 📊 **Application Testing & Verification**

### **Load Balancing Test:**
```bash
# Test load balancing across Flask replicas
echo "Testing load balancing..."
for i in {1..10}; do
  response=$(curl -s http://localhost:8000)
  echo "Request $i: $response"
  sleep 1
done

# All requests should increment the same counter (shared Redis data)
# Traffic should be distributed across 3 Flask containers
```

### **Service Discovery Test:**
```bash
# Test from any web container - Method 1
docker exec -it $(docker ps -q --filter name=mystack_web | head -1) sh

# Then inside the container:
ping redis
nslookup redis

# Alternative - Direct command test
docker exec -it $(docker ps -q --filter name=mystack_web | head -1) ping redis

# Test Redis connectivity from Flask container
docker exec -it $(docker ps -q --filter name=mystack_web | head -1) nc -zv redis 6379
```

### **High Availability Test:**
```bash
# Remove one Flask container (simulate failure)
flask_container=$(docker ps -q -f name=mystack_web | head -1)
docker container rm -f $flask_container

# Check if Swarm recreates the container
sleep 10
docker service ps mystack_web

# Test if application still works
curl http://localhost:8000
# Should still work with remaining containers
```

---

## 🔧 **Stack Management Operations**

### **Scaling Services:**
```bash
# Scale Flask web service to 5 replicas
docker service scale mystack_web=5

# Verify scaling
docker service ps mystack_web

# Test with increased load
for i in {1..20}; do curl -s http://localhost:8000 & done
wait
```

### **Service Updates:**
```bash
# Update Flask service (zero-downtime deployment)
docker service update --image stackdemo:v2 mystack_web

# Monitor update progress
docker service ps mystack_web

# Rollback if needed
docker service rollback mystack_web
```

### **Monitoring & Logs:**
```bash
# View Flask service logs
docker service logs mystack_web

# View Redis service logs
docker service logs mystack_redis

# Follow logs in real-time
docker service logs -f mystack_web

# Check service resource usage
docker stats $(docker ps -q -f name=mystack)
```

---

## 📋 **Docker Compose Configuration**

### **Stack Definition (docker-compose.yml):**
```yaml
version: '3.8'

services:
  redis:
    image: redis:alpine
    networks:
      - webnet
    deploy:
      replicas: 1
      placement:
        constraints: [node.role == manager]

  web:
    image: stackdemo
    depends_on:
      - redis
    ports:
      - "8000:8000"
    networks:
      - webnet
    deploy:
      replicas: 3
      update_config:
        parallelism: 1
        delay: 10s
      restart_policy:
        condition: on-failure

networks:
  webnet:
    driver: overlay
```

### **Key Configuration Features:**
- **Overlay Network:** Secure multi-host networking
- **Service Dependencies:** Web service waits for Redis
- **Placement Constraints:** Redis runs on manager node
- **Update Strategy:** Rolling updates with zero downtime
- **Restart Policy:** Automatic recovery on failure

---

## 🔍 **Troubleshooting Guide**

### **Services Not Starting:**
```bash
# Check service status
docker stack services mystack

# If replicas show 0/3 or 0/1:
docker service logs mystack_web
docker service logs mystack_redis

# Check node resources
docker node ls
free -h
df -h
```

### **Application Not Accessible:**
```bash
# Verify port binding
docker service inspect mystack_web | grep -A 5 "PublishedPorts"

# Check if services are running
docker service ps mystack_web
docker service ps mystack_redis

# Test internal connectivity
docker exec -it $(docker ps -q -f name=mystack_web) curl http://localhost:8000
```

### **Counter Not Incrementing:**
```bash
# Check Redis connectivity
docker service logs mystack_redis

# Test Redis from Flask container
docker exec -it $(docker ps -q -f name=mystack_web) redis-cli -h redis ping

# Verify network connectivity
docker network ls | grep mystack
docker network inspect mystack_webnet
```

### **Performance Issues:**
```bash
# Check resource usage
docker stats

# Monitor service performance
docker service ps mystack_web
docker service ps mystack_redis

# Check system resources
top
iostat 1 5
```

---

## 📁 **Project Structure**

```
6.2_stack_project/
├── app.py                # Flask application with Redis integration
├── requirements.txt      # Python dependencies (flask==2.0.1, redis==3.5.3)
├── Dockerfile           # Multi-stage Flask container build
├── docker-compose.yml   # Complete stack definition
└── README.md           # This comprehensive guide
```

### **Application Code Overview:**

**app.py - Flask Application:**
```python
from flask import Flask
from redis import Redis
import os

app = Flask(__name__)
redis = Redis(host='redis', port=6379)

@app.route('/')
def hello():
    count = redis.incr('hits')
    return f'Hello World! I have been seen {count} times.\n'

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)
```

**Key Features:**
- Connects to Redis using service name `redis`
- Increments visit counter on each request
- Returns formatted response with visit count

---

## 🎓 **Learning Outcomes**

### **Technical Skills Mastered:**
- ✅ **Multi-Service Deployment** - Deploy interconnected services
- ✅ **Service Discovery** - Container communication by service name
- ✅ **Overlay Networking** - Secure multi-host container networking
- ✅ **Load Balancing** - Distribute traffic across service replicas
- ✅ **Data Persistence** - Maintain state across container restarts
- ✅ **Rolling Updates** - Zero-downtime application updates

### **Production Concepts:**
- ✅ **Stack Management** - Manage multi-service applications as units
- ✅ **Service Dependencies** - Handle service startup order
- ✅ **High Availability** - Design fault-tolerant applications
- ✅ **Monitoring & Logging** - Track application health and performance

---

## 🧹 **Cleanup**

```bash
# Remove the entire stack
docker stack rm mystack

# Verify stack removal
docker stack ls

# Remove custom images (optional)
docker rmi stackdemo

# Remove unused networks
docker network prune -f

# Verify cleanup
docker service ls
docker network ls
```

---

<div align="center">

### 🎯 **Congratulations!**

You've successfully deployed a production-ready multi-service application using Docker Stack!

**Next Steps:** Explore Kubernetes or advanced Docker Swarm features

*Master container orchestration with real-world applications!*

</div>
