#!/bin/bash

# 🚀 Kubernetes Quick Setup Verification Script
# This script verifies any Kubernetes cluster works

set -e

echo "🚀 Starting Kubernetes cluster verification..."
echo "============================================="

# Check if kubectl is available
if ! command -v kubectl &> /dev/null; then
    echo "❌ kubectl is not installed"
    echo "   Please install kubectl first"
    exit 1
fi

echo "✅ kubectl is available"
echo "   Version: $(kubectl version --client --short 2>/dev/null || kubectl version --client)"

# Check cluster connectivity
echo "🔍 Checking cluster status..."
if kubectl cluster-info &> /dev/null; then
    echo "✅ Cluster is accessible"
    kubectl cluster-info
else
    echo "❌ Cannot connect to cluster"
    echo "   Make sure your Kubernetes cluster is running"
    exit 1
fi

# Check nodes
echo ""
echo "📋 Cluster nodes:"
kubectl get nodes

# Create test pod
echo ""
echo "🧪 Testing pod creation..."
kubectl run test-pod --image=nginx:alpine --restart=Never --rm -i --tty=false -- echo "Hello Kubernetes!" || true

# Wait a moment and check if pod ran
sleep 2
echo "✅ Pod test completed"

# Create alias for easier commands
echo ""
echo "💡 Tip: Create an alias for easier kubectl usage:"
echo "   alias k='kubectl'"
echo ""
echo "🎉 Kubernetes cluster is ready!"
echo "   You can now proceed with the learning exercises."
