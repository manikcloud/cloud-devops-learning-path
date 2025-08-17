# 🧪 Hands-On Exercises - Kubernetes Basics

## 📋 Prerequisites
```bash
# Clone the repository
git clone https://github.com/manikcloud/cloud-devops-learning-path.git
cd cloud-devops-learning-path/Section-2-DevOps/Session-7_Kubernetes/7.1_kubernetes_basics
```

## 🎯 Use Case: Deploy Your First Web Server

**Scenario**: You're a new DevOps engineer tasked with deploying a simple web server for the development team to test their applications.

### Exercise 1: Create Your First Pod
```bash
# Apply the pod configuration
kubectl apply -f exercise-1-first-pod.yaml

# Check if pod is running
kubectl get pods

# See detailed information
kubectl describe pod my-first-pod

# Check pod logs
kubectl logs my-first-pod

# Access the pod (port forwarding)
kubectl port-forward pod/my-first-pod 8080:80

# Test in another terminal
curl http://localhost:8080

# Clean up
kubectl delete -f exercise-1-first-pod.yaml
```

### Exercise 2: Troubleshoot a Broken Pod
```bash
# Try to create a pod with wrong image
kubectl run broken-pod --image=nginx:wrong-tag

# Check what happened
kubectl get pods
kubectl describe pod broken-pod

# Fix it
kubectl delete pod broken-pod
kubectl run fixed-pod --image=nginx:1.21

# Verify it works
kubectl get pods
kubectl logs fixed-pod
```

## 🎯 Real-World Application
- **Development Environment**: Quick container deployment for testing
- **Learning Platform**: Understanding pod lifecycle and troubleshooting
- **Foundation Skills**: Building blocks for complex applications

## ✅ Success Criteria
- [ ] Pod created successfully
- [ ] Pod shows "Running" status
- [ ] Can access web server via port-forward
- [ ] Can troubleshoot and fix issues
- [ ] Clean up resources properly
