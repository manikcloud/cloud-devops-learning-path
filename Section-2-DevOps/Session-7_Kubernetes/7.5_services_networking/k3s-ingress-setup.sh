#!/bin/bash

echo "🚀 Setting up NGINX Ingress Controller on k3s..."

# Step 1: Disable Traefik (k3s default ingress)
echo "📝 Note: To disable Traefik permanently, restart k3s with --disable traefik"
echo "   For existing k3s: sudo systemctl edit k3s"
echo "   Add: [Service]"
echo "        ExecStart="
echo "        ExecStart=/usr/local/bin/k3s server --disable traefik"

# Step 2: Install NGINX Ingress Controller
echo "⚡ Installing NGINX Ingress Controller..."
kubectl apply -f nginx-ingress-install.yaml

# Step 3: Wait for NGINX Ingress to be ready
echo "⏳ Waiting for NGINX Ingress Controller to be ready..."
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=300s

# Step 4: Check installation
echo "✅ Checking NGINX Ingress Controller status..."
kubectl get pods -n ingress-nginx
kubectl get services -n ingress-nginx

# Step 5: Get the external IP/port
echo "🌐 Getting Ingress Controller access information..."
INGRESS_IP=$(kubectl get service ingress-nginx-controller -n ingress-nginx -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
INGRESS_PORT=$(kubectl get service ingress-nginx-controller -n ingress-nginx -o jsonpath='{.spec.ports[0].nodePort}')

if [ -z "$INGRESS_IP" ]; then
    echo "📍 Ingress Controller is available on:"
    echo "   - localhost (if running locally)"
    echo "   - Node IP on port 80/443"
    echo "   - Check with: kubectl get nodes -o wide"
else
    echo "📍 Ingress Controller is available at: $INGRESS_IP"
fi

echo ""
echo "🎉 NGINX Ingress Controller installation complete!"
echo ""
echo "📚 Next steps:"
echo "1. Deploy sample applications: kubectl apply -f sample-apps-for-ingress.yaml"
echo "2. Create ingress rules: kubectl apply -f nginx-ingress-examples.yaml"
echo "3. Test access: curl http://localhost/ (or your node IP)"
