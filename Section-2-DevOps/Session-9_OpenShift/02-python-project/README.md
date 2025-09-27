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

## **📁 Alternative: Use YAML File**

```bash
# Clone the repository
git clone https://github.com/manikcloud/cloud-devops-learning-path.git
cd cloud-devops-learning-path/Section-2-DevOps/Session-9_OpenShift/02-python-project

# Deploy using the working hello-world pattern
oc apply -f ../03-httpd-project/hello-world.yaml

# Customize the content for Python theme
oc patch configmap hello-html --patch='{"data":{"index.html":"<!DOCTYPE html><html><head><title>Python Hello World</title><style>body{font-family:Arial;text-align:center;margin:50px;background:linear-gradient(135deg,#3776ab,#ffd43b);color:white;min-height:80vh;display:flex;flex-direction:column;justify-content:center}.container{background:rgba(255,255,255,0.1);padding:40px;border-radius:15px;backdrop-filter:blur(10px)}h1{font-size:3em;margin-bottom:20px}p{font-size:1.2em;margin:10px 0}.status{color:#FFD700;font-weight:bold}</style></head><body><div class=\"container\"><h1>🐍 Python Hello World!</h1><p>This Python-themed page runs on OpenShift</p><p class=\"status\">✅ HTTPD server running</p><p class=\"status\">✅ Python styling applied</p><p class=\"status\">✅ HTTPS route working</p></div></body></html>"}}'

# Restart to apply changes
oc rollout restart deployment/hello-world
```

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
# Or if using YAML: oc delete -f ../03-httpd-project/hello-world.yaml
```

---

**Duration:** 3 minutes  
**Result:** Working Python-themed hello world  
**Repository:** https://github.com/manikcloud/cloud-devops-learning-path/tree/main/Section-2-DevOps/Session-9_OpenShift/02-python-project
