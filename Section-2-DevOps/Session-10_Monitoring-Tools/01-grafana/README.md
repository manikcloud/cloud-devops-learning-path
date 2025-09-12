# 📊 Grafana Dashboard Project

**Simple Grafana setup for learning dashboard creation**

---

## 🚀 Quick Start

```bash
# Start Grafana
docker-compose up -d

# Access dashboard
echo "Grafana: http://localhost:3000 (admin/admin)"
```

---

## 🎯 What You'll Learn

- Grafana dashboard basics
- Creating visualizations
- Data source configuration
- Panel customization

---

## 📈 Getting Started

### **Step 1: Start Grafana**
```bash
docker-compose up -d
```

### **Step 2: Login**
- URL: http://localhost:3000
- Username: admin
- Password: admin

### **Step 3: Add Data Source**
1. Go to Configuration → Data Sources
2. Add Prometheus data source
3. URL: http://prometheus:9090 (if using complete stack)

### **Step 4: Create Dashboard**
1. Click "+" → Dashboard
2. Add new panel
3. Write PromQL queries
4. Customize visualization

---

## 📊 Sample Queries

```promql
# System metrics (requires Node Exporter)
node_cpu_seconds_total
node_memory_MemTotal_bytes
node_filesystem_size_bytes

# Application metrics (requires app instrumentation)
http_requests_total
http_request_duration_seconds
```

---

## 🛠️ Configuration

- **docker-compose.yml** - Grafana service definition
- Default admin credentials: admin/admin
- Data persisted in Docker volume

---

## 🧹 Cleanup

```bash
docker-compose down -v
```

---

*Perfect for learning Grafana dashboard creation!* 📊
