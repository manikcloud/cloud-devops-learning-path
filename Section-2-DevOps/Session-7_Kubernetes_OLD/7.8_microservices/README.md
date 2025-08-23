# 🔬 7.7 Simple Microservices Project

<div align="center">

![Kubernetes](https://img.shields.io/badge/Kubernetes-Microservices-blue?style=for-the-badge&logo=kubernetes&logoColor=white)
![Project](https://img.shields.io/badge/Project-Simple-green?style=for-the-badge&logo=kubernetes&logoColor=white)

**🎯 Multi-Service App | 🌐 Service Communication | 📦 Complete Project**

</div>

---

## 🎯 What We'll Build

A simple e-commerce application with multiple services:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        🏪 SIMPLE E-COMMERCE APP                            │
└─────────────────────────────────────────────────────────────────────────────┘

    👨‍💻 User                    🌐 Frontend                   🔧 Backend
    ┌─────────┐                ┌─────────┐                ┌─────────┐
    │         │                │         │                │         │
    │ Browser │──────────────► │ Web UI  │──────────────► │ API     │
    │         │                │ (nginx) │                │ (nginx) │
    └─────────┘                └─────────┘                └─────────┘
                                                                │
                                                                │
                                                                ▼
                                                          ┌─────────┐
                                                          │         │
                                                          │Database │
                                                          │(postgres│
                                                          └─────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│  🎯 Result: Working Multi-Service App | 🌐 Service Discovery | 📈 Scalable  │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 🚀 Quick Deploy (2 Minutes!)

### **Super Easy Way**
```bash
# Navigate to the directory
cd /path/to/cloud-devops-learning-path/Section-2-DevOps/Session-7_Kubernetes/7.8_microservices

# Deploy everything at once
kubectl apply -f simple-ecommerce.yaml

# Wait for everything to start
kubectl get pods -w

# Access the application
# Frontend: http://localhost:30080
# Backend API: http://localhost:30081
```

---

## 📚 Step-by-Step Learning

### **Step 1: Deploy Database**
```bash
# Deploy PostgreSQL database
kubectl apply -f database.yaml

# Check database is running
kubectl get pods -l tier=database

# Check database logs
kubectl logs -l tier=database
```

### **Step 2: Deploy Backend API**
```bash
# Deploy backend service
kubectl apply -f backend.yaml

# Check backend is running
kubectl get pods -l tier=backend

# Test backend API
kubectl port-forward service/backend-service 8080:80 &
curl http://localhost:8080
```

### **Step 3: Deploy Frontend**
```bash
# Deploy frontend service
kubectl apply -f frontend.yaml

# Check frontend is running
kubectl get pods -l tier=frontend

# Access frontend
kubectl port-forward service/frontend-service 8081:80 &
# Open browser to http://localhost:8081
```

### **Step 4: Test Service Communication**
```bash
# Check all services can talk to each other
kubectl get services

# Test database connection from backend
kubectl exec -it $(kubectl get pod -l tier=backend -o jsonpath='{.items[0].metadata.name}') -- /bin/sh

# Inside the pod:
# nslookup database-service
# exit

# Test backend connection from frontend
kubectl exec -it $(kubectl get pod -l tier=frontend -o jsonpath='{.items[0].metadata.name}') -- /bin/sh

# Inside the pod:
# nslookup backend-service
# exit
```

---

## 🧪 Advanced Exercises

### **Exercise 1: Scale Individual Services**
```bash
# Scale frontend for more users
kubectl scale deployment frontend --replicas=3

# Scale backend for more API calls
kubectl scale deployment backend --replicas=2

# Database stays at 1 (typical pattern)
kubectl get pods
```

### **Exercise 2: Update Services Independently**
```bash
# Update frontend to new version
kubectl set image deployment/frontend nginx=nginx:1.21

# Update backend to new version
kubectl set image deployment/backend nginx=nginx:1.21

# Check rollout status
kubectl rollout status deployment/frontend
kubectl rollout status deployment/backend
```

### **Exercise 3: Test Service Discovery**
```bash
# Create a test pod to check connectivity
kubectl run test-pod --image=busybox --rm -it -- /bin/sh

# Inside the pod, test all services:
# nslookup frontend-service
# nslookup backend-service
# nslookup database-service

# Test HTTP connectivity:
# wget -qO- http://frontend-service
# wget -qO- http://backend-service
```

### **Exercise 4: Simulate Service Failure**
```bash
# Delete all backend pods
kubectl delete pods -l tier=backend

# Check what happens to frontend
curl http://localhost:30080

# Watch backend pods restart
kubectl get pods -l tier=backend -w

# Test again once backend is back
curl http://localhost:30080
```

---

## 📝 Key Concepts

### **Microservices Benefits**
- **Independent scaling** - Scale services based on demand
- **Independent updates** - Update services without affecting others
- **Technology diversity** - Use different technologies per service
- **Fault isolation** - One service failure doesn't kill everything

### **Service Communication**
- **DNS-based discovery** - Services find each other by name
- **Load balancing** - Traffic distributed across pod replicas
- **Health checks** - Kubernetes routes traffic only to healthy pods

### **Deployment Patterns**
- **Database first** - Stateful services start first
- **API second** - Business logic services
- **Frontend last** - User-facing services
- **Independent scaling** - Each service scales based on needs

---

## 🎯 Learning Outcomes

After completing this project, you will:

- ✅ **Deploy multi-service applications** on Kubernetes
- ✅ **Understand service communication** and discovery
- ✅ **Scale services independently** based on needs
- ✅ **Update services without downtime**
- ✅ **Troubleshoot service connectivity** issues
- ✅ **Apply microservices patterns** in practice

---

## ✅ Success Criteria
- [ ] All services deployed and running
- [ ] Services can communicate with each other
- [ ] Frontend accessible from browser
- [ ] Backend API responds to requests
- [ ] Database accepts connections
- [ ] Can scale services independently
- [ ] Can update services without affecting others

## 🚀 Next Steps

Congratulations! You've completed the Kubernetes learning path. You now know:

- ✅ Kubernetes architecture and concepts
- ✅ Pod management and networking
- ✅ Services and basic networking
- ✅ Deployments and scaling
- ✅ Updates and rollback strategies
- ✅ Multi-service application deployment

**Continue your journey with:**
- Advanced Kubernetes topics (Ingress, Persistent Volumes)
- Container security and best practices
- Kubernetes in production environments
- Service mesh technologies (Istio, Linkerd)

---

*You've built a complete microservices application on Kubernetes! 🎉*
