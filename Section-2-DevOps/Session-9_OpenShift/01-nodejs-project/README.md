# 🟢 **Project 1: Node.js Application Deployment**

## **Overview**
Deploy a Node.js application using OpenShift's Source-to-Image (S2I) build process with both Web Console and CLI methods.

## **Learning Objectives**
- Deploy applications from Git repositories
- Understand Source-to-Image (S2I) builds
- Create and manage routes for external access
- Monitor application logs and status

---

## **🖥️ Method 1: Web Console Steps**

### **Step 1: Access OpenShift Console**
1. Open [OpenShift Console](https://console-openshift-console.apps.rm3.7wse.p1.openshiftapps.com)
2. Login with your credentials
3. Select your project (e.g., `varunmanik1-dev`)

### **Step 2: Create Application**
1. Click **"+Add"** in the left sidebar
2. Select **"From Git"** tile
3. Enter Git Repository URL:
   ```
   https://github.com/sclorg/nodejs-ex
   ```
4. **Application Name**: `nodejs-app`
5. **Name**: `nodejs-app`
6. Check **"Create a route to the application"**
7. Click **"Create"**

### **Step 3: Monitor Build**
1. Go to **Topology** view
2. Click on the `nodejs-app` node
3. Click **"View logs"** to monitor build progress
4. Wait for build to complete (green checkmark)

### **Step 4: Access Application**
1. In Topology view, click the **route icon** (↗) on the `nodejs-app` node
2. Or go to **Networking → Routes**
3. Click the route URL to access your application

### **Step 5: Monitor Application**
1. **Topology**: View application status
2. **Workloads → Pods**: See running pods
3. **Builds → Builds**: Monitor build history
4. **Networking → Services**: View service configuration

---

## **⌨️ Method 2: CLI Steps**

### **Step 1: Login and Setup**
```bash
# Login to OpenShift
oc login --token=<your-token> --server=<your-server>

# Verify current project
oc project
```

### **Step 2: Deploy Application**
```bash
# Create new application from Git repository
oc new-app nodejs~https://github.com/sclorg/nodejs-ex --name=nodejs-app

# Monitor the build
oc logs -f buildconfig/nodejs-app
```

### **Step 3: Expose Application**
```bash
# Create route for external access
oc expose svc/nodejs-app

# Get the route URL
oc get route nodejs-app
echo "Application URL: https://$(oc get route nodejs-app -o jsonpath='{.spec.host}')"
```

### **Step 4: Monitor and Manage**
```bash
# Check application status
oc status

# View pods
oc get pods -l app=nodejs-app

# View logs
oc logs -f deployment/nodejs-app

# Scale application
oc scale deployment/nodejs-app --replicas=2
```

---

## **🔧 Troubleshooting**

### **Common Issues**

#### **Build Failures**
```bash
# Check build logs
oc logs -f build/nodejs-app-1

# Check build configuration
oc describe buildconfig/nodejs-app
```

#### **Pod Issues**
```bash
# Check pod status
oc get pods -l app=nodejs-app

# Describe pod for events
oc describe pod <pod-name>

# Check pod logs
oc logs <pod-name>
```

#### **Route Access Issues**
```bash
# Verify route exists
oc get routes

# Check service endpoints
oc get endpoints nodejs-app

# Test internal connectivity
oc port-forward deployment/nodejs-app 8080:8080
```

---

## **📋 Verification Steps**

### **Console Verification**
1. **Topology View**: Green circle indicates healthy application
2. **Routes**: Click route URL to access application
3. **Pods**: Should show "Running" status
4. **Builds**: Should show "Complete" status

### **CLI Verification**
```bash
# Check all resources
oc get all -l app=nodejs-app

# Test application response
curl -k https://$(oc get route nodejs-app -o jsonpath='{.spec.host}')

# Verify scaling
oc get pods -l app=nodejs-app
```

---

## **🧹 Cleanup**

### **Console Cleanup**
1. Go to **Topology** view
2. Right-click on `nodejs-app` node
3. Select **"Delete Application"**
4. Confirm deletion

### **CLI Cleanup**
```bash
# Delete all application resources
oc delete all -l app=nodejs-app

# Or delete specific resources
oc delete buildconfig/nodejs-app
oc delete imagestream/nodejs-app
oc delete deployment/nodejs-app
oc delete service/nodejs-app
oc delete route/nodejs-app
```

---

## **🎯 Learning Outcomes**
- ✅ Understand S2I build process
- ✅ Deploy applications from Git repositories
- ✅ Create and manage OpenShift routes
- ✅ Monitor builds and deployments
- ✅ Scale applications using both console and CLI
- ✅ Troubleshoot common deployment issues

## **📚 Next Steps**
- Explore different Node.js frameworks
- Add environment variables to the application
- Set up webhooks for automatic builds
- Configure health checks and readiness probes

---

**Duration:** 20 minutes  
**Difficulty:** Beginner  
**Focus:** Source-to-Image builds and application management
