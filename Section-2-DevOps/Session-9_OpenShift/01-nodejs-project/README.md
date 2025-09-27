# 🟢 **Project 1: Node.js Application Deployment**

## **Overview**
Deploy a Node.js Express application on OpenShift using ConfigMaps and Red Hat UBI images. This project demonstrates both Web Console and CLI deployment methods.

## **Learning Objectives**
- Deploy Node.js applications on OpenShift
- Use ConfigMaps to manage application code
- Understand container-based Node.js deployment
- Create HTTPS routes for Node.js services

## **Prerequisites**
- OpenShift Sandbox account
- `oc` CLI installed and logged in
- Basic understanding of Node.js and Express

---

## **⌨️ Method 1: CLI Steps**

### **Step 1: Login and Setup**
```bash
# Login to OpenShift
oc login --token=<your-token> --server=<your-server>

# Verify current project
oc project
```

### **Step 2: Deploy Application**
```bash
# Deploy the Node.js application
oc apply -f nodejs-app.yaml

# Monitor deployment
oc rollout status deployment/nodejs-app
```

### **Step 3: Access Application**
```bash
# Get the route URL
oc get route nodejs-app

# Display full URL
echo "Node.js App: https://$(oc get route nodejs-app -o jsonpath='{.spec.host}')"

# Test the application
curl https://$(oc get route nodejs-app -o jsonpath='{.spec.host}')
```

### **Step 4: Monitor and Manage**
```bash
# Check application status
oc get all -l app=nodejs-app

# View logs
oc logs -f deployment/nodejs-app

# Scale application
oc scale deployment/nodejs-app --replicas=2
```

---

## **🖥️ Method 2: Web Console Steps**

