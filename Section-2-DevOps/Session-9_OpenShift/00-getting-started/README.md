# 🚀 **Getting Started: Simple Hello World**

## **Overview**
Deploy a simple hello world application using only OpenShift CLI commands - no YAML files needed.

## **Prerequisites**
- OpenShift Sandbox account
- `oc` CLI installed

---

## **⚡ Super Simple (2 commands)**

### **Step 1: Login**
```bash
# Get login command from OpenShift web console
oc login --token=<your-token> --server=<your-server>
```

### **Step 2: Deploy Hello World**
```bash
# Deploy Red Hat's HTTPD example (creates route automatically)
oc new-app httpd-example --name=hello
```

### **Step 3: Get Your URL**
```bash
# The template automatically creates a route, just get the URL
echo "Your app: https://$(oc get route httpd-example -o jsonpath='{.spec.host}')"
```

---

## **🌐 Expected Result**
Your application will be available at:
```
https://httpd-example-<your-project>.apps.<cluster-domain>
```

Wait 1-2 minutes for the build to complete, then the page will show a Red Hat HTTPD welcome page.

---

## **📋 Quick Check**
```bash
# Check if everything is running
oc get pods

# Check the route
oc get route httpd-example

# Test the app (wait for build to complete first)
curl https://$(oc get route httpd-example -o jsonpath='{.spec.host}')
```

---

## **🧹 Cleanup**
```bash
# Delete everything
oc delete all -l template=httpd-example
```

---

## **🔧 Alternative: Even Simpler Node.js**

If you want to try a different example:

```bash
# Deploy Node.js hello world
oc new-app nodejs~https://github.com/sclorg/nodejs-ex --name=node

# Expose it
oc expose svc/node

# Get URL
echo "Node.js app: https://$(oc get route node -o jsonpath='{.spec.host}')"
```

---

**Duration:** 2 minutes  
**Commands:** 2 total (login + deploy)  
**Files:** 0 (command-line only)  
**Route:** Created automatically
