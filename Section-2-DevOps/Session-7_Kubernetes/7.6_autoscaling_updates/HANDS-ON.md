# 🧪 Hands-On Exercises - Auto-scaling & Updates

## 📋 Prerequisites
```bash
# Clone the repository
git clone https://github.com/manikcloud/cloud-devops-learning-path.git
cd cloud-devops-learning-path/Section-2-DevOps/Session-7_Kubernetes/7.6_autoscaling_updates
```

## 🎯 Use Case: Black Friday E-commerce Traffic

**Scenario**: Your e-commerce platform expects massive traffic during Black Friday. You need auto-scaling to handle the load and zero-downtime deployments for last-minute feature updates.

### Exercise 1: Deploy Application with HPA
```bash
# Deploy web application with HPA
kubectl apply -f hpa-demo.yaml

# Check initial state
kubectl get deployments
kubectl get hpa
kubectl get pods

# Test the application
curl http://localhost:30110
```

### Exercise 2: Test Auto-scaling
```bash
# Generate load to trigger scaling
kubectl apply -f load-generator.yaml

# Watch HPA in action (in separate terminal)
kubectl get hpa -w

# Watch pods scaling up
kubectl get pods -w

# Check HPA status
kubectl describe hpa web-app-hpa

# Stop load generation
kubectl delete -f load-generator.yaml

# Watch pods scaling down
kubectl get pods -w
```

### Exercise 3: Rolling Updates (Zero Downtime)
```bash
# Deploy application for rolling update demo
kubectl apply -f rolling-update-demo.yaml

# Check initial deployment
kubectl get deployments
kubectl get pods

# Test application availability
curl http://localhost:30120

# Perform rolling update
kubectl set image deployment/rolling-app app=nginx:1.21

# Watch rolling update in real-time
kubectl rollout status deployment/rolling-app

# Test application during update (should always work)
while true; do curl -s http://localhost:30120 > /dev/null && echo "✅ App accessible" || echo "❌ App down"; sleep 1; done
# Press Ctrl+C to stop

# Check rollout history
kubectl rollout history deployment/rolling-app
```

### Exercise 4: Rollback Strategy
```bash
# Simulate problematic update
kubectl set image deployment/rolling-app app=nginx:broken-tag

# Watch the failed rollout
kubectl rollout status deployment/rolling-app

# Check pod status (some will fail)
kubectl get pods

# Quick rollback to previous version
kubectl rollout undo deployment/rolling-app

# Verify rollback success
kubectl rollout status deployment/rolling-app
kubectl get pods

# Test application works again
curl http://localhost:30120
```

### Exercise 5: Advanced Update Strategies
```bash
# Check current update strategy
kubectl describe deployment rolling-app | grep -A 5 "RollingUpdateStrategy"

# Modify update strategy for faster rollouts
kubectl patch deployment rolling-app -p '{"spec":{"strategy":{"rollingUpdate":{"maxSurge":"50%","maxUnavailable":"25%"}}}}'

# Perform another update to see faster rollout
kubectl set image deployment/rolling-app app=nginx:1.22

# Watch the faster rollout
kubectl rollout status deployment/rolling-app

# Check final state
kubectl get pods
kubectl describe deployment rolling-app
```

### Exercise 6: Health Checks During Updates
```bash
# Check health probe configuration
kubectl describe deployment rolling-app | grep -A 10 "Liveness\|Readiness"

# Simulate unhealthy pods during update
kubectl set image deployment/rolling-app app=nginx:1.23

# Watch how health checks prevent bad deployments
kubectl get pods -w

# Check events for health check failures
kubectl get events --sort-by=.metadata.creationTimestamp
```

## 🎯 Real-World Application
- **Black Friday Traffic**: Auto-scaling for traffic spikes
- **Feature Releases**: Zero-downtime deployments
- **Emergency Rollbacks**: Quick recovery from bad deployments
- **Performance Optimization**: Efficient resource utilization

## ✅ Success Criteria
- [ ] HPA scales pods based on CPU usage
- [ ] Application handles load increases automatically
- [ ] Rolling updates complete without downtime
- [ ] Can rollback quickly when issues occur
- [ ] Health checks prevent bad deployments
- [ ] Update strategies can be customized

## 🧹 Cleanup
```bash
kubectl delete -f load-generator.yaml 2>/dev/null || true
kubectl delete -f rolling-update-demo.yaml
kubectl delete -f hpa-demo.yaml
```
