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

## 🛠️ k3s Setup (Recommended)

### **Installation on Linux (Fastest & Easiest)**
```bash
# Install k3s with one command
curl -sfL https://get.k3s.io | sh -

# Setup kubectl access for regular user
mkdir -p ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chown $(id -u):$(id -g) ~/.kube/config

# Verify installation
kubectl get nodes
kubectl cluster-info
```

### **Installation on macOS**
```bash
# Install k3s using multipass (VM)
brew install multipass

# Create Ubuntu VM
multipass launch --name k3s-vm --cpus 2 --mem 4G --disk 20G

# Install k3s in VM
multipass exec k3s-vm -- /bin/bash -c "curl -sfL https://get.k3s.io | sh -"

# Get kubeconfig
multipass exec k3s-vm -- sudo cat /etc/rancher/k3s/k3s.yaml > ~/.kube/config

# Update server IP in config
VM_IP=$(multipass info k3s-vm | grep IPv4 | awk '{print $2}')
sed -i '' "s/127.0.0.1/$VM_IP/g" ~/.kube/config

# Verify
kubectl get nodes
```

### **Installation on Windows (WSL2)**
```bash
# In WSL2 Ubuntu terminal
curl -sfL https://get.k3s.io | sh -

# Setup kubectl access
mkdir -p ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chown $(id -u):$(id -g) ~/.kube/config

# Verify
kubectl get nodes
```

### **Why k3s for Learning?**
- ✅ **30-second setup** - Fastest way to get Kubernetes running
- ✅ **Lightweight** - Uses minimal resources (512MB RAM)
- ✅ **Real Kubernetes** - 100% compatible API, not a simulation
- ✅ **Built-in components** - Ingress, DNS, storage included
- ✅ **Perfect for exercises** - All Session 7 exercises work flawlessly

### **Quick Test**
```bash
# Test your k3s installation
kubectl create deployment test --image=nginx
kubectl get pods
kubectl delete deployment test
```

---

## 📋 Essential kubectl Commands

**Note**: All these commands work perfectly with k3s - no differences from other Kubernetes distributions!

### **Cluster Information**
```bash
# Check cluster info
kubectl cluster-info

# Get cluster nodes (should show your k3s node)
kubectl get nodes

# Describe a node
kubectl describe node $(kubectl get nodes -o jsonpath='{.items[0].metadata.name}')

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
# 1. Make sure you have a cluster running (from 7.1)
kubectl get nodes  # Should show your cluster nodes

# 2. Clone the repository
git clone https://github.com/manikcloud/cloud-devops-learning-path.git
cd cloud-devops-learning-path/Section-2-DevOps/Session-7_Kubernetes/7.2_kubernetes_basics

# 3. Verify cluster is working
kubectl cluster-info
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

Ready to work with Pods? Continue with:

**[7.3 - Pods Management →](../7.3_pods_management/)**

Learn to create, manage, and troubleshoot Kubernetes pods - the fundamental building blocks.

---

*Understand the architecture before building applications!* ☸️
