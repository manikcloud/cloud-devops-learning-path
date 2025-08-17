#!/bin/bash

echo "🚀 Quick Start: Hello World with NGINX Ingress"
echo "=============================================="

# Step 1: Install NGINX Ingress (simple version)
echo "📦 Installing NGINX Ingress Controller..."
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.1/deploy/static/provider/cloud/deploy.yaml

# Wait for ingress to be ready
echo "⏳ Waiting for NGINX Ingress to be ready (this may take 2-3 minutes)..."
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=300s

# Step 2: Deploy Hello World app
echo "🌟 Deploying Hello World application..."
kubectl apply -f hello-world-app.yaml

# Step 3: Create simple ingress
echo "🌐 Creating ingress to expose the app..."
kubectl apply -f simple-ingress.yaml

# Step 4: Wait for app to be ready
echo "⏳ Waiting for Hello World app to be ready..."
kubectl wait --for=condition=ready pod -l app=hello-world --timeout=120s

# Step 5: Show status
echo ""
echo "✅ Setup Complete! Here's what we created:"
echo ""
echo "📦 Pods:"
kubectl get pods -l app=hello-world

echo ""
echo "🌐 Services:"
kubectl get services hello-world-service

echo ""
echo "🚪 Ingress:"
kubectl get ingress hello-world-ingress

echo ""
echo "🎉 SUCCESS! Your Hello World app is ready!"
echo ""
echo "🌍 Access your app:"
echo "   • Open browser: http://localhost"
echo "   • Or run: curl http://localhost"
echo ""
echo "📚 What to try next:"
echo "   • kubectl get pods -l app=hello-world"
echo "   • kubectl logs deployment/hello-world"
echo "   • kubectl describe service hello-world-service"
echo "   • kubectl describe ingress hello-world-ingress"
