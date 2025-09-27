# 🟢 **Project 1: Node.js Style Hello World**

## **Overview**
Deploy a Node.js-themed hello world page using HTTPD (same reliable approach as getting-started).

## **Prerequisites**
- OpenShift Sandbox account
- `oc` CLI installed

---

## **⚡ Super Simple (4 commands)**

### **Step 1: Login**
```bash
oc login --token=<your-token> --server=<your-server>
```

### **Step 2: Create Node.js-themed HTML**
```bash
oc create configmap nodejs-html --from-literal=index.html='<!DOCTYPE html><html><head><title>Node.js Hello World</title><style>body{font-family:Arial;text-align:center;margin:50px;background:linear-gradient(135deg,#68a063,#4f7942);color:white;min-height:80vh;display:flex;flex-direction:column;justify-content:center}.container{background:rgba(255,255,255,0.1);padding:40px;border-radius:15px;backdrop-filter:blur(10px)}h1{font-size:3em;margin-bottom:20px}p{font-size:1.2em;margin:10px 0}.status{color:#90EE90;font-weight:bold}</style></head><body><div class="container"><h1>🟢 Node.js Hello World!</h1><p>This Node.js-themed page runs on OpenShift</p><p class="status">✅ HTTPD server running</p><p class="status">✅ Node.js styling applied</p><p class="status">✅ HTTPS route working</p><p>Simulating Node.js deployment patterns</p></div></body></html>'
```

### **Step 3: Deploy and Expose**
```bash
# Deploy HTTPD with Node.js content
oc run nodejs --image=registry.access.redhat.com/ubi8/httpd-24 --port=8080
oc set volume pod/nodejs --add --name=html --mount-path=/var/www/html --source=configmap:nodejs-html
oc expose pod nodejs --port=8080
oc create route edge nodejs --service=nodejs
```

### **Step 4: Get URL**
```bash
echo "🟢 Node.js URL: https://$(oc get route nodejs -o jsonpath='{.spec.host}')"
```

---

## **🖥️ Web Console Method**

1. Create ConfigMap first (Workloads → ConfigMaps)
2. **"+Add"** → **"Container Image"**
3. **Image**: `registry.access.redhat.com/ubi8/httpd-24`
4. **Name**: `nodejs`
5. **Port**: `8080`
6. Mount ConfigMap to `/var/www/html`
7. Check **"Create route"**

---

## **🌐 Expected Result**
- Green Node.js-themed page
- "Node.js Hello World!" heading
- Professional styling with Node.js colors
- HTTPS working

---

## **🧹 Cleanup**
```bash
oc delete pod,svc,route,configmap nodejs nodejs-html
```

---

**Duration:** 3 minutes  
**Result:** Working Node.js-themed hello world
