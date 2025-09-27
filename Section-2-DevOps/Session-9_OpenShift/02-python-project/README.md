# 🐍 **Project 2: Python Django Application**

## **Overview**
Deploy a Python Django application with database using OpenShift templates and S2I builds through both Web Console and CLI.

## **Learning Objectives**
- Deploy multi-tier applications (web + database)
- Use OpenShift templates for complex deployments
- Manage environment variables and secrets
- Understand service-to-service communication

---

## **🖥️ Method 1: Web Console Steps**

### **Step 1: Access Developer Catalog**
1. Open [OpenShift Console](https://console-openshift-console.apps.rm3.7wse.p1.openshiftapps.com)
2. Login and select your project
3. Click **"+Add"** → **"Developer Catalog"**
4. Search for **"Django + PostgreSQL"**

### **Step 2: Deploy from Template**
1. Click **"Django + PostgreSQL (Ephemeral)"** template
2. Click **"Instantiate Template"**
3. Configure parameters:
   - **Name**: `python-django`
   - **Git Repository URL**: `https://github.com/sclorg/django-ex`
   - **Database Service Name**: `postgresql`
   - **Database Name**: `default`
   - **Database User**: `django`
   - **Database Password**: `django123` (or auto-generate)
4. Click **"Create"**

### **Step 3: Monitor Deployment**
1. Go to **Topology** view
2. You'll see two components:
   - `python-django` (web application)
   - `postgresql` (database)
3. Monitor build progress by clicking on the build icon
4. Wait for both components to show green status

### **Step 4: Access Application**
1. Click the route icon (↗) on the `python-django` component
2. Or navigate to **Networking → Routes**
3. Click the application URL

### **Step 5: Explore Database Connection**
1. Go to **Workloads → Secrets**
2. Find `python-django` secret with database credentials
3. Go to **Workloads → ConfigMaps** to see configuration
4. Check **Topology** view for service connections

---

## **⌨️ Method 2: CLI Steps**

### **Step 1: Login and Explore Templates**
```bash
# Login to OpenShift
oc login --token=<your-token> --server=<your-server>

# List available templates
oc get templates -n openshift | grep django

# Get template details
oc describe template django-psql-example -n openshift
```

### **Step 2: Deploy from Template**
```bash
# Deploy Django + PostgreSQL application
oc new-app --template=django-psql-example \
  --param=NAME=python-django \
  --param=SOURCE_REPOSITORY_URL=https://github.com/sclorg/django-ex \
  --param=DATABASE_SERVICE_NAME=postgresql \
  --param=DATABASE_NAME=default \
  --param=DATABASE_USER=django \
  --param=DATABASE_PASSWORD=django123

# Monitor the build
oc logs -f buildconfig/python-django
```

### **Step 3: Check Deployment Status**
```bash
# Check all resources
oc get all -l app=python-django

# Check database pod
oc get pods -l name=postgresql

# Check services
oc get svc
```

### **Step 4: Access Application**
```bash
# Get route URL
oc get route python-django
echo "Django App: https://$(oc get route python-django -o jsonpath='{.spec.host}')"

# Test application
curl -k https://$(oc get route python-django -o jsonpath='{.spec.host}')
```

---

## **🔧 Advanced Configuration**

### **Environment Variables Management**

#### **Console Method**
1. Go to **Workloads → Deployments**
2. Click on `python-django` deployment
3. Go to **Environment** tab
4. Add/modify environment variables
5. Save changes (triggers automatic redeployment)

#### **CLI Method**
```bash
# View current environment variables
oc set env deployment/python-django --list

# Add environment variable
oc set env deployment/python-django DEBUG=True

# Add from secret
oc set env deployment/python-django --from=secret/python-django

# Remove environment variable
oc set env deployment/python-django DEBUG-
```

### **Database Management**

#### **Connect to Database**
```bash
# Get database pod name
DB_POD=$(oc get pods -l name=postgresql -o jsonpath='{.items[0].metadata.name}')

# Connect to PostgreSQL
oc exec -it $DB_POD -- psql -U django -d default

# Or use port forwarding
oc port-forward $DB_POD 5432:5432
# Then connect locally: psql -h localhost -U django -d default
```

#### **Database Operations**
```sql
-- Inside PostgreSQL shell
\dt                    -- List tables
SELECT * FROM auth_user;  -- View Django users
\q                     -- Quit
```

---

## **🔧 Troubleshooting**

### **Build Issues**
```bash
# Check build logs
oc logs -f build/python-django-1

# Check build configuration
oc describe buildconfig/python-django

# Restart build
oc start-build python-django
```

### **Database Connection Issues**
```bash
# Check database pod logs
oc logs -l name=postgresql

# Check database service
oc describe svc postgresql

# Test database connectivity from app pod
APP_POD=$(oc get pods -l app=python-django -o jsonpath='{.items[0].metadata.name}')
oc exec -it $APP_POD -- nc -zv postgresql 5432
```

### **Application Issues**
```bash
# Check application logs
oc logs -f deployment/python-django

# Check pod events
oc describe pod -l app=python-django

# Check secrets and configmaps
oc get secrets,configmaps
```

---

## **📋 Verification Steps**

### **Console Verification**
1. **Topology**: Both components show green status
2. **Routes**: Django application accessible via URL
3. **Pods**: All pods in "Running" state
4. **Builds**: Build completed successfully
5. **Secrets**: Database credentials properly configured

### **CLI Verification**
```bash
# Check all resources
oc get all

# Verify database connection
oc exec -it deployment/python-django -- python manage.py dbshell

# Check application health
curl -k https://$(oc get route python-django -o jsonpath='{.spec.host}')/health
```

---

## **🧹 Cleanup**

### **Console Cleanup**
1. Go to **Topology** view
2. Select both `python-django` and `postgresql` components
3. Right-click and select **"Delete Application"**
4. Confirm deletion

### **CLI Cleanup**
```bash
# Delete all template resources
oc delete all,secrets,configmaps -l template=django-psql-example

# Or delete individual components
oc delete all -l app=python-django
oc delete all -l name=postgresql
oc delete secret python-django
```

---

## **🎯 Learning Outcomes**
- ✅ Deploy multi-tier applications using templates
- ✅ Manage database connections and secrets
- ✅ Configure environment variables
- ✅ Understand service-to-service communication
- ✅ Monitor and troubleshoot complex deployments
- ✅ Perform database operations in containerized environments

## **📚 Next Steps**
- Add persistent storage for the database
- Configure application health checks
- Set up horizontal pod autoscaling
- Implement CI/CD pipelines with webhooks
- Explore Django admin interface

---

**Duration:** 30 minutes  
**Difficulty:** Intermediate  
**Focus:** Multi-tier application deployment and database integration
