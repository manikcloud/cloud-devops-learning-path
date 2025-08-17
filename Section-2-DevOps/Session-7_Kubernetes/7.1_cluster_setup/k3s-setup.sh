#!/bin/bash

echo "🚀 Setting up k3s Kubernetes cluster..."

# Install k3s
curl -sfL https://get.k3s.io | sh -

# Wait for k3s to be ready
echo "⏳ Waiting for k3s to be ready..."
sleep 10

# Setup kubeconfig for regular user
mkdir -p ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chown $(id -u):$(id -g) ~/.kube/config

# Verify installation
echo "✅ Verifying k3s installation..."
kubectl get nodes

echo "🎉 k3s setup complete!"
echo "💡 You can now use 'kubectl' commands"
