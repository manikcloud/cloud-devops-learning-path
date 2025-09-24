# 🎓 **OpenShift Basic Tutorial - Hands-On Learning**

<div align="center">

![Tutorial](https://img.shields.io/badge/Tutorial-Basic-green?style=for-the-badge&logo=openshift&logoColor=white)
![Hands-On](https://img.shields.io/badge/Hands--On-Learning-blue?style=for-the-badge&logo=graduation-cap&logoColor=white)

**🎯 Learn by Doing | 🚀 Deploy Real Apps | 📊 See Results**

</div>

---

## 🎯 **Tutorial Overview**

This tutorial teaches OpenShift basics through **hands-on exercises**. You'll deploy real applications and see how OpenShift works.

### **What You'll Learn:**
- ✅ **Deploy applications** from container images
- ✅ **Expose services** to the internet
- ✅ **Scale applications** up and down
- ✅ **Build from source code** using S2I
- ✅ **Manage with web console** and CLI

### **Prerequisites:**
- Access to OpenShift cluster (Sandbox, Local, or Cloud)
- Basic understanding of containers
- Web browser for console access

---

## 🚀 **Exercise 1: Deploy Your First App**

### **Goal:** Deploy a simple web application

```bash
# Login to your OpenShift cluster
oc login [your-cluster-url]

# Create a new project
oc new-project my-first-app

# Deploy application from container image
oc new-app --name hello-world \
  --docker-image=quay.io/openshift/hello-openshift

# Check deployment status
oc get pods
oc get deployments
```

### **Expected Output:**
```
NAME                          READY   STATUS    RESTARTS   AGE
hello-world-xxxxxxxxx-xxxxx   1/1     Running   0          30s
```

---

## 🌐 **Exercise 2: Expose Your App to Internet**

### **Goal:** Make your app accessible via URL

```bash
# Expose the service
oc expose service hello-world

# Get the route URL
oc get route hello-world

# Test your application
curl http://[your-app-url]
```

### **Web Console Alternative:**
1. Go to **Topology** view
2. Click on your app
3. Click **Create Route**
4. Click the route URL to test

---

## 📈 **Exercise 3: Scale Your Application**

### **Goal:** Handle more traffic by scaling

```bash
# Scale to 3 replicas
oc scale deployment hello-world --replicas=3

# Watch pods being created
oc get pods -w

# Check load balancing
for i in {1..10}; do curl http://[your-app-url]; done
```

### **Web Console Alternative:**
1. Go to **Topology** view
2. Click on your app
3. Use **+** button to scale up
4. Use **-** button to scale down

---

## 🔨 **Exercise 4: Build from Source Code**

### **Goal:** Deploy app directly from GitHub

```bash
# Create app from source code
oc new-app https://github.com/openshift/nodejs-ex \
  --name=nodejs-app

# Watch the build process
oc logs -f bc/nodejs-app

# Expose the service
oc expose service nodejs-app

# Get the URL
oc get route nodejs-app
```

### **What Happens:**
1. **Source-to-Image (S2I)** detects Node.js
2. **Builds** container image automatically
3. **Deploys** the application
4. **Creates** service and route

---

## 📊 **Exercise 5: Monitor Your Applications**

### **Goal:** Check application health and logs

```bash
# View application logs
oc logs deployment/hello-world

# Check resource usage
oc top pods

# View events
oc get events --sort-by='.lastTimestamp'

# Describe deployment
oc describe deployment hello-world
```

### **Web Console Monitoring:**
1. Go to **Monitoring** → **Dashboards**
2. Select your project
3. View CPU, Memory, Network metrics
4. Check **Events** tab for issues

---

## 🔄 **Exercise 6: Update Your Application**

### **Goal:** Deploy new version without downtime

```bash
# Update image to new version
oc set image deployment/hello-world \
  hello-world=quay.io/openshift/hello-openshift:latest

# Watch rolling update
oc rollout status deployment/hello-world

# Check rollout history
oc rollout history deployment/hello-world

# Rollback if needed
oc rollout undo deployment/hello-world
```

---

## 🗂️ **Exercise 7: Organize with Projects**

### **Goal:** Manage multiple applications

```bash
# Create development project
oc new-project my-dev-env

# Create production project  
oc new-project my-prod-env

# Switch between projects
oc project my-dev-env
oc project my-prod-env

# List all projects
oc get projects
```

### **Project Benefits:**
- **Isolation** - Apps don't interfere
- **Resource limits** - Control usage
- **Access control** - Team permissions
- **Organization** - Logical grouping

---

## 🎯 **Exercise 8: Complete Web App Deployment**

### **Goal:** Deploy a full web application with database

```bash
# Create new project
oc new-project complete-app

# Deploy PostgreSQL database
oc new-app postgresql-persistent \
  --param DATABASE_SERVICE_NAME=postgresql \
  --param POSTGRESQL_DATABASE=sampledb \
  --param POSTGRESQL_USER=user \
  --param POSTGRESQL_PASSWORD=password

# Deploy web application
oc new-app https://github.com/openshift/django-ex \
  --name=django-app \
  --env DATABASE_SERVICE_NAME=postgresql \
  --env DATABASE_NAME=sampledb \
  --env DATABASE_USER=user \
  --env DATABASE_PASSWORD=password

# Expose the web app
oc expose service django-app

# Check everything is running
oc get pods
oc get routes
```

---

## 🛠️ **Common Commands Reference**

### **Project Management:**
```bash
oc new-project [name]          # Create project
oc project [name]              # Switch project
oc delete project [name]       # Delete project
```

### **Application Deployment:**
```bash
oc new-app [image/source]      # Deploy app
oc expose service [name]       # Create route
oc scale deployment [name] --replicas=N  # Scale
```

### **Monitoring:**
```bash
oc get pods                    # List pods
oc get services               # List services
oc get routes                 # List routes
oc logs [pod-name]            # View logs
oc describe [resource] [name] # Detailed info
```

### **Updates:**
```bash
oc set image deployment/[name] [container]=[image]  # Update image
oc rollout status deployment/[name]                 # Check update
oc rollout undo deployment/[name]                   # Rollback
```

---

## 🎓 **Learning Outcomes**

After completing this tutorial, you can:

- ✅ **Deploy applications** using images and source code
- ✅ **Expose services** with routes for external access
- ✅ **Scale applications** to handle varying loads
- ✅ **Monitor applications** using logs and metrics
- ✅ **Update applications** with zero downtime
- ✅ **Organize projects** for better management
- ✅ **Use both CLI and web console** effectively

---

## 🚀 **Next Steps**

### **Advanced Topics to Explore:**
1. **ConfigMaps & Secrets** - Manage configuration
2. **Persistent Storage** - Handle data persistence
3. **CI/CD Pipelines** - Automate deployments
4. **Custom Resources** - Extend OpenShift
5. **Operators** - Manage complex applications

### **Real Projects to Try:**
- **Blog Application** - WordPress with MySQL
- **E-commerce Site** - Multi-tier application
- **API Gateway** - Microservices architecture
- **Monitoring Stack** - Prometheus + Grafana

---

## 🎉 **Congratulations!**

You've completed the OpenShift basic tutorial! You now understand:

- **Core OpenShift concepts** through hands-on practice
- **Application deployment** patterns and best practices
- **Scaling and monitoring** applications effectively
- **Project organization** for real-world scenarios

**Ready to build production applications on OpenShift!** 🚀
