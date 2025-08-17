# 🔬 7.8 Deploying Microservices on Kubernetes

## 🎯 Final Project: Complete Microservices App

**Goal**: Deploy a real microservices application with:
- Frontend (React/Angular)
- Backend API (Node.js/Python/Java)
- Database (PostgreSQL/MySQL)
- Cache (Redis)
- Monitoring (Basic)

---

## 🏗️ Simple Microservices Architecture

```
┌─────────────────────────────────────────┐
│        🔬 MICROSERVICES APP             │
│                                         │
│  🌐 Frontend (React)                    │
│  │                                      │
│  ▼                                      │
│  🎯 API Gateway (NGINX)                 │
│  │                                      │
│  ├─► 👤 User Service (Node.js)          │
│  ├─► 📦 Product Service (Python)        │
│  └─► 🛒 Order Service (Java)            │
│       │                                 │
│       ▼                                 │
│  💾 Database (PostgreSQL)               │
│  🔴 Cache (Redis)                       │
└─────────────────────────────────────────┘
```

---

## 🚀 Step 1: Create Namespace and Setup

```bash
# Create namespace for our app
kubectl create namespace microservices

# Set as default
kubectl config set-context --current --namespace=microservices

# Create resource quota
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ResourceQuota
metadata:
  name: microservices-quota
  namespace: microservices
spec:
  hard:
    requests.cpu: "4"
    requests.memory: 8Gi
    limits.cpu: "8"
    limits.memory: 16Gi
    pods: "20"
    services: "10"
EOF
```

---

## 💾 Step 2: Deploy Database Layer

### PostgreSQL Database
```yaml
# database.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: postgres
  labels:
    app: postgres
spec:
  replicas: 1
  selector:
    matchLabels:
      app: postgres
  template:
    metadata:
      labels:
        app: postgres
    spec:
      containers:
      - name: postgres
        image: postgres:13
        env:
        - name: POSTGRES_DB
          value: "microservices"
        - name: POSTGRES_USER
          value: "admin"
        - name: POSTGRES_PASSWORD
          value: "password123"
        ports:
        - containerPort: 5432
        resources:
          requests:
            memory: "256Mi"
            cpu: "250m"
          limits:
            memory: "512Mi"
            cpu: "500m"
---
apiVersion: v1
kind: Service
metadata:
  name: postgres-service
spec:
  selector:
    app: postgres
  ports:
  - port: 5432
    targetPort: 5432
```

### Redis Cache
```yaml
# redis.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis
  labels:
    app: redis
spec:
  replicas: 1
  selector:
    matchLabels:
      app: redis
  template:
    metadata:
      labels:
        app: redis
    spec:
      containers:
      - name: redis
        image: redis:6-alpine
        ports:
        - containerPort: 6379
        resources:
          requests:
            memory: "128Mi"
            cpu: "100m"
          limits:
            memory: "256Mi"
            cpu: "200m"
---
apiVersion: v1
kind: Service
metadata:
  name: redis-service
spec:
  selector:
    app: redis
  ports:
  - port: 6379
    targetPort: 6379
```

```bash
# Deploy databases
kubectl apply -f database.yaml
kubectl apply -f redis.yaml

# Check they're running
kubectl get pods
kubectl get services
```

---

## 🎯 Step 3: Deploy Microservices

### User Service
```yaml
# user-service.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: user-service
  labels:
    app: user-service
spec:
  replicas: 2
  selector:
    matchLabels:
      app: user-service
  template:
    metadata:
      labels:
        app: user-service
    spec:
      containers:
      - name: user-service
        image: nginx  # Replace with your actual image
        ports:
        - containerPort: 8080
        env:
        - name: DATABASE_URL
          value: "postgres://admin:password123@postgres-service:5432/microservices"
        - name: REDIS_URL
          value: "redis://redis-service:6379"
        resources:
          requests:
            memory: "128Mi"
            cpu: "100m"
          limits:
            memory: "256Mi"
            cpu: "200m"
---
apiVersion: v1
kind: Service
metadata:
  name: user-service
spec:
  selector:
    app: user-service
  ports:
  - port: 8080
    targetPort: 8080
```

### Product Service
```yaml
# product-service.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: product-service
  labels:
    app: product-service
spec:
  replicas: 2
  selector:
    matchLabels:
      app: product-service
  template:
    metadata:
      labels:
        app: product-service
    spec:
      containers:
      - name: product-service
        image: httpd  # Replace with your actual image
        ports:
        - containerPort: 8081
        env:
        - name: DATABASE_URL
          value: "postgres://admin:password123@postgres-service:5432/microservices"
        resources:
          requests:
            memory: "128Mi"
            cpu: "100m"
          limits:
            memory: "256Mi"
            cpu: "200m"
---
apiVersion: v1
kind: Service
metadata:
  name: product-service
spec:
  selector:
    app: product-service
  ports:
  - port: 8081
    targetPort: 80  # httpd runs on port 80
```

