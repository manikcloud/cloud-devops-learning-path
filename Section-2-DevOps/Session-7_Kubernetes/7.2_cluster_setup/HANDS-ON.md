# 🧪 Hands-On Exercises - Cluster Setup

## 📋 Prerequisites
```bash
# Clone the repository
git clone https://github.com/manikcloud/cloud-devops-learning-path.git
cd cloud-devops-learning-path/Section-2-DevOps/Session-7_Kubernetes/7.2_cluster_setup
```

## 🎯 Use Case: Setup Development Kubernetes Environment

**Scenario**: Your team needs a local Kubernetes environment for developing and testing microservices before deploying to production.

### Exercise 1: Quick k3s Setup
```bash
# Make script executable and run
chmod +x k3s-setup.sh
./k3s-setup.sh

# Verify cluster is ready
kubectl cluster-info
kubectl get nodes -o wide
```

### Exercise 2: Deploy Test Application
```bash
# Deploy test web application
kubectl apply -f test-deployment.yaml

# Check deployment status
kubectl get deployments
kubectl get pods
kubectl get services

# Test the application
curl http://localhost:30080

# Scale the application
kubectl scale deployment test-web-app --replicas=4
kubectl get pods

# Clean up
kubectl delete -f test-deployment.yaml
```

### Exercise 3: Cluster Health Check
```bash
# Check all system components
kubectl get pods -n kube-system

# Check cluster resources
kubectl top nodes 2>/dev/null || echo "Metrics server not available"

# Test DNS resolution
kubectl run test-dns --image=busybox --rm -it -- nslookup kubernetes
```

## 🎯 Real-World Application
- **Development Environment**: Local testing before cloud deployment
- **CI/CD Pipeline**: Automated testing in isolated environments
- **Learning Platform**: Safe environment to experiment with Kubernetes
- **Proof of Concept**: Quick setup for demonstrating applications

## ✅ Success Criteria
- [ ] Cluster is running and accessible
- [ ] Can deploy applications successfully
- [ ] Services are accessible via NodePort
- [ ] Can scale applications up and down
- [ ] All system pods are healthy
