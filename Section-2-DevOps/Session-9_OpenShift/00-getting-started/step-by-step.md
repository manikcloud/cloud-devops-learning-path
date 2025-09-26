# 📖 **Step-by-Step Guide: Project 0**

## **Step 1: Get OpenShift Access**

### **Get OpenShift Sandbox**
1. Go to: https://developers.redhat.com/developer-sandbox
2. Sign up with Red Hat account
3. Get your login token

### **Install OpenShift CLI**
```bash
# Linux/Mac
curl -LO https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable/openshift-client-linux.tar.gz
tar -xzf openshift-client-linux.tar.gz
sudo mv oc /usr/local/bin/

# Verify installation
oc version
```

## **Step 2: Login to OpenShift**

### **Get Login Command**
1. Login to OpenShift web console
2. Click your name (top right) → "Copy login command"
3. Click "Display Token"
4. Copy the `oc login` command

### **Login via CLI**
```bash
# Example (use your actual token and server)
oc login --token=sha256~aNqJc0fiJgSXevTAYcrYnTClCSJv0PczCl1vz4h3-qY --server=https://api.rm3.7wse.p1.openshiftapps.com:6443

# Check login status
oc whoami
oc get projects
```

## **Step 3: Deploy Custom Image**

### **Method 1: Deploy varunmanik/httpd:blue (May need security context)**
```bash
# Switch to your dev project
oc project <your-username>-dev

# Try deploying the custom image
oc new-app --name=blue-web varunmanik/httpd:blue

# If it fails due to port 80 permissions, check logs
oc logs -l deployment=blue-web
```

### **Method 2: Alternative Working Image**
```bash
# If the above fails, use this working alternative
oc delete all -l app=blue-web
oc new-app --name=blue-web nginx:alpine
```

## **Step 4: Expose Application**

### **Create Route for Public Access**
```bash
# Expose the service
oc expose svc/blue-web

# Get the public URL
oc get routes

# Or get URL directly
echo "Your app: http://$(oc get route blue-web -o jsonpath='{.spec.host}')"
```

## **Step 5: Test Your Application**

### **Access Your App**
```bash
# Test with curl
curl http://$(oc get route blue-web -o jsonpath='{.spec.host}')

# Or open in browser
echo "Open: http://$(oc get route blue-web -o jsonpath='{.spec.host}')"
```

## **Step 6: Verify Everything Works**

### **Check All Resources**
```bash
# List all resources
oc get all

# Check specific resources
oc get deployment blue-web
oc get service blue-web
oc get route blue-web
oc get pods -l deployment=blue-web
```

## **Troubleshooting**

### **Common Issues**

**1. Permission Denied on Port 80**
```bash
# Issue: httpd can't bind to port 80 (needs root)
# Solution: Use OpenShift-compatible images or add security context

# Check logs
oc logs -l deployment=blue-web

# Alternative: Use nginx which works better in OpenShift
oc delete all -l app=blue-web
oc new-app --name=blue-web nginx:alpine
oc expose svc/blue-web
```

**2. Pod Not Starting**
```bash
# Check pod status
oc describe pod <pod-name>
oc logs <pod-name>

# Check events
oc get events --sort-by=.metadata.creationTimestamp
```

**3. Route Not Accessible**
```bash
# Check route
oc get routes
oc describe route blue-web

# Verify service endpoints
oc get endpoints blue-web
```

### **Working Commands Summary**
```bash
# Login
oc login --token=<token> --server=<server>

# Deploy (use nginx if httpd fails)
oc new-app --name=blue-web nginx:alpine

# Expose
oc expose svc/blue-web

# Get URL
echo "App URL: http://$(oc get route blue-web -o jsonpath='{.spec.host}')"

# Cleanup
oc delete all -l app=blue-web
```

## **Success Criteria**
- ✅ Successfully logged into OpenShift CLI
- ✅ Deployed web application (httpd or nginx)
- ✅ Created public route
- ✅ Accessed application via browser
- ✅ Verified all resources are running

## **Note on varunmanik/httpd:blue**
This image may require additional security context configuration in OpenShift due to port 80 binding restrictions. For learning purposes, nginx:alpine works reliably in OpenShift Sandbox environment.
