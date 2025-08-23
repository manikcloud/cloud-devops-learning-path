# 🏷️ 7.3 Namespaces & Simple Organization

<div align="center">

![Kubernetes](https://img.shields.io/badge/Kubernetes-Namespaces-blue?style=for-the-badge&logo=kubernetes&logoColor=white)
![Organization](https://img.shields.io/badge/Organization-Simple-green?style=for-the-badge&logo=kubernetes&logoColor=white)

**🎯 Simple Organization | 🏠 Resource Separation | 📋 Basic Management**

</div>

---

## 🎯 Think of Namespaces as Apartments

**Problem**: All your apps live in one big messy room  
**Solution**: Namespaces = Separate apartments for different teams/apps

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        🏢 KUBERNETES CLUSTER                               │
└─────────────────────────────────────────────────────────────────────────────┘

    🏠 default namespace          🏠 development namespace      🏠 production namespace
    ┌─────────────────┐          ┌─────────────────┐          ┌─────────────────┐
    │                 │          │                 │          │                 │
    │ 📦 Pod-A        │          │ 📦 Dev-Pod-1    │          │ 📦 Prod-Pod-1   │
    │ 📦 Pod-B        │          │ 📦 Dev-Pod-2    │          │ 📦 Prod-Pod-2   │
    │ 🌐 Service-1    │          │ 🌐 Dev-Service  │          │ 🌐 Prod-Service │
    │                 │          │                 │          │                 │
    └─────────────────┘          └─────────────────┘          └─────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│  🎯 Benefits: Organization | 🔒 Isolation | 📊 Simple Management            │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Why Use Namespaces?
- **Organize** resources by team/project/environment
- **Separate** development from production
- **Avoid naming conflicts** between teams
- **Simple resource management**

---

## 🏠 Working with Namespaces

### See Current Namespaces
```bash
# List all namespaces
kubectl get namespaces

# Or short form
kubectl get ns

# See what's in each namespace
kubectl get pods --all-namespaces
```

### Create Namespaces
```bash
# Create namespace
kubectl create namespace development
kubectl create namespace testing
kubectl create namespace production

# Verify they were created
kubectl get ns
```

### Use Namespaces
```bash
# Deploy to specific namespace
kubectl create deployment nginx --image=nginx -n development

# See pods in specific namespace
kubectl get pods -n development

# See all resources in namespace
kubectl get all -n development

# Set default namespace (so you don't have to type -n every time)
kubectl config set-context --current --namespace=development

# Verify current namespace
kubectl config view --minify | grep namespace
```

---

## 🧪 Hands-On Exercises

### **Exercise 1: Create Development Environment**
```bash
# Create development namespace
kubectl create namespace development

# Deploy a simple app to development
kubectl create deployment web-app --image=nginx -n development

# Create a service
kubectl expose deployment web-app --port=80 --type=NodePort -n development

# Check everything is in the right namespace
kubectl get all -n development
```

### **Exercise 2: Create Production Environment**
```bash
# Create production namespace
kubectl create namespace production

# Deploy same app to production (different namespace = no conflict)
kubectl create deployment web-app --image=nginx -n production

# Create service in production
kubectl expose deployment web-app --port=80 --type=NodePort -n production

# Compare both environments
kubectl get all -n development
kubectl get all -n production
```

### **Exercise 3: Using YAML for Better Organization**
```bash
# Apply the multi-tenant setup
kubectl apply -f multi-tenant-setup.yaml

# Check what was created
kubectl get ns
kubectl get all -n frontend
kubectl get all -n backend
kubectl get all -n database
```

### **Exercise 4: Resource Limits (Simple)**
```bash
# Apply simple resource quotas
kubectl apply -f resource-quotas.yaml

# Try to create more pods than allowed
kubectl create deployment test --image=nginx --replicas=10 -n development

# See what happens
kubectl get pods -n development
kubectl describe namespace development
```

---

## 📝 Key Concepts

### **Default Namespaces**
- **default** - Where things go if you don't specify
- **kube-system** - Kubernetes system components
- **kube-public** - Public resources (don't use this)
- **kube-node-lease** - Node heartbeat info (ignore this)

### **Naming Rules**
- Same name can exist in different namespaces
- `web-app` in `development` ≠ `web-app` in `production`
- Services can talk across namespaces using full names

### **Cross-Namespace Communication**
```bash
# Service in same namespace
curl http://web-service

# Service in different namespace
curl http://web-service.production.svc.cluster.local
```

---

## 🎯 Learning Outcomes

After completing this module, you will:

- ✅ **Understand namespace concepts** and why they're useful
- ✅ **Create and manage namespaces** for organization
- ✅ **Deploy applications** to specific namespaces
- ✅ **Switch between namespaces** efficiently
- ✅ **Understand basic resource separation**
- ✅ **Apply simple resource limits**

---

## ✅ Success Criteria
- [ ] Created multiple namespaces successfully
- [ ] Deployed applications to specific namespaces
- [ ] Can switch between namespaces easily
- [ ] Understand how services work across namespaces
- [ ] Applied basic resource quotas
- [ ] Can organize resources logically

## 🚀 Next Steps

Ready to manage applications at scale? Continue with:

**[7.4 - Deployments & Scaling →](../7.5_deployments_scaling/)**

Learn to manage multiple pods using Deployments.

---

*Organization first, complexity later!* 🏷️
