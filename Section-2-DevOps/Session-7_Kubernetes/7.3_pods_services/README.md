# 📦 7.3 Kubernetes Architecture, Pods, Services

## 🎯 Simple Concepts

### Pod = Container + Helper Stuff
### Service = Stable Address for Pods

---

## 📦 Understanding Pods

A **Pod** is like a house for your containers:
- Usually 1 container per pod
- Containers in same pod share network and storage
- Pods can die and restart (they're temporary!)

### Create Your First Pod

```yaml
# my-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-web-pod
  labels:
    app: web
spec:
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 80
```

```bash
# Create the pod
kubectl apply -f my-pod.yaml

# Check it
kubectl get pods

# See details
kubectl describe pod my-web-pod

# Delete it
kubectl delete -f my-pod.yaml
```

---

## 🌐 Understanding Services

A **Service** gives your pods a permanent address:
- Pods come and go, Services stay
- Load balances between multiple pods
- Different types for different needs

### Service Types (Simple!)

1. **ClusterIP** - Only inside cluster (default)
2. **NodePort** - Accessible from outside on specific port
3. **LoadBalancer** - Cloud load balancer (AWS/GCP/Azure)

---

## 🧪 Hands-On Practice

### Exercise 1: Pod + ClusterIP Service

```yaml
# web-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: web-pod
  labels:
    app: web
spec:
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 80
---
# web-service.yaml
apiVersion: v1
kind: Service
metadata:
  name: web-service
spec:
  selector:
    app: web
  ports:
  - port: 80
    targetPort: 80
  type: ClusterIP
```

```bash
# Apply both
kubectl apply -f web-pod.yaml

# Check service
kubectl get services

# Test from inside cluster
kubectl run test --image=busybox --rm -it -- wget -qO- web-service
```

### Exercise 2: NodePort Service (External Access)

```yaml
# nodeport-service.yaml
apiVersion: v1
kind: Service
metadata:
  name: web-nodeport
spec:
  selector:
    app: web
  ports:
  - port: 80
    targetPort: 80
    nodePort: 30080
  type: NodePort
```

```bash
# Apply it
kubectl apply -f nodeport-service.yaml

# Check it
kubectl get services

# Access it (Minikube)
minikube service web-nodeport --url

# Access it (EKS - use node IP:30080)
kubectl get nodes -o wide
```

---

## 🏷️ Labels and Selectors (Super Important!)

Labels are like **name tags** for your resources:

```yaml
# Pod with labels
metadata:
  name: my-pod
  labels:
    app: web
    version: v1
    environment: dev
```

Services use **selectors** to find pods:

```yaml
# Service selector
spec:
  selector:
    app: web  # Finds pods with label app=web
```

### Label Commands
```bash
# Show labels
kubectl get pods --show-labels

# Filter by label
kubectl get pods -l app=web

# Add label
kubectl label pod my-pod version=v2

# Remove label
kubectl label pod my-pod version-
```

---

## 🔍 Troubleshooting Tips

### Pod Issues
```bash
# Pod not starting?
kubectl describe pod <pod-name>
kubectl logs <pod-name>

# Get into pod
kubectl exec -it <pod-name> -- /bin/bash
```

### Service Issues
```bash
# Service not working?
kubectl get endpoints <service-name>
kubectl describe service <service-name>

# Test connectivity
kubectl port-forward service/<service-name> 8080:80
```

---

## 🧪 Quick Practice

### Multi-Pod Service
```bash
# Create 3 pods with same label
kubectl run web1 --image=nginx --labels="app=web"
kubectl run web2 --image=nginx --labels="app=web"
kubectl run web3 --image=nginx --labels="app=web"

# Create service for all 3
kubectl expose pod web1 --port=80 --name=multi-web --selector="app=web"

# Check endpoints (should show 3)
kubectl get endpoints multi-web

# Cleanup
kubectl delete pods web1 web2 web3
kubectl delete service multi-web
```

---

## 🎯 What You Learned

- ✅ Pods are containers with extras
- ✅ Services give stable addresses
- ✅ Labels connect services to pods
- ✅ Different service types for different needs
- ✅ Basic troubleshooting

## 🚀 Next Step

Ready to learn deployments and scaling? Go to **[7.4 - Deploy and Scale](../7.4_deploy_scale/)**

---

*Pods come and go, Services stay!* 📦🌐
