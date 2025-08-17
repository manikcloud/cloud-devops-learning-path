# 🧪 Hands-On Exercises - Namespaces & Quotas

## 📋 Prerequisites
```bash
# Clone the repository
git clone https://github.com/manikcloud/cloud-devops-learning-path.git
cd cloud-devops-learning-path/Section-2-DevOps/Session-7_Kubernetes/7.7_namespaces_quotas
```

## 🎯 Use Case: Multi-Tenant SaaS Platform

**Scenario**: You're managing a SaaS platform with multiple teams and environments. Each team needs isolated resources with specific limits to prevent one team from consuming all cluster resources.

### Exercise 1: Create Multi-Tenant Environment
```bash
# Create namespaces for different environments and teams
kubectl apply -f multi-tenant-setup.yaml

# List all namespaces
kubectl get namespaces --show-labels

# Check namespace details
kubectl describe namespace development
kubectl describe namespace team-alpha
```

### Exercise 2: Apply Resource Quotas
```bash
# Apply resource quotas to all namespaces
kubectl apply -f resource-quotas.yaml

# Check quota status for each namespace
kubectl describe quota -n development
kubectl describe quota -n staging
kubectl describe quota -n production
kubectl describe quota -n team-alpha
kubectl describe quota -n team-beta

# List all quotas across namespaces
kubectl get quota --all-namespaces
```

### Exercise 3: Deploy Applications to Different Namespaces
```bash
# Deploy applications to each namespace
kubectl apply -f sample-apps.yaml

# Check deployments in each namespace
kubectl get deployments -n development
kubectl get deployments -n staging
kubectl get deployments -n production
kubectl get deployments -n team-alpha
kubectl get deployments -n team-beta

# Check resource usage against quotas
kubectl describe quota -n development
kubectl describe quota -n team-alpha
kubectl describe quota -n team-beta
```

### Exercise 4: Test Resource Limits
```bash
# Try to exceed quota in team-beta (should fail)
kubectl create deployment quota-test --image=nginx --replicas=10 -n team-beta

# Check what happened
kubectl get deployments -n team-beta
kubectl describe deployment quota-test -n team-beta

# Check quota status
kubectl describe quota -n team-beta

# Scale within limits
kubectl scale deployment beta-app --replicas=4 -n team-beta

# Try to scale beyond limits (should be restricted)
kubectl scale deployment beta-app --replicas=6 -n team-beta
```

### Exercise 5: Namespace Isolation Testing
```bash
# Set context to work in development namespace
kubectl config set-context --current --namespace=development

# List pods (should only show development pods)
kubectl get pods

# Try to access pods in other namespaces
kubectl get pods -n team-alpha
kubectl get pods --all-namespaces

# Reset to default namespace
kubectl config set-context --current --namespace=default
```

### Exercise 6: Cross-Namespace Communication
```bash
# Create a test pod in development
kubectl run test-pod --image=busybox -n development --rm -it -- /bin/sh

# Inside the pod, test DNS resolution:
# nslookup dev-app.development.svc.cluster.local
# nslookup alpha-app.team-alpha.svc.cluster.local

# Test connectivity (should work)
# wget -qO- http://dev-app.development.svc.cluster.local
# wget -qO- http://alpha-app.team-alpha.svc.cluster.local
```

### Exercise 7: Resource Monitoring
```bash
# Check resource usage across namespaces
kubectl top pods --all-namespaces 2>/dev/null || echo "Metrics server not available"

# Check quota usage summary
echo "=== Development Quota ==="
kubectl describe quota -n development | grep -A 10 "Resource\|Used"

echo "=== Team Alpha Quota ==="
kubectl describe quota -n team-alpha | grep -A 10 "Resource\|Used"

echo "=== Team Beta Quota ==="
kubectl describe quota -n team-beta | grep -A 10 "Resource\|Used"

# List all resources by namespace
kubectl get all -n development
kubectl get all -n team-alpha
kubectl get all -n team-beta
```

### Exercise 8: Cleanup and Resource Management
```bash
# Delete specific deployment to free up quota
kubectl delete deployment quota-test -n team-beta 2>/dev/null || echo "Deployment not found"

# Check updated quota
kubectl describe quota -n team-beta

# Scale down to free resources
kubectl scale deployment beta-app --replicas=1 -n team-beta

# Verify resource availability
kubectl describe quota -n team-beta
```

## 🎯 Real-World Application
- **SaaS Multi-Tenancy**: Isolating customer workloads
- **Team Resource Management**: Preventing resource conflicts
- **Environment Separation**: Dev/Staging/Prod isolation
- **Cost Control**: Limiting resource consumption per team

## ✅ Success Criteria
- [ ] Multiple namespaces created successfully
- [ ] Resource quotas applied and enforced
- [ ] Applications deployed to correct namespaces
- [ ] Quota limits prevent resource overconsumption
- [ ] Cross-namespace communication works
- [ ] Resource usage can be monitored per namespace
- [ ] Teams are isolated from each other

## 🧹 Cleanup
```bash
# Delete all sample applications
kubectl delete -f sample-apps.yaml

# Delete resource quotas
kubectl delete -f resource-quotas.yaml

# Delete namespaces (this will delete everything inside)
kubectl delete -f multi-tenant-setup.yaml

# Verify cleanup
kubectl get namespaces
```