### **Step 1: Create ConfigMap**
1. Login to [OpenShift Console](https://console-openshift-console.apps.rm3.7wse.p1.openshiftapps.com)
2. Go to **Workloads → ConfigMaps**
3. Click **"Create ConfigMap"**
4. Name: `nodejs-app`
5. Add keys: `package.json` and `server.js` (copy from YAML file)
6. Click **"Create"**

### **Step 2: Deploy Application**
1. Go to **"+Add"** → **"Container Image"**
2. Configure:
   - **Image Name**: `registry.redhat.io/ubi8/nodejs-18`
   - **Application Name**: `nodejs-app`
   - **Name**: `nodejs-app`
   - **Target Port**: `8080`
3. Click **"Create"**

### **Step 3: Mount ConfigMap**
1. Go to **Workloads → Deployments**
2. Click `nodejs-app` deployment
3. Go to **Environment** tab
4. Add Volume: ConfigMap `nodejs-app` → Mount Path `/app`
5. Update Command: `/bin/bash -c "cd /app && npm install && npm start"`
6. Save changes

### **Step 4: Create Route**
1. Go to **Networking → Services**
2. Click `nodejs-app` service
3. Click **"Create Route"**
4. Enable **"Secure Route"** (HTTPS)
5. Click **"Create"**

---

## **🔧 Alternative: Simple CLI Method**

For a quicker deployment without YAML files:

```bash
# Create ConfigMap with Node.js code
oc create configmap nodejs-code \
  --from-literal=package.json='{"name":"hello","version":"1.0.0","main":"server.js","scripts":{"start":"node server.js"},"dependencies":{"express":"^4.18.0"}}' \
  --from-literal=server.js='const express = require("express"); const app = express(); app.get("/", (req, res) => res.send("<h1>Hello from Node.js on OpenShift!</h1>")); app.listen(8080, "0.0.0.0", () => console.log("Server running"));'

# Deploy Node.js container
oc run nodejs --image=registry.redhat.io/ubi8/nodejs-18 --port=8080

# Mount the code
oc set volume pod/nodejs --add --name=code --mount-path=/app --source=configmap:nodejs-code

# Set startup command
oc patch pod nodejs --patch='{"spec":{"containers":[{"name":"nodejs","command":["/bin/bash","-c","cd /app && npm install && npm start"]}]}}'

# Expose the application
oc expose pod nodejs --port=8080
oc create route edge nodejs --service=nodejs
```

---

## **🔧 Troubleshooting Guide**

### **Common Issues**

#### **1. Pod CrashLoopBackOff**
```bash
# Check pod logs
oc logs -f deployment/nodejs-app

# Common causes:
# - npm install failures
# - Missing dependencies
# - Port binding issues
```

#### **2. Application Not Starting**
```bash
# Check container events
oc describe pod -l app=nodejs-app

# Verify ConfigMap content
oc describe configmap nodejs-app

# Check if files are mounted
oc exec -it deployment/nodejs-app -- ls -la /app
```

#### **3. Route Not Accessible**
```bash
# Verify route exists
oc get routes

# Check service endpoints
oc get endpoints nodejs-app

# Test internal connectivity
oc port-forward deployment/nodejs-app 8080:8080
```

#### **4. npm Install Issues**
```bash
# Check if npm is available
oc exec -it deployment/nodejs-app -- npm --version

# Manually install dependencies
oc exec -it deployment/nodejs-app -- bash -c "cd /app && npm install"
```

---

## **📋 Verification Steps**

### **✅ Deployment Verification**
- [ ] ConfigMap `nodejs-app` created with package.json and server.js
- [ ] Deployment `nodejs-app` is running (1/1 Ready)
- [ ] Service `nodejs-app` has endpoints
- [ ] Route `nodejs-app` is created with HTTPS
- [ ] Pod logs show "Node.js app listening on port 8080"

### **✅ Application Verification**
- [ ] URL is accessible in browser
- [ ] Page shows "Node.js Hello World!"
- [ ] Green styling is applied
- [ ] Pod hostname is displayed
- [ ] HTTPS lock icon appears in browser

### **✅ Functionality Tests**
```bash
# Test application response
curl -s https://$(oc get route nodejs-app -o jsonpath='{.spec.host}') | grep "Node.js Hello World"

# Check if Express is working
curl -I https://$(oc get route nodejs-app -o jsonpath='{.spec.host}')
```

---

## **🎯 Learning Exercises**

### **Exercise 1: Add New Route**
```bash
# Add a new route to the Express app
oc patch configmap nodejs-app --patch='{"data":{"server.js":"const express = require(\"express\"); const app = express(); app.get(\"/\", (req, res) => res.send(\"<h1>Home</h1>\")); app.get(\"/about\", (req, res) => res.send(\"<h1>About Page</h1>\")); app.listen(8080, \"0.0.0.0\");"}}'

# Restart deployment
oc rollout restart deployment/nodejs-app
```

### **Exercise 2: Add Environment Variables**
```bash
# Add environment variable
oc set env deployment/nodejs-app NODE_ENV=production

# Use in application
# Update server.js to use process.env.NODE_ENV
```

### **Exercise 3: Scale the Application**
```bash
# Scale to multiple replicas
oc scale deployment/nodejs-app --replicas=3

# Verify load balancing
for i in {1..10}; do curl -s https://$(oc get route nodejs-app -o jsonpath='{.spec.host}') | grep -o "Pod: [^<]*"; done
```

---

## **🧹 Cleanup**

### **Complete Cleanup**
```bash
# Delete all application resources
oc delete -f nodejs-app.yaml

# Verify cleanup
oc get all -l app=nodejs-app
```

### **Individual Resource Cleanup**
```bash
# Delete specific resources
oc delete deployment nodejs-app
oc delete service nodejs-app
oc delete route nodejs-app
oc delete configmap nodejs-app
```

---

## **🎯 Learning Outcomes**
- ✅ Deploy Node.js applications using ConfigMaps
- ✅ Use Red Hat UBI Node.js images
- ✅ Manage application code in OpenShift
- ✅ Configure Express.js applications for containers
- ✅ Create and manage HTTPS routes
- ✅ Scale Node.js applications
- ✅ Troubleshoot container-based Node.js deployments

## **📚 Next Steps**
- Add persistent storage for file uploads
- Implement health checks and readiness probes
- Connect to databases (MongoDB, PostgreSQL)
- Set up CI/CD pipelines for Node.js
- Explore OpenShift Source-to-Image (S2I) builds

---

**Duration:** 20 minutes  
**Difficulty:** Beginner to Intermediate  
**Focus:** Container-based Node.js deployment with ConfigMaps
