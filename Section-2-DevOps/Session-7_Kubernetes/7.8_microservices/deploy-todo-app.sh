#!/bin/bash

echo "🚀 Deploying Simple Todo App - Final Kubernetes Project!"
echo "======================================================="

# Step 1: Create namespace
echo "📁 Creating project namespace..."
kubectl create namespace todo-app 2>/dev/null || echo "Namespace already exists"

# Step 2: Install NGINX Ingress if not present
echo "🌐 Checking NGINX Ingress Controller..."
if ! kubectl get pods -n ingress-nginx | grep -q "ingress-nginx-controller"; then
    echo "📦 Installing NGINX Ingress Controller..."
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.1/deploy/static/provider/cloud/deploy.yaml
    
    echo "⏳ Waiting for NGINX Ingress to be ready (this may take 2-3 minutes)..."
    kubectl wait --namespace ingress-nginx \
      --for=condition=ready pod \
      --selector=app.kubernetes.io/component=controller \
      --timeout=300s
else
    echo "✅ NGINX Ingress Controller already running"
fi

# Step 3: Deploy database
echo "🗄️ Deploying PostgreSQL database..."
kubectl apply -f 01-database.yaml

echo "⏳ Waiting for database to be ready..."
kubectl wait --for=condition=ready pod -l app=postgresql -n todo-app --timeout=180s

# Step 4: Deploy API service
echo "🔧 Deploying API service..."
kubectl apply -f 02-api-service.yaml

echo "⏳ Waiting for API service to be ready..."
kubectl wait --for=condition=ready pod -l app=api-service -n todo-app --timeout=180s

# Step 5: Deploy frontend
echo "🌐 Deploying frontend..."
kubectl apply -f 03-frontend.yaml

echo "⏳ Waiting for frontend to be ready..."
kubectl wait --for=condition=ready pod -l app=frontend -n todo-app --timeout=120s

# Step 6: Create ingress
echo "🚪 Creating ingress..."
kubectl apply -f 04-ingress.yaml

# Step 7: Show status
echo ""
echo "✅ Deployment Complete! Here's what we created:"
echo ""
echo "📦 Pods:"
kubectl get pods -n todo-app

echo ""
echo "🌐 Services:"
kubectl get services -n todo-app

echo ""
echo "🚪 Ingress:"
kubectl get ingress -n todo-app

echo ""
echo "🎉 SUCCESS! Your Todo App is ready!"
echo ""
echo "🌍 Access your app:"
echo "   • Open browser: http://localhost"
echo "   • Or run: curl http://localhost"
echo ""
echo "📚 What you built:"
echo "   • Frontend: HTML/JavaScript web page"
echo "   • API: Node.js REST API server"
echo "   • Database: PostgreSQL with persistent storage"
echo "   • Ingress: NGINX routing for external access"
echo ""
echo "🧪 Try these commands:"
echo "   • kubectl get all -n todo-app"
echo "   • kubectl logs deployment/api-service -n todo-app"
echo "   • kubectl exec -it deployment/postgresql -n todo-app -- psql -U postgres -d todoapp -c 'SELECT * FROM todos;'"
echo ""
echo "🧹 To clean up later:"
echo "   • kubectl delete namespace todo-app"
echo ""
echo "🏆 Congratulations! You just built a complete microservices application!"