```bash
# Deploy services
kubectl apply -f user-service.yaml
kubectl apply -f product-service.yaml

# Check status
kubectl get pods
kubectl get services
```

---

## 🌐 Step 4: Deploy Frontend and API Gateway

### Frontend
```yaml
# frontend.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend
  labels:
    app: frontend
spec:
  replicas: 2
  selector:
    matchLabels:
      app: frontend
  template:
    metadata:
      labels:
        app: frontend
    spec:
      containers:
      - name: frontend
        image: nginx
        ports:
        - containerPort: 80
        resources:
          requests:
            memory: "64Mi"
            cpu: "50m"
          limits:
            memory: "128Mi"
            cpu: "100m"
---
apiVersion: v1
kind: Service
metadata:
  name: frontend-service
spec:
  selector:
    app: frontend
  ports:
  - port: 80
    targetPort: 80
```

### Ingress (API Gateway)
```yaml
# ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: microservices-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: frontend-service
            port:
              number: 80
      - path: /api/users
        pathType: Prefix
        backend:
          service:
            name: user-service
            port:
              number: 8080
      - path: /api/products
        pathType: Prefix
        backend:
          service:
            name: product-service
            port:
              number: 8081
```

```bash
# Deploy frontend and ingress
kubectl apply -f frontend.yaml
kubectl apply -f ingress.yaml

# Check ingress
kubectl get ingress
```

---

## 📊 Step 5: Add Auto-scaling

### HPA for Services
```yaml
# hpa.yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: user-service-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: user-service
  minReplicas: 2
  maxReplicas: 5
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 70
---
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: product-service-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: product-service
  minReplicas: 2
  maxReplicas: 5
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 70
```

```bash
# Apply HPA
kubectl apply -f hpa.yaml

# Check HPA status
kubectl get hpa
```

---

## 🔍 Step 6: Basic Monitoring

### Simple Monitoring Dashboard
```yaml
# monitoring.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: monitoring
  labels:
    app: monitoring
spec:
  replicas: 1
  selector:
    matchLabels:
      app: monitoring
  template:
    metadata:
      labels:
        app: monitoring
    spec:
      containers:
      - name: monitoring
        image: nginx
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: monitoring-service
spec:
  selector:
    app: monitoring
  ports:
  - port: 80
    targetPort: 80
  type: NodePort
```

```bash
# Deploy monitoring
kubectl apply -f monitoring.yaml

# Access monitoring (Minikube)
minikube service monitoring-service --url
```

---

## 🧪 Step 7: Test Your Microservices

### Health Check Script
```bash
# health-check.sh
#!/bin/bash

echo "🔍 Checking Microservices Health..."

# Check all pods
echo "📦 Pod Status:"
kubectl get pods

# Check services
echo "🌐 Service Status:"
kubectl get services

# Check ingress
echo "🚪 Ingress Status:"
kubectl get ingress

# Check HPA
echo "📈 Auto-scaling Status:"
kubectl get hpa

# Check resource usage
echo "💾 Resource Usage:"
kubectl top pods 2>/dev/null || echo "Metrics server not available"

echo "✅ Health check complete!"
```

### Load Test
```bash
# Create load tester
kubectl run load-test --image=busybox --rm -it -- /bin/sh

# Inside the pod, test services:
wget -qO- http://user-service:8080
wget -qO- http://product-service:8081
wget -qO- http://frontend-service
```

---

## 📊 Step 8: Monitor and Scale

### Watch Auto-scaling
```bash
# Generate load on user service
kubectl run load-generator --image=busybox --rm -it -- /bin/sh
# Inside: while true; do wget -q -O- http://user-service:8080; done

# In another terminal, watch scaling
kubectl get hpa -w
kubectl get pods -w
```

### Check Logs
```bash
# Check service logs
kubectl logs -l app=user-service
kubectl logs -l app=product-service

# Check database logs
kubectl logs -l app=postgres
kubectl logs -l app=redis
```

---

## 🧹 Cleanup

```bash
# Delete everything in namespace
kubectl delete all --all -n microservices

# Delete namespace
kubectl delete namespace microservices

# Reset default namespace
kubectl config set-context --current --namespace=default
```

---

## 🎯 What You Built

- ✅ **Complete microservices application** with multiple services
- ✅ **Database layer** with PostgreSQL and Redis
- ✅ **API Gateway** with Ingress controller
- ✅ **Auto-scaling** with HPA
- ✅ **Resource management** with quotas
- ✅ **Service discovery** with DNS
- ✅ **Basic monitoring** setup
- ✅ **Production-ready** deployment patterns

## 🏆 Congratulations!

You've successfully deployed a complete microservices application on Kubernetes! You now have the skills to:

- Deploy complex applications
- Manage microservices architecture
- Implement auto-scaling
- Monitor application health
- Troubleshoot issues

---

*You're now a Kubernetes expert!* 🔬☸️🎉
