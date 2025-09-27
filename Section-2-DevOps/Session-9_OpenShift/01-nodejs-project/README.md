# 🟢 **Project 1: Simple Node.js Container**

## **Overview**
Deploy a simple Node.js container on OpenShift - ultra-simple approach that works reliably.

## **Prerequisites**
- OpenShift Sandbox account
- `oc` CLI installed

---

## **⚡ Super Simple (3 commands)**

### **Step 1: Login**
```bash
oc login --token=<your-token> --server=<your-server>
```

### **Step 2: Deploy Node.js**
```bash
# Run Node.js container (like docker run)
oc run nodejs --image=registry.redhat.io/ubi8/nodejs-18 --port=8080

# Expose it
oc expose pod nodejs --port=8080

# Create HTTPS route
oc create route edge nodejs --service=nodejs
```

### **Step 3: Get URL**
```bash
echo "Node.js URL: https://$(oc get route nodejs -o jsonpath='{.spec.host}')"
```

---

## **🖥️ Web Console Method**

1. **"+Add"** → **"Container Image"**
2. **Image**: `registry.redhat.io/ubi8/nodejs-18`
3. **Name**: `nodejs`
4. **Port**: `8080`
5. Check **"Create route"**
6. **Create**

---

## **🌐 Expected Result**
- Shows Red Hat UBI Node.js welcome page
- Confirms Node.js runtime is working
- HTTPS route accessible

---

## **🧹 Cleanup**
```bash
oc delete pod,svc,route nodejs
```

---

**Duration:** 2 minutes  
**Commands:** 3 total  
**Result:** Working Node.js container with HTTPS URL
