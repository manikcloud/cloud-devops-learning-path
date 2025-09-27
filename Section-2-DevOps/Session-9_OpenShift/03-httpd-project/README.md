# 🌐 **Project 3: HTTPD Static Website with Custom Content**

## **Overview**
Deploy an Apache HTTPD server with custom static content using ConfigMaps, demonstrating both Web Console and CLI approaches for static website hosting.

## **Learning Objectives**
- Deploy static websites using HTTPD
- Use ConfigMaps for content management
- Implement custom HTML/CSS/JavaScript
- Configure HTTPS routes with custom domains

---

## **🖥️ Method 1: Web Console Steps**

### **Step 1: Create ConfigMap for Content**
1. Open [OpenShift Console](https://console-openshift-console.apps.rm3.7wse.p1.openshiftapps.com)
2. Login and select your project
3. Go to **Workloads → ConfigMaps**
4. Click **"Create ConfigMap"**
5. Configure:
   - **Name**: `website-content`
   - **Key**: `index.html`
   - **Value**: (Copy the HTML content below)

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My OpenShift Website</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .container {
            text-align: center;
            background: rgba(255,255,255,0.1);
            padding: 50px;
            border-radius: 15px;
            backdrop-filter: blur(10px);
            box-shadow: 0 8px 32px rgba(0,0,0,0.3);
        }
        h1 { font-size: 3em; margin-bottom: 20px; }
        p { font-size: 1.2em; margin-bottom: 30px; }
        .info { background: rgba(255,255,255,0.2); padding: 20px; border-radius: 10px; margin: 20px 0; }
        .time { font-weight: bold; color: #ffeb3b; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🌐 Welcome to My OpenShift Website!</h1>
        <p>This static website is hosted on OpenShift using HTTPD</p>
        <div class="info">
            <p>🚀 Deployed with: Apache HTTPD + ConfigMap</p>
            <p>🔒 Secured with: HTTPS Route</p>
            <p>⏰ Current Time: <span class="time" id="time"></span></p>
        </div>
        <p>Powered by Red Hat OpenShift Container Platform</p>
    </div>
    <script>
        function updateTime() {
            document.getElementById('time').textContent = new Date().toLocaleString();
        }
        updateTime();
        setInterval(updateTime, 1000);
    </script>
</body>
</html>
```

### **Step 2: Deploy HTTPD Application**
1. Go to **"+Add"** → **"Container Image"**
2. Configure:
   - **Image Name**: `registry.redhat.io/ubi8/httpd-24`
   - **Application Name**: `static-website`
   - **Name**: `httpd-server`
3. Click **"Create"**

### **Step 3: Mount ConfigMap**
1. Go to **Workloads → Deployments**
2. Click on `httpd-server` deployment
3. Go to **Environment** tab
4. Scroll to **"Volumes"** section
5. Click **"Add Volume"**
6. Select **"ConfigMap"**
7. Configure:
   - **Source**: `website-content`
   - **Mount Path**: `/var/www/html`
8. Save changes

### **Step 4: Create Route**
1. Go to **Networking → Services**
2. Click on `httpd-server` service
3. Click **"Create Route"**
4. Configure:
   - **Name**: `website-route`
   - **Secure Route**: ✓ (Enable TLS)
   - **TLS Termination**: `Edge`
5. Click **"Create"**

### **Step 5: Access Website**
1. Go to **Networking → Routes**
2. Click the route URL to access your website
3. Verify HTTPS is working (🔒 icon in browser)

---

## **⌨️ Method 2: CLI Steps**

### **Step 1: Create ConfigMap with Content**
```bash
# Login to OpenShift
oc login --token=<your-token> --server=<your-server>

# Create HTML content file
cat > index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My OpenShift Website</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0; padding: 0;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white; min-height: 100vh;
            display: flex; align-items: center; justify-content: center;
        }
        .container {
            text-align: center; background: rgba(255,255,255,0.1);
            padding: 50px; border-radius: 15px;
            backdrop-filter: blur(10px); box-shadow: 0 8px 32px rgba(0,0,0,0.3);
        }
        h1 { font-size: 3em; margin-bottom: 20px; }
        p { font-size: 1.2em; margin-bottom: 30px; }
        .info { background: rgba(255,255,255,0.2); padding: 20px; border-radius: 10px; margin: 20px 0; }
        .time { font-weight: bold; color: #ffeb3b; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🌐 CLI Deployed OpenShift Website!</h1>
        <p>This static website is hosted on OpenShift using HTTPD</p>
        <div class="info">
            <p>🚀 Deployed with: CLI + ConfigMap</p>
            <p>🔒 Secured with: HTTPS Route</p>
            <p>⏰ Current Time: <span class="time" id="time"></span></p>
        </div>
        <p>Powered by Red Hat OpenShift Container Platform</p>
    </div>
    <script>
        function updateTime() {
            document.getElementById('time').textContent = new Date().toLocaleString();
        }
        updateTime();
        setInterval(updateTime, 1000);
    </script>
</body>
</html>
EOF

# Create ConfigMap from file
oc create configmap website-content --from-file=index.html
```

### **Step 2: Deploy HTTPD with ConfigMap**
```bash
# Create deployment YAML
cat > httpd-deployment.yaml << 'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: httpd-server
  labels:
    app: static-website
spec:
  replicas: 1
  selector:
    matchLabels:
      app: static-website
  template:
    metadata:
      labels:
        app: static-website
    spec:
      containers:
      - name: httpd
        image: registry.redhat.io/ubi8/httpd-24
        ports:
        - containerPort: 8080
        volumeMounts:
        - name: website-content
          mountPath: /var/www/html
        securityContext:
          runAsNonRoot: true
          runAsUser: 1001
      volumes:
      - name: website-content
        configMap:
          name: website-content
---
apiVersion: v1
kind: Service
metadata:
  name: httpd-server
  labels:
    app: static-website
spec:
  selector:
    app: static-website
  ports:
  - port: 8080
    targetPort: 8080
---
apiVersion: route.openshift.io/v1
kind: Route
metadata:
  name: website-route
  labels:
    app: static-website
spec:
  tls:
    termination: edge
  to:
    kind: Service
    name: httpd-server
EOF

# Apply the deployment
oc apply -f httpd-deployment.yaml
```

### **Step 3: Monitor and Access**
```bash
# Check deployment status
oc rollout status deployment/httpd-server

# Get route URL
oc get route website-route
echo "Website URL: https://$(oc get route website-route -o jsonpath='{.spec.host}')"

# Test the website
curl -k https://$(oc get route website-route -o jsonpath='{.spec.host}')
```

---

## **🔧 Advanced Customization**

### **Add CSS and JavaScript Files**

#### **Console Method**
1. Edit the `website-content` ConfigMap
2. Add additional keys for CSS and JS files
3. Update the HTML to reference these files

#### **CLI Method**
```bash
# Create additional content files
cat > style.css << 'EOF'
/* Additional CSS styles */
.footer { margin-top: 50px; font-size: 0.9em; opacity: 0.8; }
.animated { animation: fadeIn 2s ease-in; }
@keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
EOF

cat > script.js << 'EOF'
// Additional JavaScript functionality
document.addEventListener('DOMContentLoaded', function() {
    console.log('OpenShift website loaded successfully!');
    document.querySelector('.container').classList.add('animated');
});
EOF

# Update ConfigMap with multiple files
oc create configmap website-content \
  --from-file=index.html \
  --from-file=style.css \
  --from-file=script.js \
  --dry-run=client -o yaml | oc apply -f -

# Restart deployment to pick up changes
oc rollout restart deployment/httpd-server
```

### **Custom Domain Configuration**
```bash
# Create route with custom hostname (if available)
oc create route edge website-custom \
  --service=httpd-server \
  --hostname=mysite.example.com
```

---

## **🔧 Troubleshooting**

### **Content Not Loading**
```bash
# Check ConfigMap content
oc describe configmap website-content

# Check volume mounts
oc describe deployment httpd-server

# Check pod logs
oc logs -f deployment/httpd-server

# Exec into pod to verify files
oc exec -it deployment/httpd-server -- ls -la /var/www/html
```

### **Route Issues**
```bash
# Check route configuration
oc describe route website-route

# Test internal service
oc port-forward deployment/httpd-server 8080:8080
# Then test: curl http://localhost:8080
```

### **Permission Issues**
```bash
# Check security context
oc describe pod -l app=static-website

# Verify HTTPD configuration
oc exec -it deployment/httpd-server -- cat /etc/httpd/conf/httpd.conf
```

---

## **📋 Verification Steps**

### **Console Verification**
1. **Topology**: Green status for httpd-server
2. **Routes**: HTTPS route accessible
3. **ConfigMaps**: Content properly configured
4. **Pods**: Running without errors

### **CLI Verification**
```bash
# Check all resources
oc get all -l app=static-website

# Verify website content
curl -k https://$(oc get route website-route -o jsonpath='{.spec.host}') | grep "OpenShift Website"

# Check HTTPS certificate
curl -I -k https://$(oc get route website-route -o jsonpath='{.spec.host}')
```

---

## **🧹 Cleanup**

### **Console Cleanup**
1. Delete the deployment from Topology view
2. Delete the ConfigMap from Workloads → ConfigMaps
3. Delete the route from Networking → Routes

### **CLI Cleanup**
```bash
# Delete all resources
oc delete -f httpd-deployment.yaml
oc delete configmap website-content

# Or delete by label
oc delete all,configmap -l app=static-website
```

---

## **🎯 Learning Outcomes**
- ✅ Deploy static websites using HTTPD on OpenShift
- ✅ Use ConfigMaps for content management
- ✅ Configure HTTPS routes for secure access
- ✅ Mount volumes and manage file content
- ✅ Customize web content with HTML/CSS/JavaScript
- ✅ Troubleshoot web server deployments

## **📚 Next Steps**
- Add multiple pages and navigation
- Implement custom error pages
- Set up content delivery optimization
- Add monitoring and analytics
- Explore OpenShift image streams for automated updates

---

**Duration:** 25 minutes  
**Difficulty:** Beginner to Intermediate  
**Focus:** Static website hosting and content management
