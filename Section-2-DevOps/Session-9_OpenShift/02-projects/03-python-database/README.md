# 🐍 **Project 3: Python + Database**

## **Goal:** Full-stack app with PostgreSQL

---

## 💻 **CLI Method (Terminal)**

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

---

## 🖱️ **GUI Method (Web Console)**

### **Step 1: Access Developer Console**
1. Go to OpenShift Web Console
2. Switch to **Developer** perspective (top-left dropdown)
3. Select your project (e.g., `varunmanik1-dev`)

### **Step 2: Add Database**
1. Click **+Add** (left sidebar)
2. Choose **Database**
3. Select **PostgreSQL (Ephemeral)**
4. Fill parameters:
   - Database Service Name: `postgresql`
   - PostgreSQL Database Name: `sampledb`
   - PostgreSQL Username: `dbuser`
   - PostgreSQL Password: `dbpass123`
5. Click **Create**

### **Step 3: Add Python Application**
1. Click **+Add** again
2. Choose **From Git**
3. Enter Git URL: `https://github.com/openshift/django-ex`
4. Application Name: `python-app`
5. Click **Show advanced Git options**
6. Add Environment Variables:
   - `DATABASE_SERVICE_NAME` = `postgresql`
   - `DATABASE_NAME` = `sampledb`
   - `DATABASE_USER` = `dbuser`
   - `DATABASE_PASSWORD` = `dbpass123`
7. Click **Create**

### **Step 4: Watch Build**
1. Go to **Topology** view
2. Click on `python-app` circle
3. Click **View logs** in build section
4. Wait for "Push successful" message

### **Step 5: Access Application**
1. In **Topology** view, click `python-app`
2. Click the **Route** URL (arrow icon)
3. Django application opens

### **Step 6: Clean Up**
1. In **Topology** view, right-click `python-app`
2. Select **Delete Application**
3. Right-click `postgresql` and delete
4. Confirm deletions

---

## 📊 **Both Methods Give Same Result:**
✅ Django web application running
✅ Connected to PostgreSQL database
✅ Built from GitHub source using S2I
✅ Accessible via public URL
