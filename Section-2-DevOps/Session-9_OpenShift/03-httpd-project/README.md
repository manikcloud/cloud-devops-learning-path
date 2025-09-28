# 🌐 **Project 3: Hello World Static Website**

## **Overview**
Deploy a simple "Hello World" static website using Apache HTTPD and ConfigMaps on OpenShift. This project demonstrates the basics of static content hosting with HTTPS routes.

## **Learning Objectives**
- Deploy static websites using HTTPD on OpenShift
- Use ConfigMaps to manage HTML content
- Create HTTPS routes for secure access
- Understand volume mounting in OpenShift
- Practice basic troubleshooting

## **Prerequisites**
- OpenShift Sandbox account
- `oc` CLI installed and logged in
- Basic understanding of HTML and YAML
---

## Output 

<img width="1778" height="851" alt="image" src="https://github.com/user-attachments/assets/5a90e507-e80a-4f1f-b8a7-224760dbfc29" />

---

## **📋 Complete Runbook**

### **Step 1: Login and Verify Environment**
```bash
# Login to OpenShift (get token from web console)
oc login --token=<your-token> --server=<your-server>

# Verify current project
oc project
oc whoami

# Check resource quotas (optional)
oc describe quota
```

### **Step 2: Deploy the Application**
```bash
# Deploy the hello world application
oc apply -f hello-world.yaml

# Verify resources were created
oc get all -l app=hello-world
```

### **Step 3: Monitor Deployment**
```bash
# Watch pod status
oc get pods -l app=hello-world -w

# Check deployment status
oc rollout status deployment/hello-world

# View deployment logs
oc logs -f deployment/hello-world
```

### **Step 4: Access the Application**
```bash
# Get the route URL
oc get route hello-world

# Display the full URL
echo "Your Hello World app: https://$(oc get route hello-world -o jsonpath='{.spec.host}')"

# Test the application
curl -k https://$(oc get route hello-world -o jsonpath='{.spec.host}')
```

### **Step 5: Verify Everything is Working**
```bash
# Check all resources
oc get pods,svc,route,configmap -l app=hello-world

# Verify ConfigMap content
oc describe configmap hello-html

# Check route configuration
oc describe route hello-world
```

---

## **🖥️ Web Console Method**

