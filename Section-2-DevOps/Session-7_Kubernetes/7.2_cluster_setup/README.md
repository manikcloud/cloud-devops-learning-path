# 🏗️ 7.2 Deploy Kube Cluster on AWS

## 🎯 Three Ways to Get Started

### Option 1: k3s (Super Easy - Lightweight)
### Option 2: Minikube (Easy - Local Learning)
### Option 3: AWS EKS (Real - Production Ready)

---

## ⚡ Option 1: k3s Setup (Fastest Start!)

**k3s** is the easiest way to get Kubernetes running - perfect for learning!

### Install k3s (One Command!)
```bash
# Install k3s (works on any Linux machine)
curl -sfL https://get.k3s.io | sh -

# Check it's running
sudo k3s kubectl get nodes

# Copy kubeconfig for regular kubectl
mkdir -p ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chown $(id -u):$(id -g) ~/.kube/config

# Now use regular kubectl
kubectl get nodes
```

### Quick Test
```bash
# Create a simple app
kubectl create deployment hello --image=nginx

# See it running
kubectl get pods

# Expose it
kubectl expose deployment hello --port=80 --type=NodePort

# Get the port
kubectl get services

# Access it (replace NODE_PORT with actual port)
curl http://localhost:NODE_PORT
```

### Why k3s is Great for Learning:
- ✅ **Super fast** - Installs in seconds
- ✅ **Lightweight** - Uses less resources
- ✅ **Real Kubernetes** - Not a simulation
- ✅ **Easy cleanup** - Simple to remove

---

## 🖥️ Option 2: Minikube Setup

### Install Minikube
```bash
# Download Minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

# Install it
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Start your cluster
minikube start

# Check it works
kubectl get nodes
```

### Quick Test
```bash
# Create a simple app
kubectl create deployment hello --image=nginx

# See it running
kubectl get pods

# Access it
minikube service hello --url
```

---

## ☁️ Option 3: AWS EKS Setup

### Prerequisites
```bash
# Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Configure AWS
aws configure
# Enter your AWS Access Key
# Enter your Secret Key
# Region: us-west-2
# Format: json
```

### Install eksctl (EKS Helper)
```bash
# Download eksctl
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp

# Install it
sudo mv /tmp/eksctl /usr/local/bin

# Check it works
eksctl version
```

### Create EKS Cluster (Simple!)
```bash
# Create cluster (takes 15-20 minutes)
eksctl create cluster \
  --name my-cluster \
  --region us-west-2 \
  --nodes 2 \
  --node-type t3.medium

# Check your cluster
kubectl get nodes
```

---

## 🧪 Test Your Cluster

### Deploy a Simple App
```bash
# Create deployment
kubectl create deployment nginx --image=nginx

# Scale it
kubectl scale deployment nginx --replicas=3

# Check pods
kubectl get pods

# Expose it (EKS only)
kubectl expose deployment nginx --port=80 --type=LoadBalancer

# Get external IP (wait a few minutes)
kubectl get services
```

---

## 🔧 Useful Commands

```bash
# Cluster info
kubectl cluster-info

# All resources
kubectl get all

# Describe something
kubectl describe deployment nginx

# Logs
kubectl logs deployment/nginx

# Delete everything
kubectl delete deployment nginx
kubectl delete service nginx
```

---

## 🤔 Which Option Should You Choose?

| Feature | k3s | Minikube | AWS EKS |
|---------|-----|----------|---------|
| **Setup Time** | 30 seconds | 2-3 minutes | 15-20 minutes |
| **Resource Usage** | Very Low | Medium | High |
| **Cost** | Free | Free | $0.10/hour + nodes |
| **Best For** | Quick learning | Local development | Production |
| **Real Kubernetes** | ✅ Yes | ✅ Yes | ✅ Yes |
| **Multi-node** | ❌ Single node | ❌ Single node | ✅ Multi-node |

### 🎯 **Recommendation:**
- **New to Kubernetes?** Start with **k3s**
- **Want full features?** Use **Minikube**  
- **Production ready?** Go with **AWS EKS**

---

## 🧹 Cleanup

### k3s
```bash
# Uninstall k3s
sudo /usr/local/bin/k3s-uninstall.sh

# Remove kubeconfig
rm ~/.kube/config
```

### Minikube
```bash
minikube stop
minikube delete
```

### EKS
```bash
# Delete the cluster
eksctl delete cluster --name my-cluster --region us-west-2
```

---

## 🎯 What You Learned

- ✅ Set up lightweight Kubernetes with k3s (fastest option)
- ✅ Set up local Kubernetes with Minikube (full features)
- ✅ Deploy real cluster on AWS EKS (production ready)
- ✅ Basic cluster management and testing
- ✅ Deploy and test applications on all platforms
- ✅ Choose the right option for your needs

## 🚀 Next Step

Ready to learn about Pods and Services? Go to **[7.3 - Pods & Services](../7.3_pods_services/)**

---

*Start simple, scale up!* 🏗️
