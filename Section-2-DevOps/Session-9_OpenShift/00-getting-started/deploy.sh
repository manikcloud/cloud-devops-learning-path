#!/bin/bash

# OpenShift Project 0: Deploy nginx web server
# Usage: ./deploy.sh

echo "🚀 Deploying nginx web server to OpenShift..."

# Check if logged in
if ! oc whoami &> /dev/null; then
    echo "❌ Not logged in to OpenShift. Please run:"
    echo "oc login --token=<your-token> --server=<your-server>"
    exit 1
fi

echo "✅ Logged in as: $(oc whoami)"

# Deploy the application
echo "📦 Deploying blue-web application..."
oc new-app --name=blue-web nginx:alpine

# Expose the service
echo "🌐 Creating public route..."
oc expose svc/blue-web

# Wait for deployment
echo "⏳ Waiting for deployment..."
oc rollout status deployment/blue-web --timeout=300s

# Get the URL
URL=$(oc get route blue-web -o jsonpath='{.spec.host}')
echo "🎉 Application deployed successfully!"
echo "🔗 Your app URL: http://$URL"
echo ""
echo "📋 Quick commands:"
echo "  Check pods: oc get pods"
echo "  View logs: oc logs -f deployment/blue-web"
echo "  Delete app: oc delete all -l app=blue-web"
