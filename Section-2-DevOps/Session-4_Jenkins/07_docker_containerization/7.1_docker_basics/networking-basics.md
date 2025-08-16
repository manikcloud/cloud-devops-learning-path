# 🌐 Docker Networking Basics - Simple Guide

## 📖 What is Docker Networking?

Docker networking allows containers to communicate with each other and the outside world. Think of it like connecting computers in an office - they need a network to talk to each other!

---

## 🏗️ Network Types

### **1. Bridge Network (Default)**
```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│ Container A │    │ Container B │    │ Container C │
│   App1      │    │   App2      │    │   Database  │
└─────────────┘    └─────────────┘    └─────────────┘
       │                   │                   │
       └───────────────────┼───────────────────┘
                           │
                    ┌─────────────┐
                    │   Bridge    │
                    │  Network    │
                    └─────────────┘
                           │
                    ┌─────────────┐
                    │    Host     │
                    │  Machine    │
                    └─────────────┘
```

**How it works:**
- Default network for containers
- Containers get their own IP addresses
- Need port mapping to access from outside
- Containers can talk to each other

### **2. Host Network**
```
┌─────────────┐
│ Container   │
│   App       │ ← Uses host's network directly
└─────────────┘
       │
┌─────────────┐
│    Host     │
│  Network    │
└─────────────┘
```

**How it works:**
- Container uses host's network directly
- No isolation between container and host
- No port mapping needed
- Faster performance

### **3. Custom Networks**
```
┌─────────────┐    ┌─────────────┐
│ Container A │    │ Container B │
│   Web App   │    │  Database   │
└─────────────┘    └─────────────┘
       │                   │
       └───────────────────┘
                │
        ┌─────────────┐
        │   Custom    │
        │  Network    │
        │ "mynetwork" │
        └─────────────┘
```

**How it works:**
- You create your own network
- Better isolation and control
- Containers can use names to communicate
- Recommended for multi-container apps

---

## 📊 Port Mapping Explained

### **Without Port Mapping:**
```
Host Machine (your computer)
├── Port 80: Not accessible
├── Port 8080: Not accessible
└── Docker Container
    └── Port 80: nginx running (only inside container)
```

### **With Port Mapping:**
```bash
docker run -d -p 8080:80 nginx
```
```
Host Machine (your computer)
├── Port 8080 ──────┐
└── Docker Container │
    └── Port 80 ←────┘ nginx running (accessible from outside)
```

**Access via:** `http://localhost:8080`

---

## 🛠️ Basic Networking Commands

### **Network Management**
```bash
# List all networks
docker network ls

# Create custom network
docker network create mynetwork

# Inspect network details
docker network inspect mynetwork

# Remove network
docker network rm mynetwork

# Connect running container to network
docker network connect mynetwork container-name

# Disconnect container from network
docker network disconnect mynetwork container-name
```

### **Container Communication Testing**
```bash
# Test connectivity between containers
docker exec container1 ping container2

# Check container's IP address
docker inspect container-name | grep IPAddress

# Test port connectivity
docker exec container1 telnet container2 80
```

---

## 📋 Quick Reference

### **Network Types Summary**
| Network Type | Use Case | Container Communication | External Access |
|--------------|----------|------------------------|-----------------|
| **Bridge** | Default, simple apps | IP addresses | Port mapping required |
| **Host** | High performance | Host network | Direct access |
| **Custom** | Multi-container apps | Container names | Port mapping required |

### **Essential Commands**
```bash
# Quick network setup
docker network create mynet
docker run -d --network mynet --name app1 nginx
docker run -d --network mynet --name app2 alpine
docker exec app2 ping app1

# Quick cleanup
docker network rm mynet
```

---

*Understanding Docker networking is key to building communicating applications!* 🚀
