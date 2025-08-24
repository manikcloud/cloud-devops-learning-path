# 🚀 Services & Networking - Hands-On Instructions

## 📁 Available YAML Files

| File | Description | Type | Purpose |
|------|-------------|------|---------|
| `01-clusterip-service.yaml` | Internal service | ClusterIP | Internal communication |
| `02-nodeport-service.yaml` | External service | NodePort | External access |
| `03-loadbalancer-service.yaml` | Cloud service | LoadBalancer | AWS ALB integration |
| `04-multi-port-service.yaml` | Multiple ports | NodePort | HTTP + HTTPS |
| `05-session-affinity-service.yaml` | Sticky sessions | ClusterIP | Session persistence |
| `06-blue-green-service.yaml` | Version switching | NodePort | Blue-green deployment |
| `07-complete-app.yaml` | Full application | Mixed | 3-tier app |
| `08-test-pods.yaml` | Test pods | Pods | For testing services |

---

## 🎯 Exercise 1: ClusterIP Service (Internal Communication)

### **Step 1: Create Test Pod**
```bash
# Create a pod that matches the service selector
kubectl apply -f 08-test-pods.yaml

# Verify pod is running
kubectl get pods
```

### **Step 2: Create ClusterIP Service**
```bash
# Create the internal service
kubectl apply -f 01-clusterip-service.yaml

# Check the service
kubectl get services
kubectl describe service web-service
```

### **Step 3: Test Internal Access**
```bash
# Test from inside the cluster
kubectl run test --image=busybox --rm -it -- wget -qO- http://web-service

# Check service endpoints
kubectl get endpoints web-service
```

### **Step 4: Clean Up**
```bash
kubectl delete -f 01-clusterip-service.yaml
kubectl delete pod web-pod
```

---

## 🚪 Exercise 2: NodePort Service (External Access)

### **Step 1: Create Blue App Pod**
```bash
# Create blue app pod (already created in Exercise 1)
kubectl get pod blue-app
```

### **Step 2: Create NodePort Service**
```bash
# Create external access service
kubectl apply -f 02-nodeport-service.yaml

# Check the service and note the port
kubectl get services
```

### **Step 3: Test External Access**
```bash
# Access from your browser or curl
curl http://localhost:30080

# Or open in browser: http://localhost:30080
```

### **Step 4: Clean Up**
```bash
kubectl delete -f 02-nodeport-service.yaml
kubectl delete pod blue-app
```

---

## ☁️ Exercise 3: LoadBalancer Service (AWS Cloud)

### **Prerequisites**
- Running on AWS EKS or EC2 with proper IAM roles
- AWS Load Balancer Controller installed

### **Step 1: Create Blue App Pod**
```bash
# Create pod for LoadBalancer
kubectl apply -f 08-test-pods.yaml
kubectl get pod blue-app
```

### **Step 2: Create LoadBalancer Service**
```bash
# Create AWS ALB
kubectl apply -f 03-loadbalancer-service.yaml

# Wait for LoadBalancer to be ready (2-3 minutes)
kubectl get services -w
```

### **Step 3: Test External Access**
```bash
# Get external URL
EXTERNAL_URL=$(kubectl get service web-loadbalancer -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
echo "Application available at: http://$EXTERNAL_URL"

# Test the application
curl http://$EXTERNAL_URL
```

### **Step 4: Check AWS Console**
```bash
echo "Check AWS Console → EC2 → Load Balancers to see your ALB"
```

### **Step 5: Clean Up (Important!)**
```bash
# Delete to avoid AWS charges
kubectl delete -f 03-loadbalancer-service.yaml
kubectl delete pod blue-app
```

---

## 🔄 Exercise 4: Blue-Green Deployment

### **Step 1: Create Blue and Green Pods**
```bash
# Create both versions
kubectl apply -f 08-test-pods.yaml

# Verify both pods are running
kubectl get pods -l app=web
```

### **Step 2: Create Service Pointing to Blue**
```bash
# Create service initially pointing to blue
kubectl apply -f 06-blue-green-service.yaml

# Test blue version
curl http://localhost:30090
```

### **Step 3: Switch to Green**
```bash
# Update service to point to green version
kubectl patch service web-switch -p '{"spec":{"selector":{"version":"green"}}}'

# Test green version
curl http://localhost:30090
```

### **Step 4: Switch Back to Blue**
```bash
# Switch back to blue
kubectl patch service web-switch -p '{"spec":{"selector":{"version":"blue"}}}'

# Verify switch
curl http://localhost:30090
```

### **Step 5: Clean Up**
```bash
kubectl delete -f 06-blue-green-service.yaml
kubectl delete pod blue-app green-app
```

---

## 🌐 Exercise 5: Complete 3-Tier Application

### **Step 1: Deploy Complete Application**
```bash
# Deploy entire application stack
kubectl apply -f 07-complete-app.yaml

# Check all resources
kubectl get all
```

