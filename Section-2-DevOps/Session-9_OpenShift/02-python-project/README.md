# 🐍 **Project 2: Python Style Hello World**

## **Overview**
Deploy a Python-themed hello world page using HTTPD (same reliable approach as getting-started).

## **Prerequisites**
- OpenShift Sandbox account
- `oc` CLI installed

---

## **⚡ Super Simple (4 commands)**

### **Step 1: Login**
```bash
oc login --token=<your-token> --server=<your-server>
```

### **Step 2: Create Python-themed HTML**
```bash
oc create configmap python-html --from-literal=index.html='<!DOCTYPE html><html><head><title>Python Hello World</title><style>body{font-family:Arial;text-align:center;margin:50px;background:linear-gradient(135deg,#3776ab,#ffd43b);color:white;min-height:80vh;display:flex;flex-direction:column;justify-content:center}.container{background:rgba(255,255,255,0.1);padding:40px;border-radius:15px;backdrop-filter:blur(10px)}h1{font-size:3em;margin-bottom:20px}p{font-size:1.2em;margin:10px 0}.status{color:#FFD700;font-weight:bold}</style></head><body><div class="container"><h1>🐍 Python Hello World!</h1><p>This Python-themed page runs on OpenShift</p><p class="status">✅ HTTPD server running</p><p class="status">✅ Python styling applied</p><p class="status">✅ HTTPS route working</p><p>Simulating Python Flask/Django patterns</p></div></body></html>'
```

### **Step 3: Deploy and Expose**
```bash
# Deploy HTTPD with Python content
oc run python --image=registry.access.redhat.com/ubi8/httpd-24 --port=8080
oc set volume pod/python --add --name=html --mount-path=/var/www/html --source=configmap:python-html
oc expose pod python --port=8080
oc create route edge python --service=python
```

### **Step 4: Get URL**
```bash
echo "🐍 Python URL: https://$(oc get route python -o jsonpath='{.spec.host}')"
```

---

## **🖥️ Web Console Method**

1. Create ConfigMap first (Workloads → ConfigMaps)
2. **"+Add"** → **"Container Image"**
3. **Image**: `registry.access.redhat.com/ubi8/httpd-24`
4. **Name**: `python`
5. **Port**: `8080`
6. Mount ConfigMap to `/var/www/html`
7. Check **"Create route"**

---

## **🌐 Expected Result**
- Blue/yellow Python-themed page
- "Python Hello World!" heading
- Professional styling with Python colors
- HTTPS working

---

## **🧹 Cleanup**
```bash
oc delete pod,svc,route,configmap python python-html
```

---

**Duration:** 3 minutes  
**Result:** Working Python-themed hello world
