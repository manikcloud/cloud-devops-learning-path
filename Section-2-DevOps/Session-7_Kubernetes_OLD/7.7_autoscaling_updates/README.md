# 🚀 7.6 Updates & Simple Scaling

<div align="center">

![Kubernetes](https://img.shields.io/badge/Kubernetes-Updates-blue?style=for-the-badge&logo=kubernetes&logoColor=white)
![Scaling](https://img.shields.io/badge/Scaling-Simple-green?style=for-the-badge&logo=kubernetes&logoColor=white)

**🎯 Rolling Updates | 📈 Manual Scaling | 🔄 Simple Strategies**

</div>

---

## 🎯 What We'll Learn

**Problem**: How do you update apps without downtime?  
**Solution**: Rolling updates and simple scaling strategies

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        🔄 ROLLING UPDATE PROCESS                           │
└─────────────────────────────────────────────────────────────────────────────┘

    Step 1: Current State        Step 2: Start Update         Step 3: Complete
    ┌─────────────────┐         ┌─────────────────┐         ┌─────────────────┐
    │ 📦 Pod v1.0     │         │ 📦 Pod v1.0     │         │ 📦 Pod v2.0     │
    │ 📦 Pod v1.0     │   ───►  │ 📦 Pod v1.0     │   ───►  │ 📦 Pod v2.0     │
    │ 📦 Pod v1.0     │         │ 📦 Pod v2.0     │         │ 📦 Pod v2.0     │
    └─────────────────┘         └─────────────────┘         └─────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│  🎯 Result: Zero Downtime | 🔄 Gradual Update | 📈 Always Available         │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 🧪 Hands-On Exercises

### **Exercise 1: Manual Scaling**
```bash
# Create a deployment
kubectl create deployment web-app --image=nginx --replicas=2

# Check current pods
kubectl get pods

# Scale up to 5 replicas
kubectl scale deployment web-app --replicas=5

# Watch the scaling happen
kubectl get pods -w

# Scale down to 1 replica
kubectl scale deployment web-app --replicas=1

# Check final state
kubectl get pods
```

### **Exercise 2: Rolling Update**
```bash
# Create deployment with specific version
kubectl create deployment web-app --image=nginx:1.20

# Check current image
kubectl describe deployment web-app | grep Image

# Update to new version (rolling update)
kubectl set image deployment/web-app nginx=nginx:1.21

# Watch the rollout
kubectl rollout status deployment/web-app

# Check rollout history
kubectl rollout history deployment/web-app

# Check new image
kubectl describe deployment web-app | grep Image
```

### **Exercise 3: Rollback**
```bash
# Update to a "bad" version
kubectl set image deployment/web-app nginx=nginx:bad-version

# Check what happens
kubectl get pods
kubectl rollout status deployment/web-app

# Rollback to previous version
kubectl rollout undo deployment/web-app

# Check rollback status
kubectl rollout status deployment/web-app
kubectl get pods
```

### **Exercise 4: Blue-Green Update Strategy**
```bash
# Apply blue-green setup
kubectl apply -f blue-green-update.yaml

# Check both deployments
kubectl get deployments

# Check current service (should point to blue)
kubectl get service web-service -o wide

# Test current version
curl http://localhost:30080

# Switch to green version
kubectl patch service web-service -p '{"spec":{"selector":{"version":"green"}}}'

# Test new version
curl http://localhost:30080

# If there's a problem, switch back to blue
kubectl patch service web-service -p '{"spec":{"selector":{"version":"blue"}}}'

# Clean up
kubectl delete -f blue-green-update.yaml
```

### **Exercise 5: Simple Resource-Based Scaling**
```bash
# Create deployment with resource requests
kubectl apply -f resource-scaling-demo.yaml

# Check current resources
kubectl top pods

# Generate some load (simple way)
kubectl run load-generator --image=busybox --rm -it -- /bin/sh

# Inside the pod, generate load:
# while true; do wget -q --delete-after http://web-service; done

# In another terminal, manually scale based on what you see
kubectl scale deployment web-app --replicas=5

# Stop the load generator (Ctrl+C)
# Scale back down
kubectl scale deployment web-app --replicas=2

# Clean up
kubectl delete -f resource-scaling-demo.yaml
```

---

## 📝 Key Concepts

### **Rolling Updates**
- **Gradual replacement** of old pods with new ones
- **Zero downtime** during updates
- **Configurable speed** (how many pods to update at once)
- **Automatic rollback** if update fails

### **Scaling Strategies**
- **Manual scaling** - You decide when to scale
- **Resource-based** - Scale based on CPU/memory usage
- **Time-based** - Scale at specific times
- **Event-based** - Scale based on queue length, etc.

### **Update Strategies**
- **Rolling Update** - Gradual replacement (default)
- **Recreate** - Stop all, then start new (downtime)
- **Blue-Green** - Two identical environments
- **Canary** - Small percentage gets new version first

---

## 🎯 Learning Outcomes

After completing this module, you will:

- ✅ **Perform manual scaling** up and down
- ✅ **Execute rolling updates** with zero downtime
- ✅ **Rollback failed deployments** quickly
- ✅ **Implement blue-green deployments** for safe updates
- ✅ **Understand different update strategies**
- ✅ **Monitor resource usage** for scaling decisions

---

## ✅ Success Criteria
- [ ] Successfully scaled deployments manually
- [ ] Performed rolling update without downtime
- [ ] Rolled back a failed deployment
- [ ] Implemented blue-green deployment pattern
- [ ] Understand when to use different strategies
- [ ] Can monitor and make scaling decisions

## 🚀 Next Steps

Ready to build a complete application? Continue with:

**[7.7 - Simple Microservices →](../7.8_microservices/)**

Put everything together in a multi-service application.

---

*Update safely, scale smartly!* 🚀
