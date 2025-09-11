# 📊 Simple Grafana Setup

## Quick Start
```bash
# Start Grafana
docker run -d -p 3000:3000 --name grafana grafana/grafana

# Access: http://localhost:3000
# Login: admin/admin
```

## Docker Compose
```yaml
version: '3'
services:
  grafana:
    image: grafana/grafana
    ports:
      - "3000:3000"
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=admin123
```

## First Dashboard
1. Login to http://localhost:3000
2. Add data source (Prometheus/InfluxDB)
3. Create simple dashboard
4. Add basic metrics panel

## Sample Queries
```
# CPU Usage
100 - (avg(irate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)

# Memory Usage
(1 - (node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes)) * 100
```
