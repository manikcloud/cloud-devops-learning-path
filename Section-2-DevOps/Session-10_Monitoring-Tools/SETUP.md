# 🚀 Complete Setup Instructions

## Prerequisites
```bash
# Install Docker and Docker Compose
sudo apt update
sudo apt install docker.io docker-compose -y
sudo usermod -aG docker $USER

# Logout and login again, then verify
docker --version
docker-compose --version
```

## Clone and Setup
```bash
# Clone the repository
git clone https://github.com/manikcloud/cloud-devops-learning-path.git

# Navigate to monitoring tools
cd cloud-devops-learning-path/Section-2-DevOps/Session-10_Monitoring-Tools
```

## Option 1: Complete Stack (Recommended)
```bash
# Start everything at once
cd 04-complete-stack
./start.sh

# Access services:
# Grafana: http://localhost:3000 (admin/admin123)
# Prometheus: http://localhost:9090
# Web App: http://localhost:8080
```

## Option 2: Individual Tools

### Grafana Only
```bash
cd 01-grafana
docker-compose up -d
# Access: http://localhost:3000 (admin/admin123)
```

### Application Monitoring
```bash
cd 02-datadog
docker-compose up -d
# Flask App: http://localhost:5000
# Grafana: http://localhost:3000 (admin/admin123)
# Prometheus: http://localhost:9090
```

### Nagios Monitoring
```bash
cd 03-nagios
docker-compose up -d
# Access: http://localhost:8080/nagios (nagiosadmin/nagios)
```

### ELK Stack
```bash
cd 05-elk-project
./start-elk.sh
# Kibana: http://localhost:5601
# Elasticsearch: http://localhost:9200
```

## Verify Everything Works
```bash
# Check running containers
docker ps

# Test endpoints
curl http://localhost:3000  # Grafana
curl http://localhost:9090  # Prometheus
curl http://localhost:5000  # Flask App (if running)
```

## Stop Services
```bash
# Stop specific project
docker-compose down

# Stop all containers
docker stop $(docker ps -q)
```

## Troubleshooting
```bash
# Check logs
docker-compose logs

# Check ports
netstat -tulpn | grep :3000

# Restart Docker
sudo systemctl restart docker
```
