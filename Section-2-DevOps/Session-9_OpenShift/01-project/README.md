# 🚀 **Project 1: OpenShift Hello World Examples**

## **Overview**
Educational examples demonstrating OpenShift deployment patterns. These examples show proper YAML structure and OpenShift concepts, though they may require adjustments for specific sandbox environments.

## **Examples Included**
1. **Python Flask App** - Dynamic web application example
2. **HTTPD Static Site** - Static content server example

## **Prerequisites**
- OpenShift Sandbox account
- `oc` CLI installed and logged in
- Understanding of Kubernetes/OpenShift concepts

---

## **🐍 Example 1: Python Flask Application**

### **Concept Overview**
This example demonstrates:
- Using Red Hat UBI Python image
- ConfigMap for application code
- Flask web framework deployment
- Security context configuration

### **Key Learning Points**
```yaml
# ConfigMap stores Python code
apiVersion: v1
kind: ConfigMap
metadata:
  name: python-app
data:
  app.py: |
    # Flask application code here
  requirements.txt: |
    Flask==2.3.3

# Deployment uses UBI Python image
spec:
  containers:
  - name: python-hello
    image: registry.redhat.io/ubi8/python-39
    securityContext:
      runAsNonRoot: true
      runAsUser: 1001
```

### **Deployment Pattern**
```bash
# Theoretical deployment steps
oc apply -f python-hello.yaml
oc rollout status deployment/python-hello
oc get route python-hello
```

---

## **🌐 Example 2: HTTPD Static Site**

### **Concept Overview**
This example demonstrates:
- Using Red Hat UBI HTTPD image
- ConfigMap for HTML content
- Static file serving
- Route with HTTPS termination

### **Key Learning Points**
```yaml
# ConfigMap stores HTML content
apiVersion: v1
kind: ConfigMap
metadata:
  name: httpd-content
data:
  index.html: |
    <!DOCTYPE html>
    # HTML content here

# Deployment mounts HTML content
spec:
  containers:
  - name: httpd-hello
    image: registry.redhat.io/ubi8/httpd-24
    volumeMounts:
    - name: html-content
      mountPath: /var/www/html
```

---

## **🔧 OpenShift Concepts Explained**

### **1. Routes vs Ingress**
```yaml
# OpenShift Route (simpler than K8s Ingress)
apiVersion: route.openshift.io/v1
kind: Route
metadata:
  name: my-app
spec:
  tls:
    termination: edge  # Automatic HTTPS
  to:
    kind: Service
    name: my-app
```

### **2. Security Contexts**
```yaml
# Required for OpenShift security
securityContext:
  runAsNonRoot: true
  runAsUser: 1001  # Non-root user
```

### **3. Red Hat Images**
- `registry.redhat.io/ubi8/python-39` - Python runtime
- `registry.redhat.io/ubi8/httpd-24` - Apache HTTP server
- `registry.redhat.io/ubi8/nginx-120` - Nginx server
- `registry.redhat.io/ubi8/nodejs-16` - Node.js runtime

---

## **📋 Deployment Troubleshooting Guide**

### **Common OpenShift Sandbox Issues**

#### **1. Image Pull Errors**
```bash
# Check image availability
oc describe pod <pod-name>

# Look for events like:
# "Failed to pull image: registry access denied"
```

**Solution**: Use Red Hat certified images from `registry.redhat.io`

#### **2. Security Context Violations**
```bash
# Error: container has runAsNonRoot and image will run as root
```

**Solution**: Add security context:
```yaml
securityContext:
  runAsNonRoot: true
  runAsUser: 1001
```

#### **3. Resource Quotas**
```bash
# Check quotas
oc describe quota
oc describe limitrange
```

**Solution**: Ensure resource requests fit within limits

#### **4. Route Access Issues**
```bash
# Check route status
oc get routes
oc describe route <route-name>
```

**Common Issues**:
- Route not created: `oc expose svc/<service-name>`
- HTTPS not working: Add TLS termination
- DNS not resolving: Wait for propagation

---

## **🎯 Learning Outcomes**

### **OpenShift Concepts Mastered**
- ✅ **Routes** - External HTTPS access (vs K8s Ingress)
- ✅ **Security Contexts** - Non-root container execution
- ✅ **ConfigMaps** - Configuration and code injection
- ✅ **Red Hat Images** - Certified container images
- ✅ **S2I Concepts** - Source-to-Image build process

### **Practical Skills**
- ✅ YAML structure for OpenShift resources
- ✅ Troubleshooting deployment issues
- ✅ Understanding security constraints
- ✅ Route configuration for HTTPS

---

## **🔗 Alternative Working Examples**

### **Simple Pod Deployment**
```bash
# This often works in sandbox environments
oc run hello --image=registry.redhat.io/ubi8/httpd-24 --port=8080
oc expose pod hello --port=8080
oc create route edge hello --service=hello
```

### **Template-Based Deployment**
```bash
# Use OpenShift templates (more reliable)
oc new-app --template=httpd-example
oc new-app --template=nodejs-mongodb-example
```

---

## **📚 Next Steps**
- Practice with OpenShift Web Console
- Explore Source-to-Image (S2I) builds
- Learn about OpenShift Templates
- Study OpenShift Operators
- Understand BuildConfigs and ImageStreams

---

**Note**: These examples demonstrate OpenShift concepts and YAML structure. Actual deployment success may vary based on sandbox environment constraints and resource availability.

**Duration:** 45 minutes (theory + practice)  
**Difficulty:** Intermediate  
**Focus:** OpenShift deployment patterns and troubleshooting
