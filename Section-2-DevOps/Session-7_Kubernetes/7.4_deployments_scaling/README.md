# 🚀 7.4 Deploy and Scale on Kube

## 🎯 Why Deployments?

**Problem**: Pods die, and you have to recreate them manually  
**Solution**: Deployments automatically manage pods for you!

### Deployment = Smart Pod Manager
- Keeps desired number of pods running
- Replaces failed pods automatically
- Handles updates smoothly
- Easy scaling up/down

---

## 📋 Your First Deployment

### Simple Deployment
```yaml
# nginx-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.20
        ports:
        - containerPort: 80
```

```bash
# Create deployment
kubectl apply -f nginx-deployment.yaml

# Check it
kubectl get deployments
kubectl get pods

# See the magic - delete a pod!
kubectl delete pod <pod-name>
kubectl get pods  # New pod appears!
```

---

## 📈 Scaling Made Easy

### Manual Scaling
```bash
# Scale up to 5 replicas
kubectl scale deployment nginx-deployment --replicas=5

# Check it
kubectl get pods

# Scale down to 2
kubectl scale deployment nginx-deployment --replicas=2

# Watch it happen
kubectl get pods -w
```

### Scaling in YAML
```yaml
# Just change this number
spec:
  replicas: 10  # Was 3, now 10!
```

```bash
# Apply the change
kubectl apply -f nginx-deployment.yaml
```

---

## 🔄 Rolling Updates (Zero Downtime!)

### Update Your App
```bash
# Update to new version
kubectl set image deployment/nginx-deployment nginx=nginx:1.21

# Watch the rollout
kubectl rollout status deployment/nginx-deployment

# Check rollout history
kubectl rollout history deployment/nginx-deployment
```

### Rollback if Something Goes Wrong
```bash
# Oops! Go back to previous version
kubectl rollout undo deployment/nginx-deployment

# Or go to specific version
kubectl rollout undo deployment/nginx-deployment --to-revision=1
```

---

## 🧪 Hands-On Practice

### Exercise 1: Blue-Green Deployment Simulation
```yaml
# blue-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: blue-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp
      version: blue
  template:
    metadata:
      labels:
        app: myapp
        version: blue
    spec:
      containers:
      - name: app
        image: nginx:1.20
        ports:
        - containerPort: 80
```

```bash
# Deploy blue version
kubectl apply -f blue-deployment.yaml

# Create service pointing to blue
kubectl expose deployment blue-app --port=80 --name=myapp-service

# Now deploy green version (change version: blue to green, image to nginx:1.21)
# Update service selector to point to green version
```

### Exercise 2: Resource Limits
```yaml
# deployment-with-limits.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: limited-app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: limited
  template:
    metadata:
      labels:
        app: limited
    spec:
      containers:
      - name: nginx
        image: nginx
        resources:
          requests:
            memory: "64Mi"
            cpu: "250m"
          limits:
            memory: "128Mi"
            cpu: "500m"
```

---

## 🔍 Monitoring Your Deployments

### Useful Commands
```bash
# Check deployment status
kubectl get deployments

# Detailed info
kubectl describe deployment nginx-deployment

# Check replica sets
kubectl get replicasets

# Pod status
kubectl get pods -l app=nginx

# Resource usage (if metrics-server installed)
kubectl top pods
```

### Health Checks
```yaml
# Add to your container spec
livenessProbe:
  httpGet:
    path: /
    port: 80
  initialDelaySeconds: 30
  periodSeconds: 10

readinessProbe:
  httpGet:
    path: /
    port: 80
  initialDelaySeconds: 5
  periodSeconds: 5
```

---

## 🛠️ Common Deployment Patterns

### 1. Simple Web App
```bash
# Create deployment
kubectl create deployment webapp --image=nginx --replicas=3

# Expose it
kubectl expose deployment webapp --port=80 --type=LoadBalancer

# Scale it
kubectl scale deployment webapp --replicas=5
```

### 2. Database (Single Instance)
```bash
# Database should have only 1 replica
kubectl create deployment mysql --image=mysql:8.0 --replicas=1

# Add environment variable
kubectl set env deployment/mysql MYSQL_ROOT_PASSWORD=password
```

### 3. Microservice
```bash
# Create multiple services
kubectl create deployment user-service --image=myapp/users --replicas=3
kubectl create deployment order-service --image=myapp/orders --replicas=2
kubectl create deployment payment-service --image=myapp/payments --replicas=2

# Expose them
kubectl expose deployment user-service --port=8080
kubectl expose deployment order-service --port=8081
kubectl expose deployment payment-service --port=8082
```

---

## 🧹 Cleanup Commands

```bash
# Delete deployment (and its pods)
kubectl delete deployment nginx-deployment

# Delete service
kubectl delete service nginx-service

# Delete everything with label
kubectl delete all -l app=nginx

# Delete everything in namespace
kubectl delete all --all
```

---

## 🎯 What You Learned

- ✅ Deployments manage pods automatically
- ✅ Easy scaling with replicas
- ✅ Rolling updates for zero downtime
- ✅ Rollback when things go wrong
- ✅ Resource limits and health checks
- ✅ Common deployment patterns

## 🚀 Next Step

Ready to learn about DNS and service discovery? Go to **[7.5 - DNS & Service Discovery](../7.5_dns_discovery/)**

---

*Deploy once, scale forever!* 🚀📈
