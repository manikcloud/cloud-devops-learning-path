# 🧪 Hands-On Exercises - Pods & Services

## 📋 Prerequisites
```bash
# Clone the repository
git clone https://github.com/manikcloud/cloud-devops-learning-path.git
cd cloud-devops-learning-path/Section-2-DevOps/Session-7_Kubernetes/7.3_pods_services
```

## 🎯 Use Case: E-commerce Website Frontend

**Scenario**: You're deploying the frontend of an e-commerce website. The frontend needs to be accessible internally by other services and externally by customers.

### Exercise 1: Deploy Single Pod with Service
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

### Exercise 2: Multi-Pod Load Balancing
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

### Exercise 3: Service Discovery and DNS
```bash
# Test DNS resolution
kubectl run dns-test --image=busybox --rm -it -- /bin/sh
# Inside the pod:
# nslookup frontend-service
# nslookup frontend-service.default.svc.cluster.local

# Test connectivity between services
kubectl exec -it frontend-1 -- curl http://frontend-service
```

### Exercise 4: Labels and Selectors Practice
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

## 🎯 Real-World Application
- **E-commerce Frontend**: Customer-facing web application
- **Microservices Communication**: Internal service-to-service calls
- **Load Balancing**: Distributing traffic across multiple instances
- **Service Discovery**: Services finding each other automatically

## ✅ Success Criteria
- [ ] Pods are running and healthy
- [ ] Services can route traffic to pods
- [ ] Load balancing works across multiple pods
- [ ] DNS resolution works for service names
- [ ] Can modify traffic routing with labels
- [ ] External access works via NodePort

## 🧹 Cleanup
```bash
kubectl delete -f multi-pod-app.yaml
kubectl delete -f web-service.yaml
kubectl delete -f web-pod.yaml
```
