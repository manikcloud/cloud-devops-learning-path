# 🧪 Hands-On Exercises - Deploy & Scale

## 📋 Prerequisites
```bash
# Clone the repository
git clone https://github.com/manikcloud/cloud-devops-learning-path.git
cd cloud-devops-learning-path/Section-2-DevOps/Session-7_Kubernetes/7.4_deploy_scale
```

## 🎯 Use Case: E-commerce Platform Scaling

**Scenario**: Your e-commerce platform is experiencing varying traffic loads. During sales events, traffic increases 5x. You need to implement auto-scaling and zero-downtime deployments.

### Exercise 1: Deploy and Scale E-commerce Frontend
```bash
# Deploy the e-commerce frontend
kubectl apply -f ecommerce-deployment.yaml

# Check initial deployment
kubectl get deployments
kubectl get pods
kubectl get services

# Test the application
curl http://localhost:30090

# Scale up for high traffic (Black Friday sale!)
kubectl scale deployment ecommerce-frontend --replicas=8

# Watch pods being created
kubectl get pods -w
# Press Ctrl+C to stop watching

# Check the scaled deployment
kubectl get deployments
kubectl get pods

# Scale down after sale
kubectl scale deployment ecommerce-frontend --replicas=2

# Verify scaling down
kubectl get pods
```

### Exercise 2: Rolling Update (New Feature Release)
```bash
# Check current image version
kubectl describe deployment ecommerce-frontend | grep Image

# Update to new version (simulate new feature)
kubectl set image deployment/ecommerce-frontend frontend=nginx:1.22

# Watch the rolling update
kubectl rollout status deployment/ecommerce-frontend

# Check rollout history
kubectl rollout history deployment/ecommerce-frontend

# Test the updated application
curl http://localhost:30090

# Simulate a problem - rollback!
kubectl rollout undo deployment/ecommerce-frontend

# Verify rollback
kubectl rollout status deployment/ecommerce-frontend
kubectl describe deployment ecommerce-frontend | grep Image
```

### Exercise 3: Blue-Green Deployment
```bash
# Deploy both blue and green versions
kubectl apply -f blue-green-deployment.yaml

# Check both deployments are running
kubectl get deployments
kubectl get pods -l app=myapp

# Test current version (blue)
curl http://localhost:30100

# Switch traffic to green version
kubectl patch service app-service -p '{"spec":{"selector":{"version":"green"}}}'

# Test new version (green)
curl http://localhost:30100

# If green version has issues, quickly switch back to blue
kubectl patch service app-service -p '{"spec":{"selector":{"version":"blue"}}}'

# Clean up old version after successful deployment
kubectl delete deployment app-blue
```

### Exercise 4: Health Checks and Self-Healing
```bash
# Check health probe configuration
kubectl describe deployment ecommerce-frontend

# Simulate pod failure
kubectl get pods
kubectl delete pod <pick-one-pod-name>

# Watch Kubernetes recreate the pod
kubectl get pods -w
# Press Ctrl+C to stop watching

# Check deployment status
kubectl get deployments
```

## 🎯 Real-World Application
- **E-commerce Scaling**: Handle traffic spikes during sales
- **Feature Releases**: Deploy new features without downtime
- **Disaster Recovery**: Quick rollback when issues occur
- **High Availability**: Self-healing applications

## ✅ Success Criteria
- [ ] Can scale applications up and down
- [ ] Rolling updates work without downtime
- [ ] Can rollback to previous versions
- [ ] Blue-green deployment switches traffic successfully
- [ ] Health checks ensure pod reliability
- [ ] Self-healing works when pods fail

## 🧹 Cleanup
```bash
kubectl delete -f blue-green-deployment.yaml
kubectl delete -f ecommerce-deployment.yaml
```
