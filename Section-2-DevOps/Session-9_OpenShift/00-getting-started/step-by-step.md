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

### **Deploy varunmanikhttpd:blue**
```bash
# Switch to your dev project
oc project <your-username>-dev

# Deploy the custom image
oc new-app --name=blue-web --image=varunmanikhttpd:blue

# Check deployment status
oc get pods
oc logs -f deployment/blue-web
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
```bash
# Pod not starting
oc describe pod <pod-name>
oc logs <pod-name>

# Image pull issues
oc describe deployment blue-web

# Route not accessible
oc get routes
oc describe route blue-web
```

### **Cleanup**
```bash
# Delete everything
oc delete all -l app=blue-web
```

## **Success Criteria**
- ✅ Successfully logged into OpenShift CLI
- ✅ Deployed varunmanikhttpd:blue image
- ✅ Created public route
- ✅ Accessed application via browser
- ✅ Verified all resources are running