### **Step 2: Wait for LoadBalancer**
```bash
# Wait for AWS ALB to be ready
kubectl get services frontend-lb -w

# Get external URL
EXTERNAL_URL=$(kubectl get service frontend-lb -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
echo "Application available at: http://$EXTERNAL_URL"
```

### **Step 3: Test Application**
```bash
# Test frontend
curl http://$EXTERNAL_URL

# Test internal service discovery
kubectl run test --image=busybox --rm -it -- /bin/sh
# Inside the pod:
# wget -qO- http://api
# nslookup database
# exit
```

### **Step 4: Check Service Discovery**
```bash
# Test DNS resolution
kubectl run dns-test --image=busybox --rm -it -- nslookup api
kubectl run dns-test --image=busybox --rm -it -- nslookup database
```

### **Step 5: Clean Up**
```bash
# Clean up entire application
kubectl delete -f 07-complete-app.yaml
```

---

## 🔧 Exercise 6: Multi-Port Service

### **Step 1: Create Multi-Port Application**
```bash
# Create deployment with multiple ports
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: multi-port-app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: web-app
  template:
    metadata:
      labels:
        app: web-app
    spec:
      containers:
      - name: nginx
        image: nginx
        ports:
        - containerPort: 80
        - containerPort: 443
EOF
```

### **Step 2: Create Multi-Port Service**
```bash
# Create service with multiple ports
kubectl apply -f 04-multi-port-service.yaml

# Check the service
kubectl get services multi-port-service
```

### **Step 3: Test Both Ports**
```bash
# Test HTTP port
curl http://localhost:30080

# Test HTTPS port (might not work without SSL setup)
# curl https://localhost:30443
```

### **Step 4: Clean Up**
```bash
kubectl delete -f 04-multi-port-service.yaml
kubectl delete deployment multi-port-app
```

---

## 🔒 Exercise 7: Session Affinity

### **Step 1: Create Deployment**
```bash
# Create deployment with multiple replicas
kubectl create deployment sticky-app --image=nginx --replicas=3

# Label the deployment
kubectl label deployment sticky-app app=web-app
```

### **Step 2: Create Session Affinity Service**
```bash
# Create service with session affinity
kubectl apply -f 05-session-affinity-service.yaml

# Check the service
kubectl describe service sticky-service
```

### **Step 3: Test Session Affinity**
```bash
# Port forward to test
kubectl port-forward service/sticky-service 8080:80 &

# Make multiple requests from same IP
for i in {1..5}; do
  echo "Request $i:"
  curl -s http://localhost:8080 | grep "Welcome"
done

# Stop port forwarding
pkill -f "kubectl port-forward"
```

### **Step 4: Clean Up**
```bash
kubectl delete -f 05-session-affinity-service.yaml
kubectl delete deployment sticky-app
```

---

## 🔍 Troubleshooting Commands

### **Check Service Status**
```bash
# List all services
kubectl get services

# Describe specific service
kubectl describe service <service-name>

# Check service endpoints
kubectl get endpoints <service-name>
```

### **Check Pod Status**
```bash
# List pods with labels
kubectl get pods --show-labels

# Check pod logs
kubectl logs <pod-name>

# Execute into pod
kubectl exec -it <pod-name> -- /bin/bash
```

### **Test Connectivity**
```bash
# Test internal service
kubectl run test --image=busybox --rm -it -- wget -qO- http://<service-name>

# Test DNS resolution
kubectl run test --image=busybox --rm -it -- nslookup <service-name>

# Port forward for local testing
kubectl port-forward service/<service-name> 8080:80
```

### **Debug Network Issues**
```bash
# Check CoreDNS
kubectl get pods -n kube-system -l k8s-app=kube-dns

# Check events
kubectl get events --sort-by=.metadata.creationTimestamp

# Check service configuration
kubectl get service <service-name> -o yaml
```

---

## 📋 Quick Reference

### **Service Types**
- **ClusterIP**: Internal only, default type
- **NodePort**: External access via node IP:port
- **LoadBalancer**: Cloud load balancer with external IP

### **Common Ports**
- **HTTP**: 80
- **HTTPS**: 443
- **NodePort Range**: 30000-32767

### **DNS Names**
- **Same namespace**: `service-name`
- **Different namespace**: `service-name.namespace`
- **Full name**: `service-name.namespace.svc.cluster.local`

### **Useful Labels**
- **app**: Application name
- **version**: Application version
- **tier**: Application tier (frontend, backend, database)
- **environment**: Environment (dev, staging, prod)

---

## 🎯 Success Criteria

You've mastered services when you can:
- ✅ Create and test ClusterIP services
- ✅ Create and access NodePort services
- ✅ Deploy LoadBalancer services on AWS
- ✅ Implement blue-green deployments
- ✅ Build complete multi-tier applications
- ✅ Troubleshoot service connectivity issues
- ✅ Use service discovery effectively

---

*Happy learning! 🚀*
