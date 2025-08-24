# 🐝 6.1 Docker Swarm Basics & Web Project

<div align="center">

![Docker Swarm](https://img.shields.io/badge/Docker-Swarm_Basics-blue?style=for-the-badge&logo=docker&logoColor=white)
![Web Project](https://img.shields.io/badge/Project-Interactive_Web-green?style=for-the-badge&logo=html5&logoColor=white)

**🎯 Learn Swarm Fundamentals | 🚀 Build Interactive Web App | 📊 Multi-Node Deployment**

</div>

---

## 📋 **What You'll Build**

An interactive color-changing web application deployed across multiple Docker Swarm nodes with:
- ✅ **Multi-node cluster** setup
- ✅ **Load balancing** across replicas
- ✅ **Service scaling** capabilities
- ✅ **Interactive web interface** with color buttons

---

## 🏗️ **Project Architecture**

### **Swarm Cluster Setup:**

```mermaid
graph TB
    subgraph "🐝 Docker Swarm Cluster"
        subgraph "Manager Node (EC2-1)"
            M1[Manager<br/>🎯 Controls Cluster]
            S1[Service: hello-swarm<br/>Replicas: 3]
        end
        
        subgraph "Worker Node (EC2-2)"
            W1[Worker<br/>🔧 Runs Tasks]
        end
        
        subgraph "Load Balancer"
            LB[Built-in Load Balancer<br/>Port 9090]
        end
        
        M1 --> S1
        M1 -.->|Orchestrates| W1
        S1 --> LB
        LB --> C1[Container 1]
        LB --> C2[Container 2] 
        LB --> C3[Container 3]
    end
    
    U[User Browser] --> LB
```

### **Service Distribution:**

```mermaid
graph LR
    subgraph "Service Deployment Flow"
        A[docker service create] --> B[Swarm Manager]
        B --> C[Task Scheduler]
        C --> D[Node Selection]
        D --> E[Container Creation]
        
        E --> F[Manager Node<br/>Container 1]
        E --> G[Manager Node<br/>Container 2]
        E --> H[Worker Node<br/>Container 3]
    end
```

---

## 🚀 **Getting Started**

### **Prerequisites**
- Docker installed and running
- At least 2 EC2 instances (or local machines)
- Basic understanding of Docker containers

### **Setup Instructions**
```bash
# Clone the repository
git clone https://github.com/manikcloud/cloud-devops-learning-path.git
cd cloud-devops-learning-path/Section-2-DevOps/Session-6_Docker-Swarm/6.1_swarm_basics

# Verify files are present
ls -la
# You should see: Dockerfile, index.html, README.md

# Verify Docker is running
docker --version
docker info

# Optional: Test the Dockerfile before proceeding
chmod +x test-dockerfile.sh
./test-dockerfile.sh
```

---

## 🚀 **Step-by-Step Guide**

### **Prerequisites Setup:**
```bash
# Ensure you have 2 EC2 instances with Docker installed
# Security Group: Allow all traffic between instances
```

### **Step 1: Initialize Swarm Cluster**

**On Manager Node (EC2-1):**
```bash
# Initialize swarm
docker swarm init

# Get worker join token (save this output)
docker swarm join-token worker
```

**On Worker Node (EC2-2):**
```bash
# Join the swarm (use token from above)
docker swarm join --token SWMTKN-1-xxxxx <manager-private-ip>:2377
```

**Verify Cluster (on Manager):**
```bash
# Check nodes
docker node ls

# Expected output:
# ID            HOSTNAME   STATUS    AVAILABILITY   MANAGER STATUS
# abc123*       manager    Ready     Active         Leader
# def456        worker     Ready     Active
```

### **Step 2: Get Project Files**

```bash
# Clone repository
git clone https://github.com/manikcloud/cloud-devops-learning-path.git

# Navigate to project
cd cloud-devops-learning-path/Section-2-DevOps/Session-6_Docker-Swarm/6.1_swarm_basics

# Check project files
ls -la
# Expected: index.html, Dockerfile, README.md
```

### **Step 3: Build Application Image**

```bash
# Build the interactive web app image
docker build -t hello-swarm .

# Verify image creation
docker images | grep hello-swarm
```

### **Step 4: Deploy Service Across Cluster**

```bash
# Deploy service with 3 replicas
docker service create \
  --name web \
  --publish 9090:80 \
  --replicas 3 \
  hello-swarm

# Check service status
docker service ls
```

### **Step 5: Verify Deployment**

```bash
# Check service details
docker service ps web

# Expected output shows containers distributed across nodes:
# ID       NAME    IMAGE        NODE      DESIRED STATE   CURRENT STATE
# abc123   web.1   hello-swarm  manager   Running         Running 1 minute ago
# def456   web.2   hello-swarm  worker    Running         Running 1 minute ago
# ghi789   web.3   hello-swarm  manager   Running         Running 1 minute ago
```

### **Step 6: Test Interactive Application**

```bash
# Test with curl
curl http://localhost:9090

# Or open in browser: http://<manager-public-ip>:9090
# You should see an interactive page with color-changing buttons
```

---

## 🎯 **Interactive Features Testing**

### **Browser Test - See Container IDs:**
```bash
# 1. Open in browser: http://<your-server-ip>:9090
# 2. Refresh the page multiple times
# 3. Notice different Container IDs appear - this proves load balancing!

# Or test with curl to see container IDs:
for i in {1..10}; do 
  echo "Request $i:"
  curl -s http://localhost:9090 | grep -o '[a-f0-9]\{12\}'
done

# You should see different container IDs, proving load balancing works
```

### **Scaling Test:**
```bash
# Scale up to 5 replicas
docker service scale web=5

# Check distribution
docker service ps web

# Scale down to 2 replicas
docker service scale web=2

# Verify scaling
docker service ps web
```

### **High Availability Test:**
```bash
# Find a container ID
docker service ps web

# Remove a container (simulate failure)
docker container rm -f <container-id>

# Check if Swarm recreates it automatically
docker service ps web

# The service should maintain desired replica count
```

---

## 📁 **Project Files**

```
6.1_swarm_basics/
├── index.html              # Simple web page showing container ID
├── Dockerfile              # Apache httpd container definition
└── README.md              # This guide
```

### **File Contents:**

**Dockerfile:**
```dockerfile
FROM httpd:2.4
COPY index.html /usr/local/apache2/htdocs/
EXPOSE 80
```

**index.html:**
- Simple web page showing container ID and hostname
- Displays current timestamp for each request
- Demonstrates load balancing across replicas

---

## 🎓 **Learning Outcomes**

After completing this project, you will understand:

### **Technical Skills:**
- ✅ **Swarm Initialization** - Set up multi-node clusters
- ✅ **Service Deployment** - Deploy applications across nodes
- ✅ **Load Balancing** - Distribute traffic automatically
- ✅ **Service Scaling** - Scale applications up and down
- ✅ **High Availability** - Handle container failures gracefully

### **Practical Knowledge:**
- ✅ **Multi-node orchestration** concepts
- ✅ **Container distribution** strategies
- ✅ **Service discovery** mechanisms
- ✅ **Cluster management** best practices

---

## 🔧 **Troubleshooting**

### **Common Docker Build Issues:**

#### **Issue 1: "COPY failed: no such file or directory"**
```bash
# Solution: Ensure you're in the correct directory
pwd
ls -la
# You should see: Dockerfile, index.html, README.md

# If files are missing, clone the repository:
git clone https://github.com/manikcloud/cloud-devops-learning-path.git
cd cloud-devops-learning-path/Section-2-DevOps/Session-6_Docker-Swarm/6.1_swarm_basics
```

#### **Issue 2: "Docker daemon not running"**
```bash
# Start Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Verify Docker is running
docker info
```

#### **Issue 3: "Permission denied"**
```bash
# Add user to docker group
sudo usermod -aG docker $USER

# Logout and login again, or use:
newgrp docker

# Test without sudo
docker ps
```

#### **Issue 4: "Port already in use"**
```bash
# Check what's using port 8080
sudo netstat -tulpn | grep 8080

# Kill the process or use a different port
docker service create --name hello-swarm --publish 8081:80 --replicas 3 hello-swarm
```

#### **Issue 5: "Image build fails"**
```bash
# Clean build with no cache
docker build --no-cache -t hello-swarm .

# Check Docker space
docker system df

# Clean up if needed
docker system prune -f
```

### **Swarm-Specific Issues:**

#### **Issue 6: "This node is not a swarm manager"**
```bash
# Initialize swarm on current node
docker swarm init

# Or join existing swarm as manager
docker swarm join-token manager
```

#### **Issue 7: "Service not accessible"**
```bash
# Check service status
docker service ls
docker service ps hello-swarm

# Check if containers are running
docker ps

# Verify port mapping
docker service inspect hello-swarm --pretty
```

---

## 🧹 **Cleanup**

```bash
# Remove service
docker service rm web

# Leave swarm mode (on both nodes)
docker swarm leave --force

# Remove custom image
docker rmi hello-swarm

# Verify cleanup
docker service ls
docker node ls
```

---

<div align="center">

### 🎯 **Ready for Advanced Stacks?**

**Next: [6.2 Stack Project](../6.2_stack_project/README.md)**

*Build multi-service applications with Flask + Redis!*

</div>
