# 🔄 **Kubernetes to OpenShift Transition Guide**

## **Overview**
Comprehensive guide for transitioning from Kubernetes to OpenShift, covering key differences, CLI usage, and practical examples.

## **Learning Objectives**
- Understand OpenShift vs Kubernetes differences
- Master OpenShift CLI (`oc`) commands
- Learn OpenShift-specific concepts and resources
- Practice deployment patterns unique to OpenShift

---

## **🔍 Key Differences: Kubernetes vs OpenShift**

### **Architecture Comparison**

| Component | Kubernetes | OpenShift |
|-----------|------------|-----------|
| **Ingress** | Ingress Controller | Routes (built-in) |
| **Registry** | External (Docker Hub, etc.) | Integrated Image Registry |
| **Security** | Manual RBAC setup | Built-in Security Contexts |
| **Builds** | External CI/CD | Source-to-Image (S2I) |
| **Web UI** | Dashboard (optional) | Comprehensive Web Console |
| **Networking** | CNI plugins | SDN with built-in policies |
| **Storage** | StorageClasses | StorageClasses + Templates |

### **Resource Differences**

#### **Routes vs Ingress**
```yaml
# Kubernetes Ingress
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-app
spec:
  rules:
  - host: myapp.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: my-app
            port:
              number: 80
  tls:
  - hosts:
    - myapp.example.com
    secretName: my-app-tls
```

```yaml
# OpenShift Route (simpler)
apiVersion: route.openshift.io/v1
kind: Route
metadata:
  name: my-app
spec:
  host: myapp.example.com
  tls:
    termination: edge
  to:
    kind: Service
    name: my-app
```

#### **Security Contexts**
```yaml
# Kubernetes (manual)
securityContext:
  runAsUser: 1000
  runAsGroup: 1000
  fsGroup: 1000
  runAsNonRoot: true

# OpenShift (automatic)
# Security Context Constraints (SCCs) applied automatically
# Default: restricted SCC (non-root, specific UID range)
```

---

## **⌨️ CLI Command Comparison**

### **Basic Commands**

| Task | Kubernetes (`kubectl`) | OpenShift (`oc`) |
|------|----------------------|------------------|
| **Login** | `kubectl config set-context` | `oc login --token=<token>` |
| **Get Pods** | `kubectl get pods` | `oc get pods` |
| **Create App** | `kubectl create deployment` | `oc new-app` |
| **Expose Service** | `kubectl expose deployment` | `oc expose svc` |
| **Scale** | `kubectl scale deployment` | `oc scale deployment` |
| **Logs** | `kubectl logs` | `oc logs` |
| **Execute** | `kubectl exec` | `oc exec` |

### **OpenShift-Specific Commands**

```bash
# Login to OpenShift
oc login --token=<your-token> --server=<server-url>

# Create application from image
oc new-app nginx:latest --name=web-server

# Create application from Git repository
oc new-app https://github.com/sclorg/nodejs-ex --name=nodejs-app

# Create application from template
oc new-app --template=django-psql-example

# Expose service with route
oc expose svc/web-server

# Create secure route
oc create route edge --service=web-server

# Start build from source
oc start-build nodejs-app

# Get route URL
oc get route web-server -o jsonpath='{.spec.host}'

# Switch between projects
oc project my-project

# Get project information
oc status
```

---

## **🚀 OpenShift-Specific Features**

### **1. Source-to-Image (S2I) Builds**

#### **Concept**
S2I builds application source code into container images without writing Dockerfiles.

#### **Example**
```bash
# Deploy Node.js app from Git
oc new-app nodejs~https://github.com/sclorg/nodejs-ex

# Monitor build
oc logs -f buildconfig/nodejs-ex

# Trigger new build
oc start-build nodejs-ex
```

### **2. Image Streams**

#### **Concept**
Image Streams provide abstraction for container images and automatic updates.

#### **Example**
```bash
# List image streams
oc get imagestreams

# Get image stream details
oc describe imagestream nodejs

# Import external image
oc import-image my-app:latest --from=docker.io/nginx:latest
```

### **3. Build Configurations**

#### **Concept**
BuildConfigs define how to build container images from source code.

#### **Example**
```bash
# List build configurations
oc get buildconfigs

# Describe build config
oc describe buildconfig nodejs-ex

# Edit build config
oc edit buildconfig nodejs-ex
```

### **4. Deployment Configurations**

