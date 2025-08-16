# 🐝 Docker Swarm Basics & Project

## 📋 Essential Commands

### **Initialize Swarm (Multi-Node)**
```bash
# On Manager Node (EC2-1)
docker swarm init

# Get worker join token
docker swarm join-token worker

# On Worker Node (EC2-2) - use token from above
docker swarm join --token <token> <manager-private-ip>:2377

# Verify nodes (on manager)
docker node ls
```

### **Service Management**
```bash
# Create service
docker service create --name web --publish 8080:80 --replicas 3 nginx

# List services
docker service ls

# Check service details
docker service ps web

# Scale service
docker service scale web=5

# Update service
docker service update --image nginx:alpine web

# Remove service
docker service rm web
```

---

## 🚀 Simple Web Project

### **Step 1: Create Custom Web App**
```bash
# Create project files
mkdir hello-swarm && cd hello-swarm

# Create simple HTML file
cat > index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Docker Swarm Hello World</title>
    <style>
        body { font-family: Arial; text-align: center; padding: 50px; 
               background-color: #3498db; color: white; }
        button { padding: 10px 20px; margin: 10px; font-size: 16px; 
                 border: none; border-radius: 5px; cursor: pointer; }
    </style>
</head>
<body>
    <h1>🐝 Docker Swarm Hello World</h1>
    <p>This page is served by Docker Swarm!</p>
    
    <h3>Change Background Color:</h3>
    <button onclick="changeColor('#3498db')" style="background-color: #3498db; color: white;">Blue</button>
    <button onclick="changeColor('#e74c3c')" style="background-color: #e74c3c; color: white;">Red</button>
    <button onclick="changeColor('#2ecc71')" style="background-color: #2ecc71; color: white;">Green</button>
    <button onclick="changeColor('#f39c12')" style="background-color: #f39c12; color: white;">Orange</button>

    <script>
        function changeColor(color) {
            document.body.style.backgroundColor = color;
        }
    </script>
</body>
</html>
EOF

# Create Dockerfile
cat > Dockerfile << 'EOF'
FROM httpd:2.4-alpine
COPY index.html /usr/local/apache2/htdocs/
EXPOSE 80
EOF
```

### **Step 2: Build and Deploy**
```bash
# Build image
docker build -t hello-swarm .

# Initialize swarm
docker swarm init

# Deploy service
docker service create --name web --publish 8080:80 --replicas 3 hello-swarm

# Check deployment
docker service ps web

# Access: http://localhost:8080
```

### **Step 3: Scale and Test**
```bash
# Scale up
docker service scale web=5

# Check distribution across nodes
docker service ps web

# Test load balancing
curl http://localhost:8080
```

---

## 🔍 Troubleshooting

```bash
# If join fails:
ping <manager-private-ip>
sudo systemctl status docker
sudo systemctl start docker

# Regenerate token if needed
docker swarm join-token --rotate worker
```

---

*Simple Docker Swarm with interactive web app!* 🚀
