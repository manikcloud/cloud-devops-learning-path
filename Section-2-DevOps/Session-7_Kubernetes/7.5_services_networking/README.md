# 🌐 7.5 DNS & Service Discovery

## 🎯 Simple Concept

**Problem**: How do services find each other?  
**Solution**: Kubernetes has built-in DNS!

### It's Like Phone Book for Services
- Every service gets a name
- Other services can call by name
- No need to remember IP addresses

---

## 🔍 How DNS Works in Kubernetes

```
Service Name: web-service
Full DNS Name: web-service.default.svc.cluster.local

But you can just use: web-service
```

### DNS Format
```
<service-name>.<namespace>.svc.cluster.local
```

---

## 🧪 Test DNS (Hands-On)

### Create Two Services
```bash
# Create web service
kubectl create deployment web --image=nginx
kubectl expose deployment web --port=80

# Create database service  
kubectl create deployment db --image=mysql:8.0
kubectl set env deployment/db MYSQL_ROOT_PASSWORD=password
kubectl expose deployment db --port=3306
```

### Test DNS Resolution
```bash
# Create test pod
kubectl run test --image=busybox --rm -it -- /bin/sh

# Inside the pod, try these:
nslookup web
nslookup db
wget -qO- http://web
```

---

## 🌐 Ingress Controllers (External Access)

### What is Ingress?
- **LoadBalancer**: One service = One external IP (expensive!)
- **Ingress**: Many services = One external IP (smart!)

### Simple Ingress Example
```yaml
# simple-ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: simple-ingress
spec:
  rules:
  - host: myapp.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: web-service
            port:
              number: 80
      - path: /api
        pathType: Prefix
        backend:
          service:
            name: api-service
            port:
              number: 8080
```

---

## 🛠️ Install NGINX Ingress Controller

### For Minikube
```bash
# Enable ingress addon
minikube addons enable ingress

# Check it's running
kubectl get pods -n ingress-nginx
```

### For EKS
```bash
# Install NGINX Ingress Controller
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.1/deploy/static/provider/aws/deploy.yaml

# Wait for it to be ready
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=120s
```

---

## 🧪 Ingress Practice

### Exercise: Multi-Service App
```bash
# Create frontend
kubectl create deployment frontend --image=nginx
kubectl expose deployment frontend --port=80

# Create API
kubectl create deployment api --image=httpd
kubectl expose deployment api --port=80

# Create Ingress
cat <<EOF | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: app-ingress
spec:
  rules:
  - http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: frontend
            port:
              number: 80
      - path: /api
        pathType: Prefix
        backend:
          service:
            name: api
            port:
              number: 80
EOF
```

### Test Your Ingress
```bash
# Get ingress IP
kubectl get ingress

# Test (Minikube)
minikube ip
curl http://$(minikube ip)/
curl http://$(minikube ip)/api

# Test (EKS - wait for external IP)
kubectl get ingress app-ingress
curl http://<EXTERNAL-IP>/
curl http://<EXTERNAL-IP>/api
```

---

## 🔒 Add SSL/HTTPS (Bonus)

### Using cert-manager (Advanced)
```bash
# Install cert-manager
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.0/cert-manager.yaml

# Create ClusterIssuer for Let's Encrypt
cat <<EOF | kubectl apply -f -
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-prod
spec:
  acme:
    server: https://acme-v02.api.letsencrypt.org/directory
    email: your-email@example.com
    privateKeySecretRef:
      name: letsencrypt-prod
    solvers:
    - http01:
        ingress:
          class: nginx
EOF
```

### Ingress with SSL
```yaml
# ssl-ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ssl-ingress
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt-prod
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
spec:
  tls:
  - hosts:
    - myapp.yourdomain.com
    secretName: myapp-tls
  rules:
  - host: myapp.yourdomain.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: web-service
            port:
              number: 80
```

---

## 🔍 Troubleshooting DNS Issues

### Common Problems
```bash
# DNS not working?
kubectl get pods -n kube-system | grep coredns

# Test DNS from pod
kubectl run debug --image=busybox --rm -it -- nslookup kubernetes

# Check service endpoints
kubectl get endpoints <service-name>

# Describe service
kubectl describe service <service-name>
```

### Debug Commands
```bash
# Check CoreDNS logs
kubectl logs -n kube-system -l k8s-app=kube-dns

# Test specific service
kubectl run test --image=busybox --rm -it -- nslookup <service-name>

# Check if service exists
kubectl get services
```

---

## 🎯 What You Learned

- ✅ Services get automatic DNS names
- ✅ Services can find each other by name
- ✅ Ingress routes external traffic to services
- ✅ NGINX Ingress Controller setup
- ✅ Basic SSL/HTTPS configuration
- ✅ DNS troubleshooting

## 🚀 Next Step

Ready to learn auto-scaling and rolling updates? Go to **[7.6 - Auto-scaling & Updates](../7.6_autoscaling_updates/)**

---

*Names are easier than numbers!* 🌐🔍
