# 🧪 Hands-On Exercises - DNS & Service Discovery

## 📋 Prerequisites
```bash
# Clone the repository
git clone https://github.com/manikcloud/cloud-devops-learning-path.git
cd cloud-devops-learning-path/Section-2-DevOps/Session-7_Kubernetes/7.5_dns_discovery
```

## 🎯 Use Case: Microservices E-commerce Platform

**Scenario**: You're building an e-commerce platform with microservices architecture. The frontend needs to communicate with API services, and API services need to connect to the database. All services must discover each other automatically.

### Exercise 1: Deploy Microservices Application
```bash
# Deploy all microservices
kubectl apply -f microservices-app.yaml

# Check all services are running
kubectl get deployments
kubectl get services
kubectl get pods

# Wait for all pods to be ready
kubectl wait --for=condition=ready pod --all --timeout=300s
```

### Exercise 2: Test Service Discovery
```bash
# Test DNS resolution from frontend to API
kubectl exec -it deployment/frontend -- /bin/sh
# Inside the pod:
# nslookup api-service
# nslookup database-service
# exit

# Test connectivity between services
kubectl exec -it deployment/frontend -- curl http://api-service:8080
kubectl exec -it deployment/api -- curl http://database-service:3306 || echo "Connection attempt made"

# Test full DNS names
kubectl run dns-test --image=busybox --rm -it -- /bin/sh
# Inside the pod:
# nslookup api-service.default.svc.cluster.local
# nslookup database-service.default.svc.cluster.local
```

### Exercise 3: Setup Ingress Controller
```bash
# Enable ingress (for k3s, it's already enabled)
# For Minikube: minikube addons enable ingress

# Deploy ingress configuration
kubectl apply -f ingress-setup.yaml

# Check ingress status
kubectl get ingress

# Wait for ingress to get an address
kubectl wait --for=condition=ready ingress ecommerce-ingress --timeout=300s

# Test ingress routing
curl http://localhost/          # Should reach frontend
curl http://localhost/api       # Should reach API service
curl http://localhost/health    # Should reach API health endpoint
```

### Exercise 4: Service Communication Patterns
```bash
# Create a client pod to test service communication
kubectl run client --image=busybox --rm -it -- /bin/sh

# Inside the client pod, test different communication patterns:
# 1. Service name only
# wget -qO- http://frontend-service

# 2. Service with port
# wget -qO- http://api-service:8080

# 3. Full DNS name
# wget -qO- http://frontend-service.default.svc.cluster.local

# 4. Cross-namespace (if you have other namespaces)
# wget -qO- http://service-name.namespace-name.svc.cluster.local
```

### Exercise 5: Load Balancing Verification
```bash
# Scale API service to see load balancing
kubectl scale deployment api --replicas=4

# Check endpoints
kubectl get endpoints api-service

# Test load balancing
kubectl run load-test --image=busybox --rm -it -- /bin/sh
# Inside the pod, run multiple requests:
# for i in $(seq 1 10); do wget -qO- http://api-service:8080; echo "Request $i completed"; done

# Check logs from different API pods
kubectl logs -l app=api --tail=5
```

## 🎯 Real-World Application
- **Microservices Architecture**: Services discovering each other automatically
- **API Gateway Pattern**: Single entry point routing to multiple services
- **Database Connectivity**: Secure internal database access
- **Load Balancing**: Distributing requests across service instances

## ✅ Success Criteria
- [ ] All microservices are deployed and running
- [ ] Services can resolve each other's DNS names
- [ ] Frontend can communicate with API service
- [ ] API service can connect to database
- [ ] Ingress routes external traffic correctly
- [ ] Load balancing works across multiple replicas

## 🧹 Cleanup
```bash
kubectl delete -f ingress-setup.yaml
kubectl delete -f microservices-app.yaml
```
