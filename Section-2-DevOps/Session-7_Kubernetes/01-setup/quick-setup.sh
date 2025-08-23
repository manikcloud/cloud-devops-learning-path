#!/bin/bash

# 🚀 Kubernetes Quick Setup Script
# This script installs k3s and verifies it works

set -e

echo "🚀 Starting Kubernetes (k3s) setup..."
echo "=================================="

# Check if running as root
if [[ $EUID -eq 0 ]]; then
   echo "❌ Please don't run this script as root"
   echo "   Run: ./quick-setup.sh"
   exit 1
fi

# Check if k3s is already installed
if command -v k3s &> /dev/null; then
    echo "✅ k3s is already installed"
    echo "   Version: $(k3s --version | head -n1)"
else
    echo "📥 Installing k3s..."
    curl -sfL https://get.k3s.io | sh -
    echo "✅ k3s installed successfully!"
fi

# Wait for k3s to be ready
echo "⏳ Waiting for k3s to be ready..."
sleep 10

# Check if cluster is ready
echo "🔍 Checking cluster status..."
if sudo k3s kubectl get nodes &> /dev/null; then
    echo "✅ Cluster is ready!"
    sudo k3s kubectl get nodes
else
    echo "❌ Cluster is not ready. Waiting a bit more..."
    sleep 20
    sudo k3s kubectl get nodes
fi

# Create alias for easier use
echo "🔧 Setting up kubectl alias..."
if ! grep -q "alias k=" ~/.bashrc; then
    echo 'alias k="sudo k3s kubectl"' >> ~/.bashrc
    echo "✅ Added alias 'k' for kubectl"
    echo "   Run: source ~/.bashrc"
    echo "   Then you can use: k get nodes"
fi

# Test with a simple pod
echo "🧪 Testing with a simple pod..."
sudo k3s kubectl run test-pod --image=nginx --restart=Never

# Wait for pod to be ready
echo "⏳ Waiting for test pod to be ready..."
sudo k3s kubectl wait --for=condition=Ready pod/test-pod --timeout=60s

# Check pod status
echo "✅ Test pod is ready!"
sudo k3s kubectl get pods

# Clean up test pod
echo "🧹 Cleaning up test pod..."
sudo k3s kubectl delete pod test-pod

echo ""
echo "🎉 SUCCESS! Kubernetes is ready to use!"
echo "=================================="
echo ""
echo "📚 Next steps:"
echo "   1. Run: source ~/.bashrc"
echo "   2. Test: k get nodes"
echo "   3. Continue to: ../02-basics/"
echo ""
echo "💡 Useful commands:"
echo "   k get nodes     - Show cluster nodes"
echo "   k get pods      - Show running pods"
echo "   k get services  - Show services"
echo ""
