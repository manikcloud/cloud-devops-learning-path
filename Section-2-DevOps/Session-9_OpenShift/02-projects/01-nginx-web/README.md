# 🌐 **Project 1: Simple Web Server**

## **Goal:** Deploy nginx in 2 minutes

### **Commands:**
```bash
# Use existing project
oc project [your-username]-dev

# Deploy nginx
oc new-app --name=my-nginx --docker-image=nginx:alpine

# Expose to internet
oc expose service my-nginx

# Get URL
oc get route my-nginx
```

### **Expected Result:**
✅ Nginx welcome page at: `http://my-nginx-[project].apps.rm3.7wse.p1.openshiftapps.com`

### **Clean Up:**
```bash
oc delete all --selector app=my-nginx
```
