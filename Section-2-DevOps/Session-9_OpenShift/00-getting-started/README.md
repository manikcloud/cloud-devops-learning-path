# 🚀 **Project 0: Getting Started with OpenShift**

## **Learning Objectives**
- Understand OpenShift CLI basics
- Learn about OpenShift Routes vs Kubernetes Ingress
- Practice basic deployment concepts
- Understand OpenShift security model

## **Prerequisites**
- OpenShift Sandbox account (free)
- `oc` CLI installed
- Basic Kubernetes knowledge

## **Theory: Key OpenShift Concepts**

### **OpenShift vs Kubernetes**
| Feature | Kubernetes | OpenShift |
|---------|------------|-----------|
| Ingress | Ingress Controller | Routes (built-in) |
| Security | Manual RBAC | Built-in security contexts |
| Build | External CI/CD | Source-to-Image (S2I) |
| Registry | External | Integrated registry |

### **Essential Commands**
```bash
# Login to OpenShift
oc login --token=<your-token> --server=<your-server>

# Check current user and project
oc whoami
oc project

# Deploy from image
oc new-app <image-name>

# Deploy from source code
oc new-app <git-url>

# Expose service with route
oc expose svc/<service-name>

# Get route URL
oc get routes
```

## **Hands-On Exercise (Theory)**

### **Step 1: Login Process**
```bash
# Get login command from OpenShift web console
# Navigate to: Copy Login Command → Display Token
oc login --token=sha256~... --server=https://api...
```

### **Step 2: Deploy Application**
```bash
# Example deployment (may require adjustments for sandbox)
oc new-app nginx:latest --name=web-app
oc expose svc/web-app
```

### **Step 3: Access Application**
```bash
# Get the route URL
oc get route web-app -o jsonpath='{.spec.host}'
# Access via: https://<route-host>
```

## **Common Issues in OpenShift Sandbox**
- **Image Pull Errors**: Use Red Hat certified images
- **Security Constraints**: Non-root containers required
- **Resource Limits**: CPU/Memory restrictions apply
- **Network Policies**: Limited external access

## **Recommended Images for Sandbox**
- `registry.redhat.io/ubi8/nginx-120`
- `registry.redhat.io/ubi8/httpd-24`
- `registry.redhat.io/ubi8/nodejs-16`

## **Learning Outcomes**
- ✅ Understand OpenShift CLI workflow
- ✅ Know the difference between Routes and Ingress
- ✅ Recognize OpenShift security model
- ✅ Practice basic deployment commands

## **Next Steps**
- Explore OpenShift Web Console
- Learn about Source-to-Image builds
- Study OpenShift Templates
- Practice with different application types

---

**Note**: This is a foundational exercise focusing on concepts and CLI familiarity. Advanced deployments require full OpenShift cluster access.
