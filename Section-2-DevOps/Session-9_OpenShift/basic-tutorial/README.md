# 🚀 **OpenShift Simple Projects - Step-by-Step Runbooks**

<div align="center">

![OpenShift](https://img.shields.io/badge/OpenShift-Sandbox-red?style=for-the-badge&logo=redhat&logoColor=white)
![Projects](https://img.shields.io/badge/3%20Simple-Projects-green?style=for-the-badge&logo=rocket&logoColor=white)

**🎯 Copy-Paste Commands | 📋 Step-by-Step | ✅ Guaranteed Results**

</div>

---

## 🌐 **Using OpenShift Sandbox**

**Cluster URL:** https://console-openshift-console.apps.rm3.7wse.p1.openshiftapps.com

### **Quick Access:**
1. **Login** to OpenShift Sandbox
2. **Copy-paste** commands below
3. **See results** immediately

---

## 📋 **Project 1: Simple Web Server**

### **Goal:** Deploy nginx web server in 2 minutes

#### **Step 1: Login via CLI**
```bash
# Get login command from web console (top-right menu → Copy login command)
oc login --token=sha256~[your-token] --server=https://api.rm3.7wse.p1.openshiftapps.com:6443
```

#### **Step 2: Create Project**
```bash
oc new-project simple-web-$(date +%s)
```

#### **Step 3: Deploy Nginx**
```bash
oc new-app --name=my-nginx --docker-image=nginx:alpine
```

#### **Step 4: Expose to Internet**
```bash
oc expose service my-nginx
```

#### **Step 5: Get URL and Test**
```bash
oc get route my-nginx
# Copy the URL and open in browser
```

### **✅ Expected Result:**
- Nginx welcome page loads in browser
- URL format: `http://my-nginx-[project-name].apps.rm3.7wse.p1.openshiftapps.com`

---

## 📋 **Project 2: Node.js App from GitHub**

### **Goal:** Deploy real application from source code

#### **Step 1: Create New Project**
```bash
oc new-project nodejs-app-$(date +%s)
```

#### **Step 2: Deploy from GitHub**
```bash
oc new-app https://github.com/openshift/nodejs-ex --name=nodejs-demo
```

#### **Step 3: Watch Build Process**
```bash
oc logs -f bc/nodejs-demo
# Wait for "Push successful" message
```

#### **Step 4: Expose Service**
```bash
oc expose service nodejs-demo
```

#### **Step 5: Get URL and Test**
```bash
oc get route nodejs-demo
# Open URL in browser
```

### **✅ Expected Result:**
- Node.js welcome page with OpenShift logo
- Build logs show successful image creation
- URL format: `http://nodejs-demo-[project-name].apps.rm3.7wse.p1.openshiftapps.com`

---

## 📋 **Project 3: Python Web App with Database**

### **Goal:** Full-stack application with PostgreSQL

#### **Step 1: Create Project**
```bash
oc new-project python-db-$(date +%s)
```

#### **Step 2: Deploy PostgreSQL Database**
```bash
oc new-app postgresql-ephemeral \
  --param=DATABASE_SERVICE_NAME=postgresql \
  --param=POSTGRESQL_DATABASE=sampledb \
  --param=POSTGRESQL_USER=dbuser \
  --param=POSTGRESQL_PASSWORD=dbpass123
```

#### **Step 3: Deploy Python App**
```bash
oc new-app https://github.com/openshift/django-ex \
  --name=python-app \
  --env=DATABASE_SERVICE_NAME=postgresql \
  --env=DATABASE_NAME=sampledb \
  --env=DATABASE_USER=dbuser \
  --env=DATABASE_PASSWORD=dbpass123
```

#### **Step 4: Wait for Build**
```bash
oc logs -f bc/python-app
# Wait for build completion
```

#### **Step 5: Expose Python App**
```bash
oc expose service python-app
```

#### **Step 6: Get URL and Test**
```bash
oc get route python-app
# Open URL in browser
```

### **✅ Expected Result:**
- Django welcome page loads
- Database connection working
- URL format: `http://python-app-[project-name].apps.rm3.7wse.p1.openshiftapps.com`

---

## 🔍 **Quick Troubleshooting**

### **If Build Fails:**
```bash
oc get pods
oc logs [build-pod-name]
```

### **If App Won't Start:**
```bash
oc get pods
oc describe pod [pod-name]
oc logs [pod-name]
```

### **If Route Not Working:**
```bash
oc get routes
oc get services
```

---

## 🎯 **Web Console Alternative**

### **For Visual Learners:**

#### **Deploy via Web Console:**
1. **Go to:** Developer perspective
2. **Click:** +Add
3. **Choose:** Container Image or Git Repository
4. **Fill:** Image name or Git URL
5. **Click:** Create
6. **Wait:** For deployment
7. **Click:** Route URL to test

#### **Monitor via Web Console:**
1. **Go to:** Topology view
2. **Click:** Your application
3. **View:** Logs, Events, Details
4. **Scale:** Using +/- buttons

---

## 📊 **Useful Commands**

### **Check Everything:**
```bash
oc get all                    # All resources
oc get pods                   # Running containers
oc get routes                 # External URLs
oc get builds                 # Build status
```

### **Clean Up:**
```bash
oc delete project [project-name]    # Delete entire project
oc delete all --selector app=[name] # Delete specific app
```

### **Scale Applications:**
```bash
oc scale deployment [name] --replicas=3  # Scale to 3 pods
oc scale deployment [name] --replicas=1  # Scale back to 1
```

---

## 🎉 **Success Checklist**

After completing all 3 projects:

- ✅ **Project 1:** Nginx web server accessible via browser
- ✅ **Project 2:** Node.js app built from GitHub source
- ✅ **Project 3:** Python app connected to PostgreSQL database

### **You Now Know:**
- ✅ How to deploy container images
- ✅ How to build from source code
- ✅ How to connect apps to databases
- ✅ How to expose apps to internet
- ✅ How to use both CLI and web console

---

## 🚀 **Next Steps**

### **Try These Variations:**
- **Different images:** `httpd`, `redis`, `mysql`
- **Different languages:** PHP, Java, Go applications
- **Scale applications:** Increase replicas for load handling
- **Add monitoring:** Check resource usage and logs

### **Real-World Practice:**
- Deploy your own GitHub repository
- Connect multiple services together
- Set up environment variables
- Configure health checks

**You're now ready to deploy real applications on OpenShift!** 🎓
