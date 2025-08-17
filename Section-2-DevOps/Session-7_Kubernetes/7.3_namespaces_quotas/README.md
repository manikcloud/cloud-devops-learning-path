# 🏷️ 7.7 Namespaces and Quotas

## 🎯 Think of Namespaces as Apartments

**Problem**: All your apps live in one big messy room  
**Solution**: Namespaces = Separate apartments for different teams/apps

### Why Use Namespaces?
- **Organize** resources by team/project/environment
- **Isolate** resources from each other
- **Control** who can access what
- **Limit** resource usage per team

---

## 🏠 Working with Namespaces

### See Current Namespaces
```bash
# List all namespaces
kubectl get namespaces

# Or short form
kubectl get ns
```

### Create Namespaces
```bash
# Create namespace
kubectl create namespace development
kubectl create namespace testing
kubectl create namespace production

# Or with YAML
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Namespace
metadata:
  name: my-app
  labels:
    environment: production
    team: backend
EOF
```

### Use Namespaces
```bash
# Deploy to specific namespace
kubectl create deployment nginx --image=nginx -n development

# List resources in namespace
kubectl get pods -n development

# Set default namespace for current context
kubectl config set-context --current --namespace=development

# Now all commands use 'development' namespace
kubectl get pods  # Shows pods in development namespace
```

---

## 📊 Resource Quotas (Budget Control)

### Why Quotas?
- **Prevent** one team from using all cluster resources
- **Budget** CPU, memory, storage per namespace
- **Limit** number of objects (pods, services, etc.)

### Simple Resource Quota
```yaml
# resource-quota.yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: development-quota
  namespace: development
spec:
  hard:
    requests.cpu: "4"        # Total CPU requests
    requests.memory: 8Gi     # Total memory requests
    limits.cpu: "8"          # Total CPU limits
    limits.memory: 16Gi      # Total memory limits
    pods: "10"               # Max 10 pods
    services: "5"            # Max 5 services
    persistentvolumeclaims: "4"  # Max 4 PVCs
```

```bash
# Apply quota
kubectl apply -f resource-quota.yaml

# Check quota usage
kubectl describe quota -n development
```

---

## 🧪 Hands-On Practice

### Exercise 1: Multi-Environment Setup
```bash
# Create environments
kubectl create namespace dev
kubectl create namespace staging
kubectl create namespace prod

# Deploy same app to different environments
kubectl create deployment webapp --image=nginx:1.20 --replicas=2 -n dev
kubectl create deployment webapp --image=nginx:1.21 --replicas=3 -n staging
kubectl create deployment webapp --image=nginx:1.21 --replicas=5 -n prod

# Check each environment
kubectl get pods -n dev
kubectl get pods -n staging
kubectl get pods -n prod
```

### Exercise 2: Resource Limits per Environment
```yaml
# dev-quota.yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: dev-quota
  namespace: dev
spec:
  hard:
    requests.cpu: "2"
    requests.memory: 4Gi
    pods: "5"
---
# staging-quota.yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: staging-quota
  namespace: staging
spec:
  hard:
    requests.cpu: "4"
    requests.memory: 8Gi
    pods: "10"
---
# prod-quota.yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: prod-quota
  namespace: prod
spec:
  hard:
    requests.cpu: "8"
    requests.memory: 16Gi
    pods: "20"
```

```bash
# Apply all quotas
kubectl apply -f dev-quota.yaml
kubectl apply -f staging-quota.yaml
kubectl apply -f prod-quota.yaml

# Check quota status
kubectl describe quota -n dev
kubectl describe quota -n staging
kubectl describe quota -n prod
```

---

## 🔒 Basic RBAC (Role-Based Access Control)

### Create Service Account
```bash
# Create service account for developers
kubectl create serviceaccount developer -n development

# Create role (what they can do)
cat <<EOF | kubectl apply -f -
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: development
  name: developer-role
rules:
- apiGroups: [""]
  resources: ["pods", "services"]
  verbs: ["get", "list", "create", "delete"]
- apiGroups: ["apps"]
  resources: ["deployments"]
  verbs: ["get", "list", "create", "update", "delete"]
EOF

# Bind role to service account
kubectl create rolebinding developer-binding \
  --role=developer-role \
  --serviceaccount=development:developer \
  -n development
```

---

## 🏷️ Labels and Annotations for Organization

### Organize with Labels
```yaml
# organized-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-app
  namespace: production
  labels:
    app: web-app
    version: v1.2.0
    environment: production
    team: frontend
    component: web-server
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web-app
  template:
    metadata:
      labels:
        app: web-app
        version: v1.2.0
        environment: production
        team: frontend
    spec:
      containers:
      - name: web
        image: nginx:1.21
```

### Useful Label Queries
```bash
# Find all production resources
kubectl get all -l environment=production --all-namespaces

# Find all frontend team resources
kubectl get all -l team=frontend --all-namespaces

# Find specific version
kubectl get pods -l version=v1.2.0 --all-namespaces
```

---

## 🔍 Monitoring and Troubleshooting

### Namespace Commands
```bash
# See all resources in namespace
kubectl get all -n development

# Describe namespace
kubectl describe namespace development

# Check resource usage
kubectl top pods -n development
kubectl top nodes

# Events in namespace
kubectl get events -n development --sort-by=.metadata.creationTimestamp
```

### Quota Troubleshooting
```bash
# Why can't I create more pods?
kubectl describe quota -n development

# Check current resource usage
kubectl describe limitrange -n development

# See what's using resources
kubectl top pods -n development --sort-by=cpu
kubectl top pods -n development --sort-by=memory
```

---

## 🧪 Real-World Example

### Complete Multi-Tenant Setup
```bash
# Create team namespaces
kubectl create namespace team-alpha
kubectl create namespace team-beta

# Set quotas for each team
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ResourceQuota
metadata:
  name: team-alpha-quota
  namespace: team-alpha
spec:
  hard:
    requests.cpu: "4"
    requests.memory: 8Gi
    limits.cpu: "8"
    limits.memory: 16Gi
    pods: "15"
    services: "10"
---
apiVersion: v1
kind: ResourceQuota
metadata:
  name: team-beta-quota
  namespace: team-beta
spec:
  hard:
    requests.cpu: "2"
    requests.memory: 4Gi
    limits.cpu: "4"
    limits.memory: 8Gi
    pods: "10"
    services: "5"
EOF

# Deploy apps for each team
kubectl create deployment alpha-app --image=nginx --replicas=3 -n team-alpha
kubectl create deployment beta-app --image=httpd --replicas=2 -n team-beta

# Check resource usage
kubectl describe quota -n team-alpha
kubectl describe quota -n team-beta
```

---

## 🧹 Cleanup
```bash
# Delete namespaces (deletes everything inside)
kubectl delete namespace development
kubectl delete namespace testing
kubectl delete namespace production
kubectl delete namespace team-alpha
kubectl delete namespace team-beta
```

---

## 🎯 What You Learned

- ✅ Namespaces organize and isolate resources
- ✅ Resource quotas control resource usage
- ✅ RBAC controls who can do what
- ✅ Labels help organize and find resources
- ✅ Multi-tenant cluster management
- ✅ Monitoring and troubleshooting namespaces

## 🚀 Next Step

Ready for the final project? Go to **[7.8 - Deploying Microservices](../7.8_microservices/)**

---

*Organize to optimize!* 🏷️📊
