# 📚 7.1 Kubernetes Basics

## 🎯 What is Kubernetes?

Kubernetes (K8s) is like a **smart manager** for your containers. It automatically:
- Starts and stops containers
- Fixes broken containers
- Balances traffic between containers
- Scales up when busy, scales down when quiet

## 🏗️ Simple Architecture

```
┌─────────────────────────────────────────┐
│            ☸️ KUBERNETES                │
│                                         │
│  🎛️ Master Node (Brain)                 │
│  • API Server (receives commands)       │
│  • Scheduler (decides where to put apps)│
│  • etcd (remembers everything)          │
│                                         │
│  🖥️ Worker Nodes (Muscles)              │
│  • kubelet (follows orders)             │
│  • Pods (containers live here)          │
│  • kube-proxy (handles networking)      │
└─────────────────────────────────────────┘
```

## 🛠️ Install kubectl (Your Remote Control)

### On Linux:
```bash
# Download kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# Make it executable
chmod +x kubectl

# Move to system path
sudo mv kubectl /usr/local/bin/

# Check it works
kubectl version --client
```

### On Mac:
```bash
brew install kubectl
```

### On Windows:
```powershell
choco install kubernetes-cli
```

## 🎮 Basic kubectl Commands

```bash
# See cluster info
kubectl cluster-info

# List all nodes
kubectl get nodes

# List all pods
kubectl get pods

# Create a simple pod
kubectl run nginx --image=nginx

# See what happened
kubectl get pods

# Delete the pod
kubectl delete pod nginx
```

## 🧪 Try It Yourself

### Exercise 1: Your First Pod
```bash
# Create a web server
kubectl run my-web --image=nginx

# Check if it's running
kubectl get pods

# See details
kubectl describe pod my-web

# Clean up
kubectl delete pod my-web
```

### Exercise 2: Pod with Port
```bash
# Create pod and expose port
kubectl run my-app --image=nginx --port=80

# Check it
kubectl get pods -o wide

# Delete it
kubectl delete pod my-app
```

## 📝 Key Concepts (Simple!)

- **Pod**: A box that holds your container(s)
- **Node**: A computer in your cluster
- **Cluster**: All your computers working together
- **kubectl**: Your remote control for Kubernetes

## 🚀 Next Step

Ready to set up a real cluster? Go to **[7.2 - Cluster Setup](../7.2_cluster_setup/)**

---

*Keep it simple, keep learning!* ☸️
