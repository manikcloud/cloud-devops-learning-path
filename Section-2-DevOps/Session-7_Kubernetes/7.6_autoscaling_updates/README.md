# 📈 7.6 Auto-scaling and Rolling Updates

## 🎯 Smart Scaling

**Problem**: Traffic goes up and down, but your app stays the same size  
**Solution**: Auto-scaling adjusts automatically!

### Two Types of Auto-scaling
1. **HPA** (Horizontal Pod Autoscaler) - More pods when busy
2. **VPA** (Vertical Pod Autoscaler) - Bigger pods when needed

---

## 📊 Horizontal Pod Autoscaler (HPA)

### Simple HPA Setup
```bash
# First, create a deployment
kubectl create deployment php-apache --image=k8s.gcr.io/hpa-example

# Expose it
kubectl expose deployment php-apache --port=80

# Create HPA (scale 1-10 pods based on CPU)
kubectl autoscale deployment php-apache --cpu-percent=50 --min=1 --max=10

# Check it
kubectl get hpa
```

### HPA with YAML
```yaml
# hpa.yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: php-apache-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: php-apache
  minReplicas: 1
  maxReplicas: 10
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 50
```

---

## 🧪 Test Auto-scaling

### Generate Load
```bash
# Create load generator
kubectl run -i --tty load-generator --rm --image=busybox --restart=Never -- /bin/sh

# Inside the pod, create load:
while true; do wget -q -O- http://php-apache; done
```

### Watch Scaling in Action
```bash
# In another terminal, watch HPA
kubectl get hpa -w

# Watch pods scale up
kubectl get pods -w

# Stop load generator (Ctrl+C in first terminal)
# Watch pods scale down
```

---

## 🔄 Rolling Updates (Zero Downtime)

### Update Strategy Types
1. **RollingUpdate** (default) - Gradual replacement
2. **Recreate** - Stop all, then start new (downtime!)

### Rolling Update Example
```yaml
# deployment-with-strategy.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: rolling-app
spec:
  replicas: 6
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 1    # Max pods down during update
      maxSurge: 1          # Max extra pods during update
  selector:
    matchLabels:
      app: rolling-app
  template:
    metadata:
      labels:
        app: rolling-app
    spec:
      containers:
      - name: app
        image: nginx:1.20
        ports:
        - containerPort: 80
```

### Perform Rolling Update
```bash
# Apply deployment
kubectl apply -f deployment-with-strategy.yaml

# Update image
kubectl set image deployment/rolling-app app=nginx:1.21

# Watch the rollout
kubectl rollout status deployment/rolling-app

# See rollout history
kubectl rollout history deployment/rolling-app
```

---

## ⏪ Rollback Strategies

### Quick Rollback
```bash
# Oops! Something's wrong, rollback!
kubectl rollout undo deployment/rolling-app

# Check status
kubectl rollout status deployment/rolling-app
```

### Rollback to Specific Version
```bash
# See all versions
kubectl rollout history deployment/rolling-app

# Rollback to specific revision
kubectl rollout undo deployment/rolling-app --to-revision=2

# Verify
kubectl describe deployment rolling-app
```

---

## 🏥 Health Checks (Important!)

### Liveness and Readiness Probes
```yaml
# healthy-app.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: healthy-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: healthy-app
  template:
    metadata:
      labels:
        app: healthy-app
    spec:
      containers:
      - name: app
        image: nginx
        ports:
        - containerPort: 80
        livenessProbe:          # Restart if this fails
          httpGet:
            path: /
            port: 80
          initialDelaySeconds: 30
          periodSeconds: 10
        readinessProbe:         # Don't send traffic if this fails
          httpGet:
            path: /
            port: 80
          initialDelaySeconds: 5
          periodSeconds: 5
```

---

## 🧪 Advanced Update Strategies

### Blue-Green Deployment (Manual)
```bash
# Deploy blue version
kubectl create deployment blue-app --image=nginx:1.20 --replicas=3
kubectl expose deployment blue-app --port=80 --name=app-service

# Deploy green version (new)
kubectl create deployment green-app --image=nginx:1.21 --replicas=3

# Test green version
kubectl expose deployment green-app --port=80 --name=green-service

# Switch traffic (update service selector)
kubectl patch service app-service -p '{"spec":{"selector":{"app":"green-app"}}}'

# If all good, delete blue
kubectl delete deployment blue-app
```

### Canary Deployment (Gradual)
```bash
# Start with stable version (90% traffic)
kubectl create deployment stable-app --image=nginx:1.20 --replicas=9

# Deploy canary version (10% traffic)
kubectl create deployment canary-app --image=nginx:1.21 --replicas=1

# Both use same service (same labels)
kubectl label deployment stable-app version=stable
kubectl label deployment canary-app version=canary
kubectl expose deployment stable-app --port=80 --name=app-service --selector="app=stable-app"

# Gradually increase canary replicas, decrease stable replicas
```

---

## 📊 Monitoring Updates

### Useful Commands
```bash
# Watch deployment status
kubectl get deployments -w

# Check rollout status
kubectl rollout status deployment/<name>

# See detailed events
kubectl describe deployment <name>

# Check pod status during update
kubectl get pods -l app=<app-name> -w

# Resource usage
kubectl top pods
```

---

## 🎯 Best Practices

### 1. Always Set Resource Limits
```yaml
resources:
  requests:
    memory: "64Mi"
    cpu: "250m"
  limits:
    memory: "128Mi"
    cpu: "500m"
```

### 2. Use Health Checks
```yaml
livenessProbe:
  httpGet:
    path: /health
    port: 8080
readinessProbe:
  httpGet:
    path: /ready
    port: 8080
```

### 3. Gradual Rollouts
```yaml
strategy:
  rollingUpdate:
    maxUnavailable: 25%
    maxSurge: 25%
```

---

## 🧹 Cleanup
```bash
# Delete HPA
kubectl delete hpa php-apache-hpa

# Delete deployments
kubectl delete deployment php-apache rolling-app healthy-app

# Delete services
kubectl delete service php-apache app-service
```

---

## 🎯 What You Learned

- ✅ HPA scales pods automatically based on CPU/memory
- ✅ Rolling updates provide zero-downtime deployments
- ✅ Rollback quickly when things go wrong
- ✅ Health checks ensure app reliability
- ✅ Blue-green and canary deployment strategies
- ✅ Best practices for production updates

## 🚀 Next Step

Ready to learn about namespaces and quotas? Go to **[7.7 - Namespaces & Quotas](../7.7_namespaces_quotas/)**

---

*Scale smart, update smooth!* 📈🔄
