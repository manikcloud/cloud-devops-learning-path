# 🚀 **Getting Started: Simple Hello World**

## **Overview**
Deploy a simple hello world application using OpenShift - like `docker run` but with automatic HTTPS URLs.

## **Prerequisites**
- OpenShift Sandbox account
- `oc` CLI installed (for CLI method)

---

## **⌨️ Method 1: CLI (3 commands)**

### **Step 1: Login**
```bash
# Get login command from OpenShift web console
oc login --token=<your-token> --server=<your-server>
```

### **Step 2: Deploy (like docker run)**
```bash
# Run a simple HTTPD container
oc run hello --image=registry.access.redhat.com/ubi8/httpd-24 --port=8080

# Expose it to get a service
oc expose pod hello --port=8080

# Create HTTPS route for external access
oc create route edge hello --service=hello
```

### **Step 3: Get Your URL**
```bash
# Get the public HTTPS URL
echo "Your app: https://$(oc get route hello -o jsonpath='{.spec.host}')"
```

### **Verification**
```bash
# Check everything is running
oc get pods,svc,route hello

# Test with curl
curl https://$(oc get route hello -o jsonpath='{.spec.host}')
```

### **Cleanup**
```bash
# Delete everything
oc delete pod,svc,route hello
```

---

## **🖥️ Method 2: Web Console (GUI)**

### **Step 1: Login to Console**
1. Open [OpenShift Console](https://console-openshift-console.apps.rm3.7wse.p1.openshiftapps.com)
2. Login with your credentials
3. Select your project (e.g., `<username>-dev`)

### **Step 2: Deploy Container**
1. Click **"+Add"** in the left sidebar
2. Select **"Container Image"** tile
3. Configure:
   - **Image Name**: `registry.access.redhat.com/ubi8/httpd-24`
   - **Application Name**: `hello-app`
   - **Name**: `hello`
   - **Target Port**: `8080`
4. Check **"Create a route to the application"**
5. Click **"Create"**

### **Step 3: Access Application**
1. Go to **Topology** view
2. Click the **route icon** (↗) on the `hello` component
3. Or go to **Networking → Routes** and click the URL

### **Step 4: Monitor Application**
1. **Topology View**: See application status (should be green circle)
2. **Workloads → Pods**: Check pod is running
3. **Networking → Routes**: View route configuration

### **Cleanup via Console**
1. Go to **Topology** view
2. Right-click on the `hello` component
3. Select **"Delete Application"**
4. Confirm deletion

---

## **🌐 Expected Result**

Your application will be available at:
```
https://hello-<your-project>.apps.<cluster-domain>
```

The page will show:
- Apache HTTP Server test page
- Red Hat branding
- Server information

---

## **📋 Quick Comparison**

| Step | CLI Command | GUI Action |
|------|-------------|------------|
| **Deploy** | `oc run hello --image=...` | "+Add" → "Container Image" |
| **Expose** | `oc expose pod hello` | Check "Create route" box |
| **Route** | `oc create route edge` | Automatic with checkbox |
| **Access** | `oc get route` | Click route icon in Topology |

---

## **🔧 Troubleshooting**

### **Pod Not Starting**
```bash
# CLI: Check pod status
oc describe pod hello

# GUI: Go to Workloads → Pods → click pod name → Events tab
```

### **Route Not Working**
```bash
# CLI: Check route
oc describe route hello

# GUI: Go to Networking → Routes → click route name
```

### **Application Not Loading**
```bash
# CLI: Check if pod is ready
oc get pods hello

# GUI: Topology view should show green circle
```

---

## **🎯 Learning Outcomes**
- ✅ Deploy containers like `docker run` but with HTTPS
- ✅ Understand OpenShift pods, services, and routes
- ✅ Use both CLI and Web Console
- ✅ Access applications via public URLs
- ✅ Basic troubleshooting skills

---

**Duration:** 5 minutes  
**Difficulty:** Beginner  
**Commands:** 3 total (CLI) or 0 (GUI)  
**Result:** Working HTTPS application URL
