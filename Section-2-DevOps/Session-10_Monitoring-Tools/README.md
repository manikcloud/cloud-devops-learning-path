# 📊 Session 10 - Monitoring Tools

<div align="center">

![Monitoring](https://img.shields.io/badge/Monitoring-Tools-FF6B6B?style=for-the-badge&logo=grafana&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Simple-2496ED?style=for-the-badge&logo=docker&logoColor=white)

**🎯 Simple Monitoring Setup | 📈 Grafana & Prometheus | 🔍 Real Metrics**

</div>

---

## 🚀 **Quick Start - From Scratch**

### **Step 1: Clone Repository**
```bash
# Clone the repository
git clone https://github.com/manikcloud/cloud-devops-learning-path.git

# Navigate to monitoring tools
cd cloud-devops-learning-path/Section-2-DevOps/Session-10_Monitoring-Tools
```

### **Step 2: Start Complete Stack**
```bash
# Start everything at once
cd 04-complete-stack
./start.sh

# Test all services
cd ..
./test-all.sh
```

### **Step 3: Access Services**
- **Grafana**: http://localhost:3000 (admin/admin123)
- **Prometheus**: http://localhost:9090
- **Flask App**: http://localhost:5000
- **Web App**: http://localhost:8080

---

## 📁 **Available Projects**

### **🎯 [Complete Stack](./04-complete-stack/)** ⭐ **START HERE**
```bash
cd 04-complete-stack
./start.sh
```
- Grafana + Prometheus + Node Exporter + Flask App
- One command setup with `./start.sh`
- Pre-configured dashboards
- System and application metrics

### **📊 [Grafana Only](./01-grafana/)**
```bash
cd 01-grafana
docker-compose up -d
```
- Simple Grafana container
- Access: http://localhost:3000

### **📈 [App Monitoring](./02-datadog/)**
```bash
cd 02-datadog
docker-compose up -d
```
- Flask app with custom metrics
- Grafana + Prometheus included
- Application performance monitoring

### **🔍 [Nagios](./03-nagios/)**
```bash
cd 03-nagios
docker-compose up -d
```
- Simple Nagios container
- Access: http://localhost:8080/nagios

### **📋 [ELK Stack](./05-elk-project/)**
```bash
cd 05-elk-project
./start-elk.sh
```
- Complete log analysis
- Kibana: http://localhost:5601

---

## 🎯 **Complete Setup Instructions**

### **Prerequisites**
```bash
# Install Docker and Docker Compose
sudo apt update
sudo apt install docker.io docker-compose -y
sudo usermod -aG docker $USER

# Logout and login again, then verify
docker --version
docker-compose --version
```

### **Clone and Run**
```bash
# 1. Clone repository
git clone https://github.com/manikcloud/cloud-devops-learning-path.git

# 2. Navigate to monitoring tools
cd cloud-devops-learning-path/Section-2-DevOps/Session-10_Monitoring-Tools

# 3. Start complete stack
cd 04-complete-stack
./start.sh

# 4. Test everything works
cd ..
./test-all.sh
```

### **Create Your First Dashboard**
1. Open Grafana: http://localhost:3000
2. Login: admin/admin123
3. Add Prometheus data source: `http://prometheus:9090`
4. Import dashboard ID: `1860` (Node Exporter)
5. Create custom dashboard for Flask app metrics

---

## 📊 **What You'll Monitor**

### **System Metrics (Node Exporter)**
- CPU usage, memory, disk space
- Network traffic
- System load and uptime

### **Application Metrics (Flask App)**
- Request count and rate
- Response time histogram
- Custom business metrics

### **Infrastructure Metrics**
- Container health
- Service availability
- Resource utilization

---

## 🧪 **Testing Your Setup**

### **Generate Traffic**
```bash
# Test Flask app endpoints
curl http://localhost:5000/
curl http://localhost:5000/api/users
curl http://localhost:5000/metrics

# Generate load
for i in {1..100}; do curl http://localhost:5000/; done
```

### **View Metrics**
```bash
# Check Prometheus targets
curl http://localhost:9090/api/v1/targets

# View Flask app metrics
curl http://localhost:5000/metrics
```

---

## 🎯 **Project Assignment**

### **Build Your Monitoring Dashboard**
1. ✅ Clone and start the complete monitoring stack
2. ✅ Create custom Grafana dashboard with 5+ metrics
3. ✅ Set up 2 alerts (high CPU, slow response time)
4. ✅ Generate traffic and analyze patterns
5. ✅ Document your setup and findings

### **Bonus Points**
- Custom Flask app with additional metrics
- Log analysis with ELK stack
- Alert notifications (email/Slack)
- Performance optimization insights

---

## 🛠️ **Troubleshooting**

### **Services Won't Start**
```bash
# Check Docker
docker --version
docker-compose --version

# Check ports are free
netstat -tulpn | grep :3000
```

### **Can't Access Services**
```bash
# Check container status
docker ps

# View logs
docker-compose logs grafana
docker-compose logs prometheus
```

### **No Metrics Data**
```bash
# Check Prometheus targets
# Go to: http://localhost:9090/targets
# All should be "UP"

# Restart services
docker-compose restart
```

### **Reset Everything**
```bash
# Stop all containers
docker-compose down -v

# Remove all data
docker system prune -a

# Start fresh
./start.sh
```

---

## 📚 **Resources**

- [Grafana Documentation](https://grafana.com/docs/)
- [Prometheus Guide](https://prometheus.io/docs/)
- [Flask Metrics](https://prometheus.io/docs/guides/instrumenting/)
- [Docker Compose Reference](https://docs.docker.com/compose/)

---

*Ready to monitor everything? Clone and start monitoring!* 📊
