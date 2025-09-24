# 🌐 **Project 1: Simple Web Server**

## **Goal:** Deploy nginx in 2 minutes

---

## 💻 **CLI Method (Terminal)**

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

---

## 🖱️ **GUI Method (Web Console)**

### **Step 1: Access Developer Console**
1. Go to OpenShift Web Console
2. Switch to **Developer** perspective (top-left dropdown)
3. Select your project (e.g., `varunmanik1-dev`)

### **Step 2: Add Application**
1. Click **+Add** (left sidebar)
2. Choose **Container Image**
3. Enter Image Name: `nginx:alpine`
4. Application Name: `my-nginx`
5. Click **Create**

### **Step 3: Create Route**
1. Go to **Topology** view
2. Click on `my-nginx` circle
3. Click **Create Route** (in Resources tab)
4. Click **Create** (accept defaults)

### **Step 4: Access Application**
1. In **Topology** view, click `my-nginx`
2. Click the **Route** URL (arrow icon)
3. Nginx welcome page opens

### **Step 5: Clean Up**
1. In **Topology** view, right-click `my-nginx`
2. Select **Delete Application**
3. Confirm deletion

---

## 📊 **Both Methods Give Same Result:**
✅ Nginx web server running
✅ Accessible via public URL
✅ Shows default nginx welcome page