#### **Concept**
DeploymentConfigs provide additional deployment features beyond Kubernetes Deployments.

#### **Example**
```bash
# List deployment configs
oc get deploymentconfigs

# Scale deployment config
oc scale deploymentconfig/my-app --replicas=3

# Rollback deployment
oc rollback my-app
```

---

## **🔧 Practical Migration Examples**

### **Example 1: Simple Web Server**

#### **Kubernetes Approach**
```bash
# Create deployment
kubectl create deployment nginx --image=nginx:latest

# Expose service
kubectl expose deployment nginx --port=80 --type=LoadBalancer

# Create ingress (requires separate YAML)
kubectl apply -f ingress.yaml
```

#### **OpenShift Approach**
```bash
# Create application and expose in one command
oc new-app nginx:latest --name=nginx
oc expose svc/nginx

# Get URL immediately
echo "URL: https://$(oc get route nginx -o jsonpath='{.spec.host}')"
```

### **Example 2: Application from Source Code**

#### **Kubernetes Approach**
```bash
# Requires Dockerfile and CI/CD pipeline
# 1. Build image externally
# 2. Push to registry
# 3. Deploy with kubectl
```

#### **OpenShift Approach**
```bash
# Direct deployment from Git
oc new-app python~https://github.com/sclorg/django-ex
oc expose svc/django-ex

# Automatic build and deployment
```

---

## **🔒 Security Differences**

### **Security Context Constraints (SCCs)**

OpenShift uses SCCs to control pod security policies automatically.

```bash
# List available SCCs
oc get scc

# View default SCC
oc describe scc restricted

# Check which SCC is applied to a pod
oc describe pod <pod-name> | grep scc
```

### **Default Security**
- **Kubernetes**: Pods can run as root by default
- **OpenShift**: Pods run with restricted SCC (non-root, random UID)

---

## **🌐 Networking Differences**

### **Routes vs Ingress**

#### **Advantages of OpenShift Routes**
- Built-in HTTPS termination
- Automatic certificate management
- Simpler configuration
- No additional controller needed

#### **Route Types**
```bash
# Edge termination (HTTPS at route, HTTP to pod)
oc create route edge --service=my-app

# Passthrough termination (HTTPS end-to-end)
oc create route passthrough --service=my-app

# Re-encryption termination (HTTPS to route, new HTTPS to pod)
oc create route reencrypt --service=my-app
```

---

## **📋 Migration Checklist**

### **Before Migration**
- [ ] Inventory existing Kubernetes resources
- [ ] Identify custom security contexts
- [ ] Review ingress configurations
- [ ] Check external dependencies

### **During Migration**
- [ ] Convert Ingress to Routes
- [ ] Update security contexts for OpenShift SCCs
- [ ] Migrate CI/CD to S2I builds (optional)
- [ ] Test application functionality

### **After Migration**
- [ ] Verify all routes are accessible
- [ ] Check pod security compliance
- [ ] Test scaling and updates
- [ ] Update monitoring and logging

---

## **🎯 Hands-On Exercise**

### **Task: Deploy the Same App in Both Platforms**

#### **Kubernetes Version**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hello-app
spec:
  replicas: 1
  selector:
    matchLabels:
      app: hello-app
  template:
    metadata:
      labels:
        app: hello-app
    spec:
      containers:
      - name: hello
        image: nginx:alpine
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: hello-app
spec:
  selector:
    app: hello-app
  ports:
  - port: 80
    targetPort: 80
```

#### **OpenShift Version**
```bash
# Single command deployment
oc new-app nginx:alpine --name=hello-app
oc expose svc/hello-app

# Get URL
oc get route hello-app
```

---

## **🎯 Learning Outcomes**
- ✅ Understand architectural differences between K8s and OpenShift
- ✅ Master OpenShift CLI commands and workflows
- ✅ Convert Kubernetes resources to OpenShift equivalents
- ✅ Leverage OpenShift-specific features (S2I, Routes, SCCs)
- ✅ Apply security best practices in OpenShift
- ✅ Navigate between kubectl and oc commands

## **📚 Next Steps**
- Practice with OpenShift Web Console
- Explore advanced S2I build strategies
- Learn OpenShift Operators and OperatorHub
- Study OpenShift Pipelines (Tekton)
- Understand OpenShift GitOps (ArgoCD)

---

**Duration:** 45 minutes  
**Difficulty:** Intermediate  
**Focus:** Platform transition and CLI mastery
