# 🏗️ 7.2 Deploy Kube Cluster on AWS

## 🎯 Two Ways to Get Started

### Option 1: Minikube (Easy - Local Learning)
### Option 2: AWS EKS (Real - Production Ready)

---

## 🖥️ Option 1: Minikube Setup (Start Here!)

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

## ☁️ Option 2: AWS EKS Setup

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

## 🧹 Cleanup

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

- ✅ Set up local Kubernetes with Minikube
- ✅ Deploy real cluster on AWS EKS
- ✅ Basic cluster management
- ✅ Deploy and test applications

## 🚀 Next Step

Ready to learn about Pods and Services? Go to **[7.3 - Pods & Services](../7.3_pods_services/)**

---

*Start simple, scale up!* 🏗️
