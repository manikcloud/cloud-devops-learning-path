# 📚 7.1 Kubernetes Basics

<div align="center">

![Kubernetes](https://img.shields.io/badge/Kubernetes-Fundamentals-blue?style=for-the-badge&logo=kubernetes&logoColor=white)
![Minikube](https://img.shields.io/badge/Minikube-Local%20Development-green?style=for-the-badge&logo=kubernetes&logoColor=white)

**🎯 Architecture Understanding | 🛠️ Local Setup | 📋 Essential Commands**

</div>

---

## 📖 What is Kubernetes?

**Kubernetes (K8s)** is an open-source container orchestration platform that automates the deployment, scaling, and management of containerized applications.

### **Why Kubernetes?**
- **Container Orchestration** - Manage thousands of containers
- **Auto-scaling** - Scale applications based on demand
- **Self-healing** - Automatically restart failed containers
- **Service Discovery** - Built-in load balancing and networking
- **Rolling Updates** - Zero-downtime deployments

---

## 🏗️ Kubernetes Architecture

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        ☸️ KUBERNETES ARCHITECTURE                          │
└─────────────────────────────────────────────────────────────────────────────┘

                            👨‍💻 Developer
                                  │
                                  │ kubectl commands
                                  ▼
                    ┌─────────────────────────────────┐
                    │        🎛️ CONTROL PLANE        │
                    │                                 │
                    │  📡 API Server                  │
                    │  • REST API endpoint            │
                    │  • Authentication & validation  │
                    │                                 │
                    │  🗄️ etcd                        │
                    │  • Cluster state storage        │
                    │  • Configuration data           │
                    │                                 │
                    │  📅 Scheduler                   │
                    │  • Pod placement decisions      │
                    │  • Resource optimization        │
                    │                                 │
                    │  🎮 Controller Manager          │
                    │  • Desired state enforcement    │
                    │  • Node/Pod lifecycle           │
                    └─────────────────────────────────┘
                                  │
                          📡 Cluster Network
                                  │
                    ┌─────────────┼─────────────┐
                    │             │             │
                    ▼             ▼             ▼
            ┌─────────────┐ ┌─────────────┐ ┌─────────────┐
            │🖥️ Worker-1   │ │🖥️ Worker-2   │ │🖥️ Worker-3   │
            │             │ │             │ │             │
            │ kubelet     │ │ kubelet     │ │ kubelet     │
            │ • Pod mgmt  │ │ • Pod mgmt  │ │ • Pod mgmt  │
            │             │ │             │ │             │
            │ kube-proxy  │ │ kube-proxy  │ │ kube-proxy  │
            │ • Networking│ │ • Networking│ │ • Networking│
            │             │ │             │ │             │
            │ Container   │ │ Container   │ │ Container   │
            │ Runtime     │ │ Runtime     │ │ Runtime     │
            │             │ │             │ │             │
            │ 📦 Pod-A    │ │ 📦 Pod-B    │ │ 📦 Pod-C    │
            │ 📦 Pod-D    │ │ 📦 Pod-E    │ │ 📦 Pod-F    │
            └─────────────┘ └─────────────┘ └─────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│  🎯 Result: Automated Container Management | 🔄 Self-healing | 📈 Scalable   │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 🛠️ Minikube Setup

### **Installation on Linux**
```bash
# Download and install Minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Start Minikube cluster
minikube start --driver=docker

# Verify installation
minikube status
kubectl cluster-info
```

### **Installation on macOS**
```bash
# Using Homebrew
brew install minikube

# Start cluster
minikube start

# Verify
minikube status
```

### **Installation on Windows**
```powershell
# Using Chocolatey
choco install minikube

# Or download installer from GitHub releases
# Start cluster
minikube start --driver=hyperv
```

---

## 📋 Essential kubectl Commands

### **Cluster Information**
```bash
# Check cluster info
kubectl cluster-info

# Get cluster nodes
kubectl get nodes

# Describe a node
kubectl describe node minikube

# Check cluster version
kubectl version
```

### **Pod Management**
```bash
# List all pods
kubectl get pods

# List pods with more details
kubectl get pods -o wide

# Create a pod
kubectl run nginx --image=nginx

# Describe a pod
kubectl describe pod nginx

# Get pod logs
kubectl logs nginx

# Delete a pod
kubectl delete pod nginx
```

### **Deployment Management**
```bash
# Create deployment
kubectl create deployment nginx --image=nginx

# List deployments
kubectl get deployments

# Scale deployment
kubectl scale deployment nginx --replicas=3

# Update deployment
kubectl set image deployment/nginx nginx=nginx:1.21

# Delete deployment
kubectl delete deployment nginx
```

### **Service Management**
```bash
# Expose deployment as service
kubectl expose deployment nginx --port=80 --type=NodePort

# List services
kubectl get services

# Describe service
kubectl describe service nginx

# Delete service
kubectl delete service nginx
```

---

## 🧪 Hands-On Exercises

### **Prerequisites**
```bash
# Clone the repository
git clone https://github.com/manikcloud/cloud-devops-learning-path.git
cd cloud-devops-learning-path/Section-2-DevOps/Session-7_Kubernetes/7.1_kubernetes_basics
```

### **🎯 Use Case: Deploy Your First Web Server**

**Scenario**: You're a new DevOps engineer tasked with deploying a simple web server for the development team to test their applications.

### **Exercise 1: Create Your First Pod**
```bash
# Apply the pod configuration
kubectl apply -f exercise-1-first-pod.yaml

# Check if pod is running
kubectl get pods

# See detailed information
kubectl describe pod my-first-pod

# Check pod logs
kubectl logs my-first-pod

# Access the pod (port forwarding)
kubectl port-forward pod/my-first-pod 8080:80

# Test in another terminal
curl http://localhost:8080

# Clean up
kubectl delete -f exercise-1-first-pod.yaml
```

### **Exercise 2: Troubleshoot a Broken Pod**
```bash
# Try to create a pod with wrong image
kubectl run broken-pod --image=nginx:wrong-tag

# Check what happened
kubectl get pods
kubectl describe pod broken-pod

# Fix it
kubectl delete pod broken-pod
kubectl run fixed-pod --image=nginx:1.21

# Verify it works
kubectl get pods
kubectl logs fixed-pod
```

## 📝 Key Concepts

### **Pods**
- Smallest deployable unit in Kubernetes
- Contains one or more containers
- Shared network and storage
- Ephemeral by nature

### **Deployments**
- Manages ReplicaSets and Pods
- Declarative updates
- Rolling updates and rollbacks
- Scaling capabilities

### **Services**
- Stable network endpoint
- Load balancing across pods
- Service discovery
- Types: ClusterIP, NodePort, LoadBalancer

### **Labels and Selectors**
- Key-value pairs for organization
- Used by services to find pods
- Flexible grouping mechanism
- Essential for Kubernetes operations

---

## 🎯 Learning Outcomes

After completing this module, you will:

- ✅ **Understand Kubernetes architecture** and core components
- ✅ **Set up local development** environment with Minikube
- ✅ **Use kubectl effectively** for cluster management
- ✅ **Deploy and manage applications** using basic resources
- ✅ **Troubleshoot common issues** in Kubernetes
- ✅ **Understand pod lifecycle** and container management

---

## ✅ Success Criteria
- [ ] Pod created successfully
- [ ] Pod shows "Running" status
- [ ] Can access web server via port-forward
- [ ] Can troubleshoot and fix issues
- [ ] Clean up resources properly

## 🚀 Next Steps

Ready to move to production? Continue with:

**[7.2 - Cluster Setup on AWS →](../7.2_cluster_setup/)**

Learn to deploy and manage Kubernetes clusters on AWS EKS for production workloads.

---

*Master the fundamentals before moving to production deployments!* ☸️
