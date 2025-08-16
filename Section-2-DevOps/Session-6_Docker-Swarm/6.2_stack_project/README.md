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

## 🚀 PHP Login Application Stack

This project deploys a complete PHP login application with MySQL database using Docker Stack.

### **Application Features:**
- **User Registration** - Create new user accounts
- **User Login** - Authenticate existing users
- **Password Hashing** - Secure password storage
- **Database Integration** - MySQL backend storage
- **Container Info** - Shows which container serves the request
- **Load Balancing** - 2 PHP replicas distribute traffic

---

## 🚀 Quick Steps

### **Step 1: Clone Repository**
```bash
# Clone the repository
git clone https://github.com/manikcloud/cloud-devops-learning-path.git

# Navigate to stack project
cd cloud-devops-learning-path/Section-2-DevOps/Session-6_Docker-Swarm/6.2_stack_project

# Check files
ls -la
```

### **Step 2: Initialize Swarm**
```bash
# Initialize swarm (if not already done)
docker swarm init

# Verify swarm
docker node ls
```

### **Step 3: Deploy Stack**
```bash
# Deploy PHP + MySQL stack
docker stack deploy -c docker-compose.yml loginapp

# Check stack
docker stack ls
```

### **Step 4: Check Services**
```bash
# List stack services
docker stack services loginapp

# Check service details
docker service ps loginapp_web
docker service ps loginapp_db
```

### **Step 5: Test Application**
```bash
# Wait for services to be ready (30-60 seconds)
sleep 60

# Access login application
curl http://localhost:8080

# Or open in browser: http://localhost:8080
```

---

## 🔧 Stack Management

### **Test Login Application**
```bash
# Test with sample users:
# Username: admin, Password: admin123
# Username: testuser, Password: test123

# Or register new users through the web interface
```

### **View Stack Info**
```bash
# List all stacks
docker stack ls

# List services in stack
docker stack services loginapp

# Check service logs
docker service logs loginapp_web
docker service logs loginapp_db
```

### **Scale Services**
```bash
# Scale web service
docker service scale loginapp_web=4

# Check scaling
docker service ps loginapp_web
```

### **Remove Stack**
```bash
# Remove entire stack
docker stack rm loginapp

# Verify removal
docker stack ls
```

---

## 📋 What's Included

### **Services:**
- **Web Service** - 2 PHP-Apache replicas on port 8080
- **Database Service** - 1 MySQL replica with sample users

### **Network:**
- **Overlay Network** - Services can communicate by name
- **webnet** - Custom network for the stack

### **Stack Benefits in This Project:**
- **Single Command Deployment** - `docker stack deploy -c docker-compose.yml loginapp`
- **Service Discovery** - PHP app connects to database using hostname `db`
- **Load Balancing** - Traffic distributed across 2 PHP replicas
- **High Availability** - If one container fails, others continue
- **Data Persistence** - Database initialization with sample users
- **Real Application** - Functional login system with user registration

---

## 📁 Project Files

```
6.2_stack_project/
├── docker-compose.yml     # Stack definition (PHP + MySQL)
├── init.sql              # Database initialization script
├── app/                  # PHP application files
│   └── index.php        # Login application
└── README.md            # This guide
```

### **Sample Users:**
- **Username:** admin, **Password:** admin123
- **Username:** testuser, **Password:** test123

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
