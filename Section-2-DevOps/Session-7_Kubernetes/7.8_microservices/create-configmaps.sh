#!/bin/bash

echo "📁 Creating ConfigMaps from separate files..."

# Create namespace if it doesn't exist
kubectl create namespace todo-app 2>/dev/null || echo "Namespace exists"

# Create API ConfigMap from app/api/ directory
echo "🔧 Creating API ConfigMap..."
kubectl create configmap api-code \
  --from-file=app/api/ \
  --namespace=todo-app \
  --dry-run=client -o yaml | kubectl apply -f -

# Create Frontend ConfigMap from app/frontend/ directory
echo "🌐 Creating Frontend ConfigMap..."
kubectl create configmap frontend-files \
  --from-file=app/frontend/ \
  --namespace=todo-app \
  --dry-run=client -o yaml | kubectl apply -f -

echo "✅ ConfigMaps created successfully!"
echo ""
echo "📋 Check ConfigMaps:"
echo "  kubectl get configmaps -n todo-app"
echo "  kubectl describe configmap api-code -n todo-app"
echo "  kubectl describe configmap frontend-files -n todo-app"
