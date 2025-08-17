# 🏆 7.8 Simple Microservices Project

<div align="center">

![Kubernetes](https://img.shields.io/badge/Kubernetes-Final%20Project-blue?style=for-the-badge&logo=kubernetes&logoColor=white)
![Simple](https://img.shields.io/badge/Simple-Student%20Friendly-green?style=for-the-badge&logo=graduation-cap&logoColor=white)

**🎯 Simple & Fun | 🛒 Todo App | 📚 Perfect for Learning**

</div>

---

## 🎯 Project Goal

**Build a simple Todo List application** using microservices to demonstrate everything you've learned. This is your **final project** that shows you can put all the pieces together!

### **What You'll Build:**
- **Frontend** - Simple web page to add/view todos
- **API Service** - Handles todo operations (add, list, delete)
- **Database** - Stores your todos
- **All connected** - Using services and ingress

---

## 🏗️ Simple Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    📝 SIMPLE TODO APP                          │
└─────────────────────────────────────────────────────────────────┘

                        🌍 You (Browser)
                              │
                              │ http://localhost
                              ▼
                    ┌─────────────────────┐
                    │   🚪 NGINX Ingress   │
                    │   Routes traffic    │
                    └─────────────────────┘
                              │
                    ┌─────────┼─────────┐
                    │         │         │
                    ▼         ▼         ▼
            ┌─────────────┐   │   ┌─────────────┐
            │🌐 Frontend   │   │   │🔧 API       │
            │• HTML page  │   │   │• Add todos  │
            │• Add todos  │   │   │• List todos │
            │• Show list  │   │   │• Delete     │
            └─────────────┘   │   └─────────────┘
                              │         │
                              │         │ Saves data
                              │         ▼
                              │   ┌─────────────┐
                              │   │🗄️ Database  │
                              │   │• PostgreSQL │
                              │   │• Stores     │
                              │   │  todos      │
                              │   └─────────────┘
                              │
                        ┌─────────────┐
                        │📊 Monitoring│
                        │• See if     │
                        │  working    │
                        └─────────────┘

🎯 Result: Working Todo App with 3 services!
```

---

## 🚀 Super Easy Setup (10 Minutes!)

### **One Command Does Everything!**
```bash
# Clone and go to project
git clone https://github.com/manikcloud/cloud-devops-learning-path.git
cd cloud-devops-learning-path/Section-2-DevOps/Session-7_Kubernetes/7.8_microservices

# Run the magic script
./deploy-todo-app.sh

# Wait 2-3 minutes, then open:
# http://localhost
```

**That's it! Your Todo app is running!** 🎉

---

## 📚 Step-by-Step (If You Want to Learn)

### **Step 1: Create Project Space**
```bash
# Create namespace for our project
kubectl create namespace todo-app

# Check it was created
kubectl get namespaces
```

### **Step 2: Deploy Database**
```bash
# Deploy PostgreSQL database
kubectl apply -f 01-database.yaml

# Wait for it to start
kubectl get pods -n todo-app

# Should see: postgresql-xxx Running
```

### **Step 3: Deploy API Service**
```bash
# Deploy the API that handles todos
kubectl apply -f 02-api-service.yaml

# Wait for it to start
kubectl get pods -n todo-app

# Should see: api-service-xxx Running
```

### **Step 4: Deploy Frontend**
```bash
# Deploy the web page
kubectl apply -f 03-frontend.yaml

# Check all services
kubectl get pods,services -n todo-app
```

### **Step 5: Make it Accessible**
```bash
# Create ingress so you can access it
kubectl apply -f 04-ingress.yaml

# Check ingress
kubectl get ingress -n todo-app

# Open browser to: http://localhost
```

---

## 🧪 Test Your App

### **Add Some Todos**
1. Open http://localhost in your browser
2. Type "Learn Kubernetes" and click Add
3. Type "Build Todo App" and click Add
4. See your todos appear!

### **Test with Commands**
```bash
# Test API directly
kubectl run test --image=curlimages/curl --rm -it -n todo-app -- \
  curl http://api-service:3000/todos

# Add todo via API
kubectl run test --image=curlimages/curl --rm -it -n todo-app -- \
  curl -X POST http://api-service:3000/todos \
  -H "Content-Type: application/json" \
  -d '{"text":"Learn kubectl"}'
```

---

## 🔍 What You Built

### **3 Simple Services:**

**🌐 Frontend Service**
- Simple HTML page with JavaScript
- Form to add new todos
- Shows list of all todos
- Talks to API service

**🔧 API Service**
- Simple Node.js server
- 3 endpoints: GET /todos, POST /todos, DELETE /todos/:id
- Connects to database
- Returns JSON data

**🗄️ Database Service**
- PostgreSQL database
- One table: todos (id, text, created_at)
- Persistent storage
- Accessed only by API service

### **Kubernetes Resources Used:**
- ✅ **Namespace** - Organize our project
- ✅ **Deployments** - Run our services
- ✅ **Services** - Connect services together
- ✅ **ConfigMaps** - Store configuration
- ✅ **Secrets** - Store database password
- ✅ **PersistentVolume** - Save database data
- ✅ **Ingress** - Access from browser

---

## 🎯 What You Learned

By building this project, you used:

- ✅ **Pods** - Your services run in pods
- ✅ **Deployments** - Manage multiple copies of services
- ✅ **Services** - Services find each other by name
- ✅ **Ingress** - Expose app to the internet
- ✅ **ConfigMaps** - Store app configuration
- ✅ **Secrets** - Store sensitive data safely
- ✅ **Persistent Volumes** - Save data permanently
- ✅ **Namespaces** - Organize resources

**You used ALL the major Kubernetes concepts!** 🏆

---

## 🎨 How to Customize Your App

### **Change the Look (CSS):**
```bash
# Edit the styling
nano app/frontend/style.css

# Update ConfigMap and restart
./create-configmaps.sh
kubectl rollout restart deployment/frontend -n todo-app
```

### **Add Features (JavaScript):**
```bash
# Edit the functionality
nano app/frontend/script.js

# Update and restart
./create-configmaps.sh
kubectl rollout restart deployment/frontend -n todo-app
```

### **Modify API (Node.js):**
```bash
# Edit the server code
nano app/api/server.js

# Update and restart
./create-configmaps.sh
kubectl rollout restart deployment/api-service -n todo-app
```

### **See Your Changes:**
```bash
# Check if pods restarted
kubectl get pods -n todo-app

# Open your browser
# http://localhost (or your server IP)
```

### **Scale Your App**
```bash
# Make more copies of your API
kubectl scale deployment api-service --replicas=3 -n todo-app

# Check how many you have
kubectl get pods -l app=api-service -n todo-app

# Your app can now handle more users!
```

### **See What's Inside**
```bash
# Look at your database
kubectl exec -it deployment/postgresql -n todo-app -- \
  psql -U postgres -d todoapp -c "SELECT * FROM todos;"

# Check API logs
kubectl logs deployment/api-service -n todo-app

# See frontend logs
kubectl logs deployment/frontend -n todo-app
```

### **Break and Fix**
```bash
# Delete API service (breaks the app)
kubectl delete deployment api-service -n todo-app

# Try to add todos - won't work!

# Fix it
kubectl apply -f 02-api-service.yaml

# Works again!
```

---

## 🛠️ Troubleshooting

### **App Not Loading?**
```bash
# Check if all pods are running
kubectl get pods -n todo-app

# Check services
kubectl get services -n todo-app

# Check ingress
kubectl get ingress -n todo-app

# Check logs if something is broken
kubectl logs deployment/frontend -n todo-app
kubectl logs deployment/api-service -n todo-app
```

### **Can't Add Todos?**
```bash
# Check if API service is working
kubectl run test --image=curlimages/curl --rm -it -n todo-app -- \
  curl http://api-service:3000/health

# Check if database is working
kubectl exec -it deployment/postgresql -n todo-app -- \
  psql -U postgres -c "SELECT 1;"
```

---

## 🧹 Clean Up

When you're done:
```bash
# Delete everything
kubectl delete namespace todo-app

# This removes all your project resources!
```

---

## 📁 Clean Project Structure

```
7.8_microservices/
├── app/                          # 📁 Application code (separate files)
│   ├── frontend/
│   │   ├── index.html           # 🌐 Main web page
│   │   ├── style.css            # 🎨 Beautiful styling
│   │   ├── script.js            # ⚡ JavaScript functionality
│   │   └── nginx.conf           # 🔧 NGINX configuration
│   ├── api/
│   │   ├── server.js            # 🔧 Node.js API server
│   │   └── package.json         # 📦 Dependencies
│   └── README.md                # 📚 App documentation
├── 01-database.yaml             # 🗄️ PostgreSQL database
├── 02-api-service.yaml          # 🔧 API service (references app/api/)
├── 03-frontend.yaml             # 🌐 Frontend (references app/frontend/)
├── 04-ingress.yaml              # 🚪 NGINX ingress
├── create-configmaps.sh         # 📁 Creates ConfigMaps from app/ files
├── deploy-todo-app.sh           # 🚀 One-command deployment
└── README.md                    # 📚 This guide
```

### 🎯 **Why This Structure is Better:**

**✅ Clean Separation:**
- **Application code** in `app/` directory
- **Kubernetes configs** in YAML files
- **No embedded HTML/CSS** in YAML files

**✅ Easy to Edit:**
- Edit `app/frontend/style.css` to change styling
- Edit `app/api/server.js` to add features
- YAML files stay clean and simple

**✅ Professional Structure:**
- Matches real-world projects
- Easy for teams to collaborate
- Clear separation of concerns

---

## 🏆 Congratulations!

You just built a complete microservices application using Kubernetes! 

### **What This Proves:**
- ✅ You understand Kubernetes fundamentals
- ✅ You can deploy real applications
- ✅ You know how services communicate
- ✅ You can troubleshoot issues
- ✅ You're ready for production Kubernetes!

### **Add This to Your Resume:**
- "Built microservices application using Kubernetes"
- "Deployed containerized applications with Docker and K8s"
- "Implemented service discovery and load balancing"
- "Managed persistent data storage in Kubernetes"

---

## 🚀 What's Next?

Now that you've mastered Kubernetes basics:

1. **Try AWS EKS** - Deploy this same app to the cloud
2. **Add Monitoring** - Use Prometheus and Grafana
3. **Learn CI/CD** - Automate deployments with GitOps
4. **Get Certified** - Prepare for CKA or CKAD exams
5. **Build More Apps** - Create your own projects

---

*You did it! You're now a Kubernetes developer!* 🎉
