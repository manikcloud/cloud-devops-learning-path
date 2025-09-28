# 🟢 **Node.js Application on OpenShift**

## **Overview**
Deploy a Node.js application using OpenShift Devfile (Docker build strategy).

## **Prerequisites**
- OpenShift Sandbox account
- `oc` CLI installed

---

## **⚡ Quick Deploy (3 commands)**

### **Step 1: Login**
```bash
oc login --token=sha256~t__5g4MigprS-Fu3Tx9FCQeH-7XAYe2jeCdpznUJ8xA --server=https://api.rm3.7wse.p1.openshiftapps.com:6443
```

### **Step 2: Create Node.js App (Devfile)**
```bash
oc new-app https://github.com/nodeshift-starters/devfile-sample.git --name=nodejs-app --strategy=docker
```

### **Step 3: Expose Service**
```bash
oc expose svc/nodejs-app
```

### **Step 4: Get URL**
```bash
echo "🟢 Node.js URL: https://$(oc get route nodejs-app -o jsonpath='{.spec.host}')"
```

---

## **📊 Monitor Deployment**

### **Check Build Progress (Wait 1-2 minutes)**
```bash
# Watch build logs
oc logs -f bc/nodejs-app

# Check build status
oc get builds

# Wait for build to complete
sleep 90 && oc get builds
```

### **Check Application Status**
```bash
# View pods (should show Running after build completes)
oc get pods -l app=nodejs-app

# Check deployment
oc get deployment nodejs-app

# Get route URL
oc get route nodejs-app
```

### **⚠️ Important: Build takes 1-2 minutes**
The application won't be available immediately. Wait for:
1. Build to complete (`oc get builds` shows "Complete")
2. Pod to start (`oc get pods` shows "Running")
3. Then test the URL

---

## **🔧 Alternative Methods**

### **Method 2: Using Web Console**
1. Login to OpenShift Web Console
2. Click **"+Add"** → **"From Git"**
3. **Git Repo URL**: `https://github.com/nodeshift-starters/devfile-sample.git`
4. **Build Strategy**: Docker
5. **Application Name**: `nodejs-app`
6. Click **"Create"**

### **Method 3: Import from Devfile**
```bash
# Use devfile directly
oc new-app --name=nodejs-app \
  --docker-image=registry.access.redhat.com/ubi8/nodejs-16 \
  https://github.com/nodeshift-starters/devfile-sample.git

# Expose service
oc expose svc/nodejs-app
```

---

## **🌐 Expected Result**
- **Live Node.js Application**: "Hello from Node.js Starter Application!"
- **Build Time**: ~1-2 minutes (Docker build)
- **Features**: Simple Node.js web server
- **URL Format**: `https://nodejs-app-<project>-<cluster-domain>`
- **Working Example**: https://devfile-sample-git-varunmanik1-dev.apps.rm3.7wse.p1.openshiftapps.com/

---

## **🧹 Cleanup**
```bash
# Delete application
oc delete all -l app=nodejs-app

# Or delete specific resources
oc delete deployment,svc,route,bc,is nodejs-app
```

---

## **🔍 Troubleshooting**

### **"Application is not available" Error**
This is normal during deployment. Follow these steps:

```bash
# 1. Check if build is still running
oc get builds
# Status should be "Complete" (not "Running")

# 2. Check if pod is running
oc get pods -l app=nodejs-app
# Status should be "Running" (not "ContainerCreating")

# 3. If build is still running, wait 1-2 minutes
sleep 120 && oc get builds && oc get pods

# 4. Test URL only after pod is Running
curl https://$(oc get route nodejs-app -o jsonpath='{.spec.host}')
```

### **Build Issues**
```bash
# Check build logs
oc logs build/nodejs-app-1

# Describe build config
oc describe bc/nodejs-app
```

### **Pod Issues**
```bash
# Check pod logs
oc logs deployment/nodejs-app

# Debug pod
oc debug deployment/nodejs-app
```

---

**Duration:** 2-3 minutes  
**Result:** Working Node.js application with Docker build  
**Repository:** https://github.com/manikcloud/cloud-devops-learning-path/tree/main/Section-2-DevOps/Session-9_OpenShift/01-nodejs-project
