# 🐍 **Project 3: Python + Database**

## **Goal:** Full-stack app with PostgreSQL

### **Commands:**
```bash
# Deploy database
oc new-app postgresql-ephemeral \
  --param=DATABASE_SERVICE_NAME=postgresql \
  --param=POSTGRESQL_DATABASE=sampledb \
  --param=POSTGRESQL_USER=dbuser \
  --param=POSTGRESQL_PASSWORD=dbpass123

# Deploy Python app
oc new-app https://github.com/openshift/django-ex \
  --name=python-app \
  --env=DATABASE_SERVICE_NAME=postgresql \
  --env=DATABASE_NAME=sampledb \
  --env=DATABASE_USER=dbuser \
  --env=DATABASE_PASSWORD=dbpass123

# Watch build
oc logs -f bc/python-app

# Expose app
oc expose service python-app

# Get URL
oc get route python-app
```

### **Expected Result:**
✅ Django app at: `http://python-app-[project].apps.rm3.7wse.p1.openshiftapps.com`

### **Clean Up:**
```bash
oc delete all --selector app=python-app
oc delete all --selector app=postgresql-ephemeral
```
