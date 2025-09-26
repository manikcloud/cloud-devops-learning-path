# 🔗 **Project 4: Multi-Service Todo App**

## **What You'll Build**
Convert the Kubernetes Todo app to OpenShift with Routes and ImageStreams.

## **Components**
- Frontend (React/Nginx)
- Backend API (Node.js)  
- Database (PostgreSQL)
- OpenShift Routes for external access

## **Quick Deploy**
```bash
# Create new project
oc new-project todo-app-$(whoami)

# Deploy all components
oc apply -f .

# Get route URL
oc get route frontend
```

## **Access Your App**
```bash
# Get the URL
echo "Your app: http://$(oc get route frontend -o jsonpath='{.spec.host}')"
```

## **Time**: 10 minutes
## **Skills**: Multi-tier apps, Routes, Services
