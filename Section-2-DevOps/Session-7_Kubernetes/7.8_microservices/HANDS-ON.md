# 🧪 Hands-On Exercises - Deploying Microservices

## 📋 Prerequisites
```bash
# Clone the repository
git clone https://github.com/manikcloud/cloud-devops-learning-path.git
cd cloud-devops-learning-path/Section-2-DevOps/Session-7_Kubernetes/7.8_microservices
```

## 🎯 Use Case: Complete E-commerce Platform

**Scenario**: You're deploying a production-ready e-commerce platform with microservices architecture. The platform includes user management, product catalog, order processing, and a frontend, all with auto-scaling and monitoring.

### Exercise 1: Deploy Complete Microservices Stack
```bash
# Deploy the entire microservices application
kubectl apply -f microservices-stack.yaml

# Check namespace creation
kubectl get namespaces

# Check all deployments
kubectl get deployments -n ecommerce

# Check all services
kubectl get services -n ecommerce

# Check all pods
kubectl get pods -n ecommerce

# Wait for all pods to be ready
kubectl wait --for=condition=ready pod --all -n ecommerce --timeout=300s
```

### Exercise 2: Test Service Communication
```bash
# Test database connectivity
kubectl exec -n ecommerce deployment/user-service -- nc -zv database-service 5432

# Test cache connectivity
kubectl exec -n ecommerce deployment/user-service -- nc -zv cache-service 6379

# Test inter-service communication
kubectl exec -n ecommerce deployment/order-service -- curl -s http://user-service:8080
kubectl exec -n ecommerce deployment/order-service -- curl -s http://product-service:8081

# Test DNS resolution
kubectl exec -n ecommerce deployment/frontend -- nslookup user-service
kubectl exec -n ecommerce deployment/frontend -- nslookup product-service
kubectl exec -n ecommerce deployment/frontend -- nslookup order-service
```

### Exercise 3: Test External Access via Ingress
```bash
# Check ingress status
kubectl get ingress -n ecommerce

# Test frontend access
curl http://localhost/

# Test API endpoints
curl http://localhost/api/users
curl http://localhost/api/products
curl http://localhost/api/orders

# Test load balancing (multiple requests)
for i in {1..10}; do
  echo "Request $i:"
  curl -s http://localhost/api/products | head -1
done
```

### Exercise 4: Deploy Auto-scaling
```bash
# Apply HPA configurations
kubectl apply -f hpa-config.yaml

# Check HPA status
kubectl get hpa -n ecommerce

# Describe HPA for detailed info
kubectl describe hpa user-service-hpa -n ecommerce
kubectl describe hpa product-service-hpa -n ecommerce
kubectl describe hpa order-service-hpa -n ecommerce
```

### Exercise 5: Deploy Monitoring
```bash
# Deploy monitoring dashboard
kubectl apply -f monitoring.yaml

# Check monitoring deployment
kubectl get deployments -n ecommerce monitoring-dashboard
kubectl get services -n ecommerce monitoring-service

# Access monitoring dashboard
curl http://localhost:30200
```

### Exercise 6: Scale Testing
```bash
# Manual scaling test
kubectl scale deployment product-service --replicas=5 -n ecommerce

# Check scaling
kubectl get pods -n ecommerce -l app=product-service

# Generate load to test auto-scaling
kubectl run load-generator -n ecommerce --image=busybox --rm -it -- /bin/sh
# Inside the pod:
# while true; do wget -q -O- http://product-service:8081; done

# In another terminal, watch HPA
kubectl get hpa -n ecommerce -w
```

### Exercise 7: Health and Status Monitoring
```bash
# Check overall application health
kubectl get all -n ecommerce

# Check pod logs
kubectl logs -n ecommerce deployment/user-service
kubectl logs -n ecommerce deployment/product-service
kubectl logs -n ecommerce deployment/order-service

# Check resource usage
kubectl top pods -n ecommerce 2>/dev/null || echo "Metrics server not available"

# Check events
kubectl get events -n ecommerce --sort-by=.metadata.creationTimestamp
```

### Exercise 8: Simulate Failure and Recovery
```bash
# Simulate database failure
kubectl scale deployment database --replicas=0 -n ecommerce

# Check application status
kubectl get pods -n ecommerce
curl http://localhost/api/users || echo "Service unavailable"

# Restore database
kubectl scale deployment database --replicas=1 -n ecommerce

# Wait for recovery
kubectl wait --for=condition=ready pod -l app=database -n ecommerce --timeout=120s

# Test recovery
curl http://localhost/api/users
```

### Exercise 9: Rolling Update Simulation
```bash
# Update user service
kubectl set image deployment/user-service user-service=nginx:1.22 -n ecommerce

# Watch rolling update
kubectl rollout status deployment/user-service -n ecommerce

# Test during update (should remain available)
while true; do
  curl -s http://localhost/api/users > /dev/null && echo "✅ Service available" || echo "❌ Service down"
  sleep 1
done
# Press Ctrl+C to stop

# Check rollout history
kubectl rollout history deployment/user-service -n ecommerce
```

### Exercise 10: Complete System Verification
```bash
# Final system check
echo "=== Deployments ==="
kubectl get deployments -n ecommerce

echo "=== Services ==="
kubectl get services -n ecommerce

echo "=== HPA Status ==="
kubectl get hpa -n ecommerce

echo "=== Ingress ==="
kubectl get ingress -n ecommerce

echo "=== Pod Health ==="
kubectl get pods -n ecommerce

# Test all endpoints
echo "=== Endpoint Testing ==="
curl -s http://localhost/ && echo "✅ Frontend OK"
curl -s http://localhost/api/users && echo "✅ User Service OK"
curl -s http://localhost/api/products && echo "✅ Product Service OK"
curl -s http://localhost/api/orders && echo "✅ Order Service OK"
curl -s http://localhost:30200 && echo "✅ Monitoring OK"
```

## 🎯 Real-World Application
- **E-commerce Platform**: Complete online shopping system
- **Microservices Architecture**: Scalable, maintainable service design
- **Production Deployment**: Real-world deployment patterns
- **Auto-scaling**: Handle varying traffic loads
- **Monitoring**: Observability and health checking

## ✅ Success Criteria
- [ ] All microservices deployed and running
- [ ] Services can communicate with each other
- [ ] External access works via Ingress
- [ ] Auto-scaling is configured and functional
- [ ] Monitoring dashboard is accessible
- [ ] System handles failures gracefully
- [ ] Rolling updates work without downtime
- [ ] All endpoints respond correctly

## 🏆 Congratulations!
You've successfully deployed a complete production-ready microservices application on Kubernetes! This demonstrates enterprise-level skills in:
- Container orchestration
- Microservices architecture
- Service discovery and communication
- Auto-scaling and load balancing
- Health monitoring and observability
- Production deployment strategies

## 🧹 Cleanup
```bash
# Delete the entire microservices application
kubectl delete -f monitoring.yaml
kubectl delete -f hpa-config.yaml
kubectl delete -f microservices-stack.yaml

# Verify cleanup
kubectl get namespaces | grep ecommerce || echo "Cleanup complete"
```
