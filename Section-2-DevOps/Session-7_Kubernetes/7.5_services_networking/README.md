# 🌐 7.5 Services & Networking

<div align="center">

![Kubernetes](https://img.shields.io/badge/Kubernetes-Services-blue?style=for-the-badge&logo=kubernetes&logoColor=white)
![Hello World](https://img.shields.io/badge/Hello-World-green?style=for-the-badge&logo=kubernetes&logoColor=white)

**🎯 Simple Hello World App | 🌍 NGINX Ingress | 🔗 Easy Networking**

</div>

---

## 🎯 What We'll Learn

In this lesson, you'll learn how to:
- **Deploy a simple web app** (Hello World)
- **Create a service** to access your app
- **Install NGINX Ingress** to expose your app to the internet
- **Access your app** from a web browser

---

## 🚀 Quick Start (5 Minutes!)

### **Super Easy Way - One Command**
```bash
# Clone the repository
git clone https://github.com/manikcloud/cloud-devops-learning-path.git
cd cloud-devops-learning-path/Section-2-DevOps/Session-7_Kubernetes/7.5_services_networking

# Run the magic script (does everything for you!)
./quick-start.sh

# Wait 2-3 minutes, then open your browser to:
# http://localhost
```

**That's it! Your Hello World app is running!** 🎉

---

## 📚 Step-by-Step Learning

If you want to understand what's happening, follow these steps:

### **Step 1: Make Sure k3s is Running**
```bash
# Check if your cluster is ready
kubectl get nodes

# Should show something like:
# NAME     STATUS   ROLES                  AGE   VERSION
# k3s      Ready    control-plane,master   1d    v1.27.4+k3s1
```

### **Step 2: Deploy Hello World App**
```bash
# Deploy our simple Hello World application
kubectl apply -f hello-world-app.yaml

# Check if it's running
kubectl get pods

# You should see 2 pods running:
# NAME                           READY   STATUS    RESTARTS   AGE
# hello-world-xxxxxxxxx-xxxxx    1/1     Running   0          30s
# hello-world-xxxxxxxxx-xxxxx    1/1     Running   0          30s
```

### **Step 3: Check the Service**
```bash
# See the service that was created
kubectl get services

# Test the service from inside the cluster
kubectl run test --image=busybox --rm -it -- wget -qO- http://hello-world-service

# You should see the HTML of our Hello World page!
```

### **Step 4: Install NGINX Ingress**
```bash
# Install NGINX Ingress Controller (this takes 2-3 minutes)
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.1/deploy/static/provider/cloud/deploy.yaml

# Wait for it to be ready
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=300s

# Check it's running
kubectl get pods -n ingress-nginx
```

### **Step 5: Create Ingress to Expose Your App**
```bash
# Create ingress to make your app accessible from outside
kubectl apply -f simple-ingress.yaml

# Check the ingress
kubectl get ingress

# Should show:
# NAME                  CLASS   HOSTS   ADDRESS     PORTS   AGE
# hello-world-ingress   nginx   *       localhost   80      30s
```

### **Step 6: Access Your App!**
```bash
# Test with curl
curl http://localhost

# Or open in your browser:
# http://localhost
```

**🎉 Congratulations! You just deployed your first Kubernetes app with ingress!**

---

## 🔍 What Just Happened?

Let's understand what we created:

### **1. Deployment** 
- Created 2 copies (replicas) of our Hello World app
- Each copy runs in its own pod
- If one pod crashes, Kubernetes restarts it automatically

### **2. Service**
- Gives our app a stable name: `hello-world-service`
- Load balances traffic between the 2 pods
- Other apps can reach ours using this name

### **3. Ingress**
- Acts like a "front door" to our cluster
- Routes internet traffic to our service
- Makes our app accessible at `http://localhost`

### **Visual Flow:**
```
Internet → NGINX Ingress → hello-world-service → Pod 1 or Pod 2
```

---

## 🧪 Fun Things to Try

### **Scale Your App**
```bash
# Make more copies of your app
kubectl scale deployment hello-world --replicas=5

# Check how many pods you have now
kubectl get pods -l app=hello-world

# Your app can now handle more traffic!
```

### **See What's Inside a Pod**
```bash
# Get the name of one of your pods
kubectl get pods -l app=hello-world

# Look inside the pod (replace POD_NAME with actual name)
kubectl exec -it POD_NAME -- /bin/bash

# Inside the pod, you can run:
# ls /usr/share/nginx/html
# cat /usr/share/nginx/html/index.html
# exit
```

### **Check the Logs**
```bash
# See what your app is doing
kubectl logs deployment/hello-world

# Follow logs in real-time
kubectl logs -f deployment/hello-world
```

### **Update Your App**
```bash
# Edit the HTML content
kubectl edit configmap hello-world-html

# Restart pods to see changes
kubectl rollout restart deployment hello-world

# Refresh your browser to see the changes!
```

---

## 🛠️ Troubleshooting

### **App Not Loading?**
```bash
# Check if pods are running
kubectl get pods -l app=hello-world

# Check if service is working
kubectl get services hello-world-service

# Check if ingress is ready
kubectl get ingress hello-world-ingress

# Check ingress controller logs
kubectl logs -n ingress-nginx deployment/ingress-nginx-controller
```

### **Still Not Working?**
```bash
# Test service directly (should work)
kubectl run test --image=busybox --rm -it -- wget -qO- http://hello-world-service

# If service works but ingress doesn't, wait a bit more
# Ingress can take 2-3 minutes to be fully ready
```

---

## 🧹 Clean Up

When you're done experimenting:
```bash
# Delete your app
kubectl delete -f hello-world-app.yaml
kubectl delete -f simple-ingress.yaml

# Delete NGINX Ingress (optional)
kubectl delete -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.1/deploy/static/provider/cloud/deploy.yaml
```

---

## 🎯 What You Learned

- ✅ **Deployed your first Kubernetes app** - Hello World web application
- ✅ **Created a service** - Stable way to access your app
- ✅ **Installed NGINX Ingress** - Gateway to expose apps to internet
- ✅ **Used ingress rules** - Route traffic from internet to your app
- ✅ **Scaled applications** - Run multiple copies for reliability
- ✅ **Troubleshooted issues** - Debug when things don't work

---

## ✅ Success Criteria
- [ ] Hello World app is running (2 pods)
- [ ] Service is accessible from inside cluster
- [ ] NGINX Ingress is installed and running
- [ ] App is accessible at http://localhost
- [ ] Can scale the app up and down
- [ ] Understand the flow: Internet → Ingress → Service → Pods

## 🚀 Next Steps

Ready for more advanced features? Continue with:

**[7.6 - Auto-scaling & Updates →](../7.6_autoscaling_updates/)**

Learn to automatically scale your apps based on traffic!

---

## 📁 Files in This Directory

- **`hello-world-app.yaml`** - Simple web application with 2 replicas
- **`simple-ingress.yaml`** - Basic ingress to expose the app
- **`quick-start.sh`** - One-command setup script
- **`README.md`** - This guide you're reading

---

*Start simple, then scale up!* 🌟
