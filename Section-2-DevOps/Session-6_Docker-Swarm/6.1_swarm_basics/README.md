# 🐝 Docker Swarm Basics & Project

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
docker service create --name web --publish 8080:80 --replicas 3 nginx

# List services
docker service ls

# Check service details
docker service ps web

# Scale service
docker service scale web=5

# Update service
docker service update --image nginx:alpine web

# Remove service
docker service rm web
```

---

## 🚀 Simple Web Project

### **Step 1: Clone Repository**
```bash
# Clone the repository
git clone https://github.com/manikcloud/cloud-devops-learning-path.git

# Navigate to project
cd cloud-devops-learning-path/Section-2-DevOps/Session-6_Docker-Swarm/6.1_swarm_basics

# Check files
ls -la
```

### **Step 2: Build Docker Image**
```bash
# Build image
docker build -t hello-swarm .

# Verify image
docker images | grep hello-swarm
```

### **Step 3: Initialize Swarm**
```bash
# Initialize swarm
docker swarm init

# Check nodes
docker node ls
```

### **Step 4: Deploy Service**
```bash
# Deploy service with 3 replicas
docker service create --name web --publish 8080:80 --replicas 3 hello-swarm

# Check service
docker service ls
docker service ps web
```

### **Step 5: Test Application**
```bash
# Test with curl
curl http://localhost:8080

# Or open in browser: http://localhost:8080
```

### **Step 6: Scale and Test**
```bash
# Scale up
docker service scale web=5

# Check distribution
docker service ps web

# Test load balancing
for i in {1..10}; do curl -s http://localhost:8080 | grep "Docker Swarm"; done
```

---

## 🔍 Troubleshooting

```bash
# If join fails:
ping <manager-private-ip>
sudo systemctl status docker
sudo systemctl start docker

# Regenerate token if needed
docker swarm join-token --rotate worker
```

---

*Simple Docker Swarm with interactive web app!* 🚀

---

## 📁 Project Files

```
6.1_swarm_basics/
├── index.html              # Simple HTML with color buttons
├── Dockerfile              # Apache httpd container
└── README.md              # This guide
```

---

## 🔧 Cleanup

```bash
# Remove service
docker service rm web

# Leave swarm mode
docker swarm leave --force

# Remove image
docker rmi hello-swarm
```