### **Step 1: Create ConfigMap**
1. Login to [OpenShift Console](https://console-openshift-console.apps.rm3.7wse.p1.openshiftapps.com)
2. Go to **Workloads → ConfigMaps**
3. Click **"Create ConfigMap"**
4. Name: `hello-html`
5. Key: `index.html`
6. Value: Copy the HTML content from `hello-world.yaml`
7. Click **"Create"**

### **Step 2: Deploy Application**
1. Go to **"+Add"** → **"Container Image"**
2. Image Name: `registry.redhat.io/ubi8/httpd-24`
3. Application Name: `hello-world`
4. Name: `hello-world`
5. Click **"Create"**

### **Step 3: Mount ConfigMap**
1. Go to **Workloads → Deployments**
2. Click `hello-world` deployment
3. Go to **Environment** tab
4. Scroll to **Volumes** section
5. Click **"Add Volume"** → **"ConfigMap"**
6. Source: `hello-html`
7. Mount Path: `/var/www/html`
8. Save changes

### **Step 4: Create Route**
1. Go to **Networking → Services**
2. Click `hello-world` service
3. Click **"Create Route"**
4. Enable **"Secure Route"**
5. TLS Termination: **"Edge"**
6. Click **"Create"**

---

## **🔧 Troubleshooting Guide**

### **Common Issues and Solutions**

#### **1. Pod Not Starting**
```bash
# Check pod events
oc describe pod -l app=hello-world

# Check pod logs
oc logs -l app=hello-world

# Common causes:
# - Image pull errors
# - Security context issues
# - Resource constraints
```

#### **2. Application Not Accessible**
```bash
# Verify route exists
oc get routes

# Check service endpoints
oc get endpoints hello-world

# Test internal connectivity
oc port-forward deployment/hello-world 8080:8080
# Then test: curl http://localhost:8080
```

#### **3. Content Not Loading**
```bash
# Verify ConfigMap exists
oc get configmap hello-html

# Check ConfigMap content
oc describe configmap hello-html

# Verify volume mount
oc describe deployment hello-world | grep -A 10 "Mounts"

# Check files in pod
oc exec -it deployment/hello-world -- ls -la /var/www/html
```

#### **4. HTTPS Issues**
```bash
# Check route TLS configuration
oc describe route hello-world

# Verify certificate
curl -I -k https://$(oc get route hello-world -o jsonpath='{.spec.host}')
```

---

## **📊 Verification Checklist**

### **✅ Deployment Verification**
- [ ] ConfigMap `hello-html` created successfully
- [ ] Deployment `hello-world` is running (1/1 Ready)
- [ ] Service `hello-world` has endpoints
- [ ] Route `hello-world` is created with HTTPS
- [ ] Pod logs show no errors

### **✅ Application Verification**
- [ ] URL is accessible in browser
- [ ] Page shows "Hello World from OpenShift!"
- [ ] HTTPS lock icon appears in browser
- [ ] Page loads without errors
- [ ] Styling is applied correctly

### **✅ OpenShift Features Verification**
```bash
# Verify all components
oc get all -l app=hello-world

# Expected output:
# - 1 pod running
# - 1 service with endpoints
# - 1 deployment ready
# - 1 route with host
```

---

## **🎯 Learning Exercises**

### **Exercise 1: Modify Content**
```bash
# Update the HTML content
oc patch configmap hello-html --patch='{"data":{"index.html":"<html><body><h1>Updated Hello World!</h1></body></html>"}}'

# Restart deployment to pick up changes
oc rollout restart deployment/hello-world

# Verify changes
curl https://$(oc get route hello-world -o jsonpath='{.spec.host}')
```

### **Exercise 2: Scale the Application**
```bash
# Scale to 2 replicas
oc scale deployment hello-world --replicas=2

# Verify scaling
oc get pods -l app=hello-world

# Scale back to 1
oc scale deployment hello-world --replicas=1
```

### **Exercise 3: Add More Files**
```bash
# Create ConfigMap with multiple files
oc create configmap multi-html \
  --from-literal=index.html='<html><body><h1>Home Page</h1><a href="about.html">About</a></body></html>' \
  --from-literal=about.html='<html><body><h1>About Page</h1><a href="index.html">Home</a></body></html>'

# Update deployment to use new ConfigMap
oc patch deployment hello-world --patch='{"spec":{"template":{"spec":{"volumes":[{"name":"html-content","configMap":{"name":"multi-html"}}]}}}}'
```

---

## **🧹 Cleanup**

### **Complete Cleanup**
```bash
# Delete all application resources
oc delete -f hello-world.yaml

# Verify cleanup
oc get all -l app=hello-world
```

### **Individual Resource Cleanup**
```bash
# Delete specific resources
oc delete deployment hello-world
oc delete service hello-world
oc delete route hello-world
oc delete configmap hello-html
```

---

## **📚 What You Learned**

### **OpenShift Concepts**
- ✅ **ConfigMaps** - Storing and managing configuration data
- ✅ **Deployments** - Managing application lifecycle
- ✅ **Services** - Internal networking and load balancing
- ✅ **Routes** - External access with HTTPS termination
- ✅ **Volume Mounts** - Injecting content into containers

### **Practical Skills**
- ✅ Deploy static websites on OpenShift
- ✅ Use ConfigMaps for content management
- ✅ Configure HTTPS routes
- ✅ Troubleshoot common deployment issues
- ✅ Scale applications up and down
- ✅ Update application content without rebuilding

### **Best Practices**
- ✅ Use Red Hat certified images
- ✅ Apply proper security contexts
- ✅ Enable HTTPS by default
- ✅ Use labels for resource organization
- ✅ Implement proper resource cleanup

---

## **🚀 Next Steps**
- Add custom CSS and JavaScript files
- Implement health checks and readiness probes
- Explore persistent storage for larger websites
- Learn about OpenShift image streams
- Practice with different web servers (Nginx, Node.js)

---

**Duration:** 15 minutes  
**Difficulty:** Beginner  
**Focus:** Static website deployment and basic OpenShift concepts

**🎯 Success Criteria:** Students can deploy, access, modify, and cleanup a static website on OpenShift using ConfigMaps and HTTPS routes.
