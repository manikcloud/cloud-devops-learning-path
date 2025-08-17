# 📦 7.3 Pods Management

<div align="center">

![Kubernetes](https://img.shields.io/badge/Kubernetes-Pods-blue?style=for-the-badge&logo=kubernetes&logoColor=white)
![Pods](https://img.shields.io/badge/Pods-Building%20Blocks-green?style=for-the-badge&logo=kubernetes&logoColor=white)

**🎯 Master Pod Fundamentals | 🔧 Hands-on Practice | 📋 Real-world Patterns**

</div>

---

## 📖 What are Pods?

**Pods** are the smallest deployable units in Kubernetes. Think of them as "wrappers" around your containers.

### **Key Concepts:**
- **One or more containers** - Usually just one
- **Shared network** - All containers share the same IP
- **Shared storage** - Volumes are shared between containers
- **Ephemeral** - Pods come and go, they're not permanent

---

## 🧪 Hands-On Exercises

### **Prerequisites**
```bash
# 1. Make sure you have a cluster running (from 7.1)
kubectl get nodes

# 2. Clone the repository
git clone https://github.com/manikcloud/cloud-devops-learning-path.git
cd cloud-devops-learning-path/Section-2-DevOps/Session-7_Kubernetes/7.3_pods_management

# 3. Verify cluster is working
kubectl cluster-info
```

### **🎯 Use Case: E-commerce Website Frontend**

**Scenario**: You're deploying the frontend of an e-commerce website. The frontend needs to be accessible internally by other services and externally by customers.

### **Exercise 1: Deploy Single Pod with Service**
```bash
# Deploy web server pod
kubectl apply -f web-pod.yaml

# Check pod status
kubectl get pods --show-labels

# Deploy services (ClusterIP and NodePort)
kubectl apply -f web-service.yaml

# Check services
kubectl get services

# Test internal access (ClusterIP)
kubectl run test-pod --image=busybox --rm -it -- wget -qO- http://web-service

# Test external access (NodePort)
curl http://localhost:30080
```

### **Exercise 2: Multi-Pod Load Balancing**
```bash
# Deploy multiple frontend pods
kubectl apply -f multi-pod-app.yaml

# Check all pods are running
kubectl get pods -l app=web

# Check service endpoints (should show 3 pods)
kubectl get endpoints frontend-service

# Test load balancing
kubectl run test-client --image=busybox --rm -it -- /bin/sh
# Inside the pod, run multiple times:
# wget -qO- http://frontend-service

# Check which pods are receiving traffic
kubectl logs frontend-1
kubectl logs frontend-2
kubectl logs frontend-3
```

### **Exercise 3: Service Discovery and DNS**
```bash
# Test DNS resolution
kubectl run dns-test --image=busybox --rm -it -- /bin/sh
# Inside the pod:
# nslookup frontend-service
# nslookup frontend-service.default.svc.cluster.local

# Test connectivity between services
kubectl exec -it frontend-1 -- curl http://frontend-service
```

### **Exercise 4: Labels and Selectors Practice**
```bash
# List pods with specific labels
kubectl get pods -l tier=frontend
kubectl get pods -l app=web,tier=frontend

# Add new label to a pod
kubectl label pod frontend-1 version=v1.0

# Update service selector to target specific version
kubectl patch service frontend-service -p '{"spec":{"selector":{"version":"v1.0"}}}'

# Check endpoints (should show only frontend-1)
kubectl get endpoints frontend-service

# Reset selector
kubectl patch service frontend-service -p '{"spec":{"selector":{"app":"web","tier":"frontend"}}}'
```

---

## 📝 Key Concepts

### **Pod Lifecycle**
- **Pending** - Pod is being scheduled
- **Running** - Pod is running on a node
- **Succeeded** - All containers have terminated successfully
- **Failed** - At least one container has failed
- **Unknown** - Pod state cannot be determined

### **Labels and Selectors**
- **Labels** - Key-value pairs for organization
- **Selectors** - Used by services to find pods
- **Flexible grouping** - Organize pods by environment, version, etc.

### **Networking**
- **Pod IP** - Each pod gets its own IP address
- **Container communication** - Containers in same pod use localhost
- **Service discovery** - Services provide stable endpoints

---

## 🎯 Learning Outcomes

After completing this module, you will:

- ✅ **Understand pod fundamentals** and lifecycle
- ✅ **Create and manage pods** using YAML files
- ✅ **Use labels and selectors** for organization
- ✅ **Connect pods with services** for networking
- ✅ **Troubleshoot pod issues** and debug problems
- ✅ **Apply real-world patterns** like load balancing

---

## ✅ Success Criteria
- [ ] Simple pod created and running
- [ ] Multiple pods deployed successfully
- [ ] Services can route traffic to pods
- [ ] Load balancing works across multiple pods
- [ ] Can filter pods using label selectors
- [ ] Understand pod networking and communication

## 🚀 Next Steps

Ready to manage pods at scale? Continue with:

**[7.4 - Deployments & Scaling →](../7.4_deployments_scaling/)**

Learn to manage pods using Deployments for production workloads.

---

*Master pods before moving to higher-level abstractions!* 📦
