# 🏪 Docker Registry - Push to Docker Hub

## 📖 What is Docker Registry?

Docker Registry stores and shares Docker images. **Docker Hub** is the most popular public registry.

---

## 🚀 Simple Steps

### **Step 1: Create Docker Hub Account**
- Go to [hub.docker.com](https://hub.docker.com)
- Sign up for free account

### **Step 2: Login**
```bash
docker login
# Enter your username and password
```

### **Step 3: Build and Push**
```bash
# Navigate to project
cd ../5.2_docker_project

# Build app
mvn clean package

# Build image with your username
docker build -t yourusername/addressbook-app .

# Push to Docker Hub
docker push yourusername/addressbook-app
```

### **Step 4: Pull and Run**
```bash
# Anyone can now pull your image
docker pull yourusername/addressbook-app

# Run from Docker Hub
docker run -d -p 9090:8080 yourusername/addressbook-app
```

---

## 🔧 Essential Commands

```bash
# Login
docker login

# Tag image
docker tag addressbook-app yourusername/addressbook-app

# Push image
docker push yourusername/addressbook-app

# Pull image
docker pull yourusername/addressbook-app

# Search images
docker search nginx
```

---

## 🚀 Use the Script

```bash
# Make script executable
chmod +x push-to-hub.sh

# Run script
./push-to-hub.sh
```

---

*Share your Docker images with the world!* 🚀
