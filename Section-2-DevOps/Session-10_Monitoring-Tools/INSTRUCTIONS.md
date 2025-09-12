# 🎯 Session 10: Hands-On Instructions

## 📋 Prerequisites Checklist

Before starting, ensure you have:
- [ ] Docker and Docker Compose installed
- [ ] At least 4GB RAM available
- [ ] Ports 3000, 5601, 9090, 9093, 9100, 9200 available
- [ ] Basic understanding of previous sessions (Kubernetes, Terraform)

---

## 🚀 Exercise 1: Complete Monitoring Stack Setup

### **Step 1: Clone and Setup**

```bash
# Navigate to Session 10 directory
cd /path/to/cloud-devops-learning-path/Section-2-DevOps/Session-10_Monitoring-Tools

# Start the complete monitoring stack
docker-compose up -d

# Verify all services are running
docker-compose ps
```

### **Step 2: Access Monitoring Tools**

```bash
# Check service status
echo "🔍 Service URLs:"
echo "Prometheus: http://localhost:9090"
echo "Grafana: http://localhost:3000 (admin/admin123)"
echo "Kibana: http://localhost:5601"
echo "AlertManager: http://localhost:9093"
```

### **Step 3: Verify Metrics Collection**

1. **Open Prometheus** (http://localhost:9090)
2. **Go to Status → Targets**
3. **Verify all targets are UP**
4. **Try sample queries:**
   ```promql
   # CPU usage
   100 - (avg by(instance) (irate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)
   
   # Memory usage
   (node_memory_MemTotal_bytes - node_memory_MemAvailable_bytes) / node_memory_MemTotal_bytes * 100
   
   # Disk usage
   (node_filesystem_size_bytes - node_filesystem_avail_bytes) / node_filesystem_size_bytes * 100
   ```

---

## 📊 Exercise 2: Create Your First Dashboard

### **Step 1: Login to Grafana**

1. **Open Grafana** (http://localhost:3000)
2. **Login:** admin / admin123
3. **Skip password change** (for lab purposes)

### **Step 2: Add Prometheus Data Source**

1. **Go to Configuration → Data Sources**
2. **Click "Add data source"**
3. **Select Prometheus**
4. **URL:** `http://prometheus:9090`
5. **Click "Save & Test"**

### **Step 3: Create System Monitoring Dashboard**

```json
{
  "dashboard": {
    "title": "System Monitoring",
    "panels": [
      {
        "title": "CPU Usage",
        "type": "stat",
        "targets": [
          {
            "expr": "100 - (avg by(instance) (irate(node_cpu_seconds_total{mode=\"idle\"}[5m])) * 100)"
          }
        ]
      },
      {
        "title": "Memory Usage",
        "type": "stat",
        "targets": [
          {
            "expr": "(node_memory_MemTotal_bytes - node_memory_MemAvailable_bytes) / node_memory_MemTotal_bytes * 100"
          }
        ]
      }
    ]
  }
}
```

### **Step 4: Import Pre-built Dashboard**

1. **Go to Dashboards → Import**
2. **Use Dashboard ID: 1860** (Node Exporter Full)
3. **Select Prometheus data source**
4. **Click Import**

---

## 🚨 Exercise 3: Configure Alerting

### **Step 1: Create AlertManager Configuration**

```bash
# Create alertmanager.yml
cat > alertmanager.yml << 'EOF'
global:
  smtp_smarthost: 'localhost:587'
  smtp_from: 'alerts@yourcompany.com'

route:
  group_by: ['alertname']
  group_wait: 10s
  group_interval: 10s
  repeat_interval: 1h
  receiver: 'web.hook'

receivers:
  - name: 'web.hook'
    slack_configs:
      - api_url: 'YOUR_SLACK_WEBHOOK_URL'
        channel: '#alerts'
        title: 'Alert: {{ .GroupLabels.alertname }}'
        text: '{{ range .Alerts }}{{ .Annotations.description }}{{ end }}'

inhibit_rules:
  - source_match:
      severity: 'critical'
    target_match:
      severity: 'warning'
    equal: ['alertname', 'dev', 'instance']
EOF
```

### **Step 2: Test Alert Rules**

```bash
# Generate high CPU load for testing
docker run --rm -it --name cpu-stress progrium/stress --cpu 2 --timeout 300s

# Check alerts in Prometheus
# Go to http://localhost:9090/alerts
```

### **Step 3: Create Grafana Alert**

1. **Open your dashboard panel**
2. **Click Edit → Alert tab**
3. **Create alert rule:**
   - **Name:** High CPU Alert
   - **Condition:** `avg() OF query(A, 5m, now) IS ABOVE 80`
   - **Frequency:** Every 10s for 30s
4. **Add notification channel**

---

## 📝 Exercise 4: Log Management with ELK

### **Step 1: Generate Sample Logs**

```bash
# Create a simple log generator
cat > log-generator.py << 'EOF'
import time
import random
import json
from datetime import datetime

log_levels = ['INFO', 'WARNING', 'ERROR', 'DEBUG']
services = ['web-server', 'api-gateway', 'database', 'auth-service']
users = ['john', 'jane', 'bob', 'alice']

while True:
    log_entry = {
        'timestamp': datetime.now().isoformat(),
        'level': random.choice(log_levels),
        'service': random.choice(services),
        'user': random.choice(users),
        'message': f'Sample log message {random.randint(1, 1000)}',
        'response_time': random.randint(50, 500)
    }
    print(json.dumps(log_entry))
    time.sleep(1)
EOF

# Run log generator
python3 log-generator.py > sample.log &
```

### **Step 2: Configure Logstash Pipeline**

```bash
# Create logstash pipeline directory
mkdir -p logstash/pipeline

# Create logstash configuration
cat > logstash/pipeline/logstash.conf << 'EOF'
input {
  file {
    path => "/usr/share/logstash/logs/sample.log"
    start_position => "beginning"
    sincedb_path => "/dev/null"
  }
}

filter {
  json {
    source => "message"
  }
  
  date {
    match => [ "timestamp", "ISO8601" ]
  }
  
  mutate {
    convert => { "response_time" => "integer" }
  }
}

output {
  elasticsearch {
    hosts => ["elasticsearch:9200"]
    index => "application-logs-%{+YYYY.MM.dd}"
  }
  
  stdout {
    codec => rubydebug
  }
}
EOF
```

### **Step 3: Explore Logs in Kibana**

1. **Open Kibana** (http://localhost:5601)
2. **Go to Management → Index Patterns**
3. **Create index pattern:** `application-logs-*`
4. **Select timestamp field:** `@timestamp`
5. **Go to Discover** to explore logs
6. **Create visualizations** and **dashboards**

---

## 🔍 Exercise 5: Application Performance Monitoring

### **Step 1: Instrument a Sample Application**

```python
# Create app.py
cat > app.py << 'EOF'
from flask import Flask, request
from prometheus_client import Counter, Histogram, generate_latest
import time
import random

app = Flask(__name__)

# Metrics
REQUEST_COUNT = Counter('http_requests_total', 'Total HTTP requests', ['method', 'endpoint', 'status'])
REQUEST_LATENCY = Histogram('http_request_duration_seconds', 'HTTP request latency')

@app.route('/')
@REQUEST_LATENCY.time()
def home():
    REQUEST_COUNT.labels(method='GET', endpoint='/', status='200').inc()
    return "Hello, World!"

@app.route('/slow')
@REQUEST_LATENCY.time()
def slow():
    time.sleep(random.uniform(0.5, 2.0))  # Simulate slow response
    REQUEST_COUNT.labels(method='GET', endpoint='/slow', status='200').inc()
    return "This was slow!"

@app.route('/error')
@REQUEST_LATENCY.time()
def error():
    REQUEST_COUNT.labels(method='GET', endpoint='/error', status='500').inc()
    return "Internal Server Error", 500

@app.route('/metrics')
def metrics():
    return generate_latest()

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
EOF

# Run the application
pip3 install flask prometheus_client
python3 app.py &
```

### **Step 2: Generate Traffic**

```bash
# Create traffic generator
cat > traffic-generator.sh << 'EOF'
#!/bin/bash

while true; do
    # Normal requests
    curl -s http://localhost:8080/ > /dev/null
    
    # Slow requests
    if [ $((RANDOM % 10)) -eq 0 ]; then
        curl -s http://localhost:8080/slow > /dev/null
    fi
    
    # Error requests
    if [ $((RANDOM % 20)) -eq 0 ]; then
        curl -s http://localhost:8080/error > /dev/null
    fi
    
    sleep 0.1
done
EOF

chmod +x traffic-generator.sh
./traffic-generator.sh &
```

### **Step 3: Monitor Application Metrics**

1. **Update prometheus.yml** to scrape your app:
   ```yaml
   - job_name: 'sample-app'
     static_configs:
       - targets: ['localhost:8080']
   ```

2. **Restart Prometheus:**
   ```bash
   docker-compose restart prometheus
   ```

3. **Create application dashboard** with:
   - Request rate: `rate(http_requests_total[5m])`
   - Error rate: `rate(http_requests_total{status="500"}[5m])`
   - Response time: `histogram_quantile(0.95, rate(http_request_duration_seconds_bucket[5m]))`

---

## 🎯 Exercise 6: Kubernetes Monitoring (Bonus)

### **Step 1: Deploy to Kubernetes**

```yaml
# k8s-monitoring.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: sample-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: sample-app
  template:
    metadata:
      labels:
        app: sample-app
      annotations:
        prometheus.io/scrape: "true"
        prometheus.io/port: "8080"
        prometheus.io/path: "/metrics"
    spec:
      containers:
      - name: app
        image: your-app:latest
        ports:
        - containerPort: 8080
---
apiVersion: v1
kind: Service
metadata:
  name: sample-app-service
spec:
  selector:
    app: sample-app
  ports:
  - port: 80
    targetPort: 8080
```

### **Step 2: Monitor Kubernetes Cluster**

```bash
# Deploy Prometheus in Kubernetes
kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/main/bundle.yaml

# Create ServiceMonitor for your app
kubectl apply -f k8s-monitoring.yaml
```

---

## 📊 Assessment Checklist

### **Basic Level (Must Complete)**
- [ ] Successfully deployed monitoring stack
- [ ] Created basic system dashboard
- [ ] Configured at least one alert
- [ ] Explored logs in Kibana
- [ ] Monitored sample application

### **Intermediate Level**
- [ ] Created custom Grafana dashboard
- [ ] Implemented log parsing with Logstash
- [ ] Set up Slack/email notifications
- [ ] Analyzed application performance trends
- [ ] Created SLI/SLO dashboard

### **Advanced Level**
- [ ] Deployed monitoring in Kubernetes
- [ ] Implemented distributed tracing
- [ ] Created custom Prometheus exporters
- [ ] Automated dashboard provisioning
- [ ] Implemented chaos engineering monitoring

---

## 🚀 Next Steps

1. **Integrate with previous sessions:**
   - Monitor your Kubernetes clusters from Session 7
   - Monitor infrastructure deployed with Terraform from Session 8

2. **Prepare for final project:**
   - Plan monitoring strategy for your final project
   - Consider which metrics and logs will be important

3. **Explore advanced topics:**
   - Service mesh monitoring (Istio)
   - Distributed tracing (Jaeger)
   - Chaos engineering (Chaos Monkey)

---

## 🆘 Troubleshooting

### **Common Issues**

1. **Services not starting:**
   ```bash
   # Check logs
   docker-compose logs <service-name>
   
   # Check ports
   netstat -tulpn | grep <port>
   ```

2. **Prometheus targets down:**
   - Check network connectivity
   - Verify service endpoints
   - Check firewall rules

3. **Grafana dashboard not loading:**
   - Verify data source configuration
   - Check Prometheus connectivity
   - Validate query syntax

4. **No logs in Kibana:**
   - Check Elasticsearch health
   - Verify Logstash pipeline
   - Check index patterns

---

*Ready to become a monitoring expert? Complete all exercises and move to the final project!* 🎯
