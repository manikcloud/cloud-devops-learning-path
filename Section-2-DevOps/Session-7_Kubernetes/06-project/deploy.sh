#!/bin/bash

# 🚀 Todo App Deployment Script
# This script deploys the complete Todo application

set -e

echo "🚀 Deploying Todo Application on Kubernetes..."
echo "=============================================="

# Check if kubectl is available
if ! command -v kubectl &> /dev/null; then
    echo "❌ kubectl not found. Please install kubectl first."
    exit 1
fi

# Check if cluster is accessible
if ! kubectl cluster-info &> /dev/null; then
    echo "❌ Cannot connect to Kubernetes cluster."
    echo "   Make sure your cluster is running and kubectl is configured."
    exit 1
fi

echo "✅ Kubernetes cluster is accessible"

# Deploy the application
echo "📦 Deploying application components..."
kubectl apply -f todo-app-complete.yaml

echo "⏳ Waiting for deployments to be ready..."

# Wait for database
echo "🗄️ Waiting for database..."
kubectl wait --for=condition=available deployment/todo-db --timeout=120s

# Wait for API
echo "🔧 Waiting for API..."
kubectl wait --for=condition=available deployment/todo-api --timeout=120s

# Wait for frontend
echo "🎨 Waiting for frontend..."
kubectl wait --for=condition=available deployment/todo-frontend --timeout=120s

echo ""
echo "🎉 Todo Application deployed successfully!"
echo "========================================"
echo ""

# Show application status
echo "📊 Application Status:"
kubectl get all -l project=todo-app

echo ""
echo "🌐 Access Your Application:"
echo "   Frontend: http://localhost:30080"
echo "   API Health: http://localhost:30081/health"
echo "   API Todos: http://localhost:30081/api/todos"

echo ""
echo "🔧 Useful Commands:"
echo "   kubectl get pods -l project=todo-app"
echo "   kubectl logs -l app=todo-api"
echo "   kubectl scale deployment todo-frontend --replicas=3"
echo "   kubectl delete -f todo-app-complete.yaml  # To clean up"

echo ""
echo "🎓 What to try next:"
echo "   1. Open http://localhost:30080 in your browser"
echo "   2. Add some todos and interact with the app"
echo "   3. Scale the components: kubectl scale deployment todo-api --replicas=3"
echo "   4. Check the logs: kubectl logs -l app=todo-frontend"
echo "   5. Update a component: kubectl set image deployment/todo-api api=nginx:1.21"

echo ""
echo "✨ Happy learning with Kubernetes! ✨"
