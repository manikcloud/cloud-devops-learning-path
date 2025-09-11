# 🚀 Complete Monitoring Stack

## All-in-One Setup
```yaml
version: '3'
services:
  # Grafana Dashboard
  grafana:
    image: grafana/grafana
    ports:
      - "3000:3000"
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=admin123

  # Prometheus Metrics
  prometheus:
    image: prom/prometheus
    ports:
      - "9090:9090"
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml

  # Node Exporter
  node-exporter:
    image: prom/node-exporter
    ports:
      - "9100:9100"

  # Simple Web App
  webapp:
    image: nginx
    ports:
      - "8080:80"
```

## Start Everything
```bash
# Clone and start
git clone <repo>
cd 04-complete-stack
docker-compose up -d

# Access services
# Grafana: http://localhost:3000 (admin/admin123)
# Prometheus: http://localhost:9090
# Web App: http://localhost:8080
```

## Create Dashboard
1. Add Prometheus data source: `http://prometheus:9090`
2. Import dashboard ID: 1860 (Node Exporter)
3. View system metrics

## Simple Alerts
```yaml
# prometheus.yml
rule_files:
  - "alert.rules"

# alert.rules
groups:
- name: basic
  rules:
  - alert: HighCPU
    expr: 100 - (avg(irate(node_cpu_seconds_total{mode="idle"}[5m])) * 100) > 80
    for: 2m
```
