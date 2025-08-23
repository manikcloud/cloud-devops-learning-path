# 🌐 7.5 Services & Basic Networking

<div align="center">

![Kubernetes](https://img.shields.io/badge/Kubernetes-Services-blue?style=for-the-badge&logo=kubernetes&logoColor=white)
![Networking](https://img.shields.io/badge/Networking-Simple-green?style=for-the-badge&logo=kubernetes&logoColor=white)

**🎯 Connect Your Apps | 🌍 Simple Access | 🔗 Basic Networking**

</div>

---

## 🎯 What are Services?

**Problem**: Pods come and go, their IP addresses change  
**Solution**: Services provide stable endpoints to reach your pods

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        🌐 KUBERNETES SERVICES                              │
└─────────────────────────────────────────────────────────────────────────────┘

    👨‍💻 User                    🌐 Service                    📦 Pods
    ┌─────────┐                ┌─────────┐                ┌─────────┐
    │         │                │         │                │ Pod-1   │
    │ Browser │──────────────► │ Stable  │──────────────► │ IP: X.X │
    │         │                │ IP      │       │        │         │
    └─────────┘                │ Port    │       │        └─────────┘
                               └─────────┘       │        ┌─────────┐
                                                 │        │ Pod-2   │
                                                 └──────► │ IP: Y.Y │
                                                          │         │
                                                          └─────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│  🎯 Result: Stable Access | 🔄 Load Balancing | 📈 High Availability        │
└─────────────────────────────────────────────────────────────────────────────┘
```

### **Service Types (Simple)**
- **ClusterIP** - Internal access only (default)
- **NodePort** - External access via node IP:port
- **LoadBalancer** - Cloud load balancer (if available)

---

## 🧪 Hands-On Exercises

### **Prerequisites**
```bash
# Make sure your cluster is running
kubectl get nodes

# Navigate to the directory
cd /path/to/cloud-devops-learning-path/Section-2-DevOps/Session-7_Kubernetes/7.6_services_networking
```

### **Exercise 1: ClusterIP Service (Internal Access)**
```bash
# Create a deployment
kubectl create deployment web-app --image=nginx --replicas=3

# Create ClusterIP service (internal only)
kubectl expose deployment web-app --port=80 --type=ClusterIP

# Check the service
kubectl get services

# Test internal access
kubectl run test-pod --image=busybox --rm -it -- wget -qO- http://web-app

# Clean up
kubectl delete deployment web-app
kubectl delete service web-app
```

### **Exercise 2: NodePort Service (External Access)**
```bash
# Create deployment
kubectl create deployment web-app --image=nginx --replicas=3

# Create NodePort service (external access)
kubectl expose deployment web-app --port=80 --type=NodePort

# Check the service and note the NodePort
kubectl get services

# Access from your browser (if port is 30123):
# http://localhost:30123

# Clean up
kubectl delete deployment web-app
kubectl delete service web-app
```

### **Exercise 3: Blue-Green with Services**
```bash
# Deploy blue version
kubectl apply -f blue-green-demo.yaml

# Check both deployments
kubectl get deployments

# Check the service (points to blue initially)
kubectl get service web-service -o wide

# Test the blue version
curl http://localhost:30080

# Switch to green version
kubectl patch service web-service -p '{"spec":{"selector":{"version":"green"}}}'

# Test the green version
curl http://localhost:30080

# Clean up
kubectl delete -f blue-green-demo.yaml
```

### **Exercise 4: Service Discovery**
```bash
# Create two services
kubectl create deployment frontend --image=nginx
kubectl create deployment backend --image=nginx

kubectl expose deployment frontend --port=80
kubectl expose deployment backend --port=80

# Test service discovery
kubectl run test-pod --image=busybox --rm -it -- /bin/sh

# Inside the pod:
# nslookup frontend
# nslookup backend
# wget -qO- http://frontend
# wget -qO- http://backend

# Clean up
kubectl delete deployment frontend backend
kubectl delete service frontend backend
```

---

## 📝 Key Concepts

### **Service Discovery**
- Services get DNS names automatically
- Format: `service-name.namespace.svc.cluster.local`
- Short form: `service-name` (same namespace)

### **Load Balancing**
- Services automatically load balance between pods
- Uses round-robin by default
- Healthy pods only receive traffic

### **Port Mapping**
- **port**: Service port (what clients connect to)
- **targetPort**: Pod port (where traffic goes)
- **nodePort**: External port (for NodePort services)

---

## 🎯 Learning Outcomes

After completing this module, you will:

- ✅ **Understand service concepts** and why they're needed
- ✅ **Create ClusterIP services** for internal communication
- ✅ **Create NodePort services** for external access
- ✅ **Use service discovery** for app communication
- ✅ **Implement simple load balancing**
- ✅ **Switch traffic between versions**

---

## ✅ Success Criteria
- [ ] Created ClusterIP service successfully
- [ ] Created NodePort service and accessed externally
- [ ] Demonstrated service discovery between apps
- [ ] Implemented blue-green traffic switching
- [ ] Understand basic load balancing
- [ ] Can troubleshoot service connectivity

## 🚀 Next Steps

Ready to learn about updates and scaling? Continue with:

**[7.6 - Updates & Simple Scaling →](../7.7_autoscaling_updates/)**

Learn rolling updates and basic auto-scaling.

---

*Connect first, optimize later!* 🌐
