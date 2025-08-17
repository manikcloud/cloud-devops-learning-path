#!/bin/bash

echo "🚀 Deploying Simple Todo App!"
echo "============================="

# Create namespace
echo "📁 Creating namespace..."
kubectl create namespace todo-app 2>/dev/null || echo "Namespace exists"

# Install NGINX Ingress if needed
echo "🌐 Checking NGINX Ingress..."
if ! kubectl get pods -n ingress-nginx | grep -q "ingress-nginx-controller"; then
    echo "📦 Installing NGINX Ingress..."
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.1/deploy/static/provider/cloud/deploy.yaml
    echo "⏳ Waiting for NGINX Ingress..."
    kubectl wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=300s
fi

# Deploy database
echo "🗄️ Deploying database..."
kubectl apply -f 01-database.yaml
sleep 10

# Deploy API
echo "🔧 Deploying API service..."
kubectl apply -f 02-api-service.yaml
sleep 15

# Deploy frontend
echo "🌐 Deploying frontend..."
kubectl apply -f 03-frontend.yaml
sleep 10

# Deploy ingress
echo "🚪 Creating ingress..."
kubectl apply -f 04-ingress.yaml

echo ""
echo "✅ Deployment complete!"
echo ""
echo "📦 Checking status..."
kubectl get pods -n todo-app

echo ""
echo "🎉 Todo App is ready!"
echo "🌍 Access at: http://localhost (or your server IP)"
echo ""
echo "🧪 Test commands:"
echo "  kubectl get all -n todo-app"
echo "  curl http://localhost"
echo ""
echo "🧹 To remove: kubectl delete namespace todo-app"
