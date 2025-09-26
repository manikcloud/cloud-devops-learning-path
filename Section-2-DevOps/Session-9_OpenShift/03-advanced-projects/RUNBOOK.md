# 📖 **Advanced OpenShift Projects Runbook**

## **🎯 Student Guide for Projects 4-6**

### **Prerequisites Setup**
```bash
# 1. Complete basic projects 1-3 first
# 2. Login to OpenShift CLI
oc login --token=<your-token> --server=<your-server>

# 3. Use your dev project
oc project <your-username>-dev
```

---

## **📁 Project 4: Multi-Service Todo App**

### **Quick Deploy**
```bash
# Create project
oc new-project todo-app-$(whoami) || oc project $(whoami)-dev

# Deploy all components
oc apply -f 04-multi-service-app/01-database.yaml
oc apply -f 04-multi-service-app/02-api.yaml
oc apply -f 04-multi-service-app/03-frontend.yaml

# Get URL
echo "Todo App: http://$(oc get route frontend -o jsonpath='{.spec.host}')"
```

---

## **📈 Project 5: Auto-Scaling App**

### **Quick Deploy**
```bash
# Create project
oc new-project scaling-demo-$(whoami) || oc project $(whoami)-dev

# Deploy app
oc apply -f 05-autoscaling-app/app.yaml

# Create autoscaler
oc autoscale deployment webapp --cpu-percent=50 --min=1 --max=5

# Generate load
oc apply -f 05-autoscaling-app/load-test.yaml

# Watch scaling
watch oc get pods
```

---

## **🔄 Project 6: Blue-Green Deployment**

### **Quick Deploy**
```bash
# Create project
oc new-project blue-green-$(whoami) || oc project $(whoami)-dev

# Deploy blue version
oc apply -f 06-blue-green-deploy/blue-version.yaml

# Deploy green version
oc apply -f 06-blue-green-deploy/green-version.yaml

# Switch to green
oc patch service app -p '{"spec":{"selector":{"version":"green"}}}'
```

---

## **🔧 Common Commands**
```bash
# Check pods
oc get pods

# Check services
oc get svc

# Check routes
oc get routes

# View logs
oc logs -l app=<app-name>
```
