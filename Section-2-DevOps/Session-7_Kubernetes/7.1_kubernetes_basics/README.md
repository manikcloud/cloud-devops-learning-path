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

## 📚 Learning Progression

The exercises are designed to build your knowledge progressively:

### **🔰 Beginner Level**
1. **01-simple-pod.yaml** - Absolute basics: container in a pod
2. **02-pod-with-name.yaml** - Proper naming conventions
3. **03-pod-with-labels.yaml** - Labels for organization and selection

### **🔶 Intermediate Level**
4. **04-blue-pod.yaml** & **05-green-pod.yaml** - Blue-green deployment pattern
5. **06-database-pod.yaml** - Environment variables and stateful services

### **🔴 Advanced Level**
6. **07-multi-container-pod.yaml** - Sidecar pattern and container communication
7. **exercise-1-first-pod.yaml** - Production-ready pod with resource limits

### **🛠️ Troubleshooting**
8. **Broken pod exercise** - Real-world debugging skills

---

## 🧪 Hands-On Exercises

### **Prerequisites**
```bash
# Clone the repository
git clone https://github.com/manikcloud/cloud-devops-learning-path.git
cd cloud-devops-learning-path/Section-2-DevOps/Session-7_Kubernetes/7.1_kubernetes_basics
```

### **🎯 Use Case: Progressive Pod Learning**

**Scenario**: You're learning Kubernetes step-by-step, starting from the simplest pod to advanced multi-container patterns.

### **Exercise 1: Your First Simple Pod**
```bash
# Start with the simplest possible pod
kubectl apply -f 01-simple-pod.yaml

# Check if it's running
kubectl get pods

# See what's inside
kubectl describe pod simple-pod

# Clean up
kubectl delete -f 01-simple-pod.yaml
```

### **Exercise 2: Pod with Proper Naming**
```bash
# Deploy a properly named pod
kubectl apply -f 02-pod-with-name.yaml

# Check the pod
kubectl get pods
kubectl describe pod web-server

# Clean up
kubectl delete -f 02-pod-with-name.yaml
```

### **Exercise 3: Pod with Labels**
```bash
# Deploy pod with labels for organization
kubectl apply -f 03-pod-with-labels.yaml

# Check labels
kubectl get pods --show-labels

# Filter by labels
kubectl get pods -l name=myapp

# Port forward to test
kubectl port-forward pod/myapp 8080:80

# Test in another terminal
curl http://localhost:8080

# Clean up
kubectl delete -f 03-pod-with-labels.yaml
```

### **Exercise 4: Blue-Green Pod Pattern**
```bash
# Deploy blue version
kubectl apply -f 04-blue-pod.yaml

# Deploy green version
kubectl apply -f 05-green-pod.yaml

# Check both pods
kubectl get pods -l application=web-app

# Check different colors
kubectl get pods -l color=blue
kubectl get pods -l color=green

# Test both versions
kubectl port-forward pod/blue-app 8081:80 &
kubectl port-forward pod/green-app 8082:80 &

# Test both
curl http://localhost:8081  # Blue version
curl http://localhost:8082  # Green version

# Clean up
kubectl delete -f 04-blue-pod.yaml
kubectl delete -f 05-green-pod.yaml
```

### **Exercise 5: Database Pod with Environment Variables**
```bash
# Deploy database pod
kubectl apply -f 06-database-pod.yaml

# Check the pod
kubectl get pods
kubectl describe pod postgres-database

# Check environment variables
kubectl exec postgres-database -- env | grep POSTGRES

# Connect to database (optional)
kubectl exec -it postgres-database -- psql -U postgres -d myapp

# Clean up
kubectl delete -f 06-database-pod.yaml
```

### **Exercise 6: Advanced Multi-Container Pod**
```bash
# Deploy multi-container pod (sidecar pattern)
kubectl apply -f 07-multi-container-pod.yaml

# Check the pod (should show 2/2 containers ready)
kubectl get pods

# Check logs from both containers
kubectl logs multi-container -c nginx
kubectl logs multi-container -c alpine-sidecar

# Execute into specific container
kubectl exec -it multi-container -c nginx -- /bin/bash

# Clean up
kubectl delete -f 07-multi-container-pod.yaml
```

### **Exercise 7: Your Original First Pod (Enhanced)**
```bash
# Deploy your enhanced first pod
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

### **Exercise 8: Troubleshoot a Broken Pod**
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
- [ ] Simple pod created and running
- [ ] Pod with labels deployed successfully
- [ ] Can filter pods using label selectors
- [ ] Blue-green pod pattern demonstrated
- [ ] Database pod with environment variables working
- [ ] Multi-container pod (sidecar pattern) running
- [ ] Can access pods via port-forward
- [ ] Can troubleshoot and fix broken pods
- [ ] Understand pod lifecycle and states
- [ ] Clean up resources properly

## 🚀 Next Steps

Ready to move to production? Continue with:

**[7.2 - Cluster Setup on AWS →](../7.2_cluster_setup/)**

Learn to deploy and manage Kubernetes clusters on AWS EKS for production workloads.

---

*Master the fundamentals before moving to production deployments!* ☸️
