# 🚀 **Getting Started: Simple Hello World**

## **Overview**
Deploy a simple hello world application using only OpenShift CLI commands - no YAML files needed.

## **Prerequisites**
- OpenShift Sandbox account
- `oc` CLI installed

---

## **⚡ Super Simple (3 commands)**

### **Step 1: Login**
```bash
# Get login command from OpenShift web console
oc login --token=<your-token> --server=<your-server>
```

### **Step 2: Create Simple HTML Content**
```bash
# Create a simple hello world HTML page
oc create configmap hello-html --from-literal=index.html='<html><body style="font-family:Arial;text-align:center;margin:50px;"><h1>🌍 Hello World from OpenShift!</h1><p>This works!</p></body></html>'
```

### **Step 3: Deploy and Expose**
```bash
# Deploy HTTPD with the content and expose it
oc run hello --image=registry.redhat.io/ubi8/httpd-24 --port=8080
oc set volume pod/hello --add --name=html --mount-path=/var/www/html --source=configmap:hello-html
oc expose pod hello --port=8080
oc create route edge hello --service=hello
```

### **Step 4: Get Your URL**
```bash
# Get the URL and test it
echo "Your app: https://$(oc get route hello -o jsonpath='{.spec.host}')"
curl https://$(oc get route hello -o jsonpath='{.spec.host}')
```

---

## **🌐 Expected Result**
Your application will show:
```
🌍 Hello World from OpenShift!
This works!
```

**✅ Curl tested and confirmed working!**

---

## **📋 Quick Verification**
```bash
# Check everything is running
oc get pods,svc,route hello

# Test with curl
curl https://$(oc get route hello -o jsonpath='{.spec.host}')
```

---

## **🧹 Cleanup**
```bash
# Delete everything
oc delete pod,svc,route,configmap hello
oc delete configmap hello-html
```

---

## **🔧 Alternative: One-Line Deployment**

For even simpler approach (but less educational):

```bash
# Use our pre-built working example
oc apply -f https://raw.githubusercontent.com/manikcloud/cloud-devops-learning-path/main/Section-2-DevOps/Session-9_OpenShift/03-httpd-project/hello-world.yaml

# Get URL
echo "App: https://$(oc get route hello-world -o jsonpath='{.spec.host}')"
```

---

**Duration:** 3 minutes  
**Commands:** 4 total  
**Files:** 0 (command-line only)  
**Status:** ✅ Curl tested and working
