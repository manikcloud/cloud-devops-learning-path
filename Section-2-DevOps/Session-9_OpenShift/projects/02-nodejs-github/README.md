# 🚀 **Project 2: Node.js from GitHub**

## **Goal:** Build and deploy from source code

---

## 💻 **CLI Method (Terminal)**

### **Commands:**
```bash
# Deploy from GitHub
oc new-app https://github.com/openshift/nodejs-ex --name=nodejs-demo

# Watch build
oc logs -f bc/nodejs-demo

# Expose service
oc expose service nodejs-demo

# Get URL
oc get route nodejs-demo
```

### **Expected Result:**
✅ Node.js app at: `http://nodejs-demo-[project].apps.rm3.7wse.p1.openshiftapps.com`

### **Clean Up:**
```bash
oc delete all --selector app=nodejs-demo
```

---

## 🖱️ **GUI Method (Web Console)**

### **Step 1: Access Developer Console**
1. Go to OpenShift Web Console
2. Switch to **Developer** perspective (top-left dropdown)
3. Select your project (e.g., `varunmanik1-dev`)

### **Step 2: Add Application**
1. Click **+Add** (left sidebar)
2. Choose **From Git**
3. Enter Git URL: `https://github.com/openshift/nodejs-ex`
4. Application Name: `nodejs-demo`
5. Click **Create**

### **Step 3: Watch Build**
1. Go to **Topology** view
2. Click on `nodejs-demo` circle
3. Click **View logs** in build section
4. Wait for "Push successful" message

### **Step 4: Access Application**
1. In **Topology** view, click `nodejs-demo`
2. Click the **Route** URL (arrow icon)
3. Application opens in new tab

### **Step 5: Clean Up**
1. In **Topology** view, right-click `nodejs-demo`
2. Select **Delete Application**
3. Confirm deletion

---

## 📊 **Both Methods Give Same Result:**
✅ Node.js Fruit Stock Management app running
✅ Built from GitHub source code using S2I
✅ Accessible via public URL
