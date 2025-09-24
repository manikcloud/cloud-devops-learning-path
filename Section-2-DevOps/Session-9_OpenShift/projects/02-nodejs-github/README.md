# 🚀 **Project 2: Node.js from GitHub**

## **Goal:** Build and deploy from source code

### **Commands:**
```bash
# Deploy from GitHub
oc new-app https://github.com/openshift/nodejs-ex --name=nodejs-demo

# Watch build
oc logs -f bc/nodejs-demo

# Expose service
oc expose service nodejs-demo

# Get URL
oc get route nodejs-demo
```

### **Expected Result:**
✅ Node.js app at: `http://nodejs-demo-[project].apps.rm3.7wse.p1.openshiftapps.com`

### **Clean Up:**
```bash
oc delete all --selector app=nodejs-demo
```
