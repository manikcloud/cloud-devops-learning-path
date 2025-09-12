#!/bin/bash

# 🚀 Session 10: Monitoring Tools - Quick Setup Script
# This script sets up the complete monitoring stack for students

set -e

echo "🎯 Setting up Session 10: Monitoring & Observability Tools"
echo "=================================================="

# Check prerequisites
echo "📋 Checking prerequisites..."

# Check Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    exit 1
fi

# Check Docker Compose
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi

echo "✅ Prerequisites check passed!"

# Create necessary directories
echo "📁 Creating directory structure..."
mkdir -p grafana/provisioning/datasources
mkdir -p grafana/provisioning/dashboards
mkdir -p logstash/pipeline
mkdir -p logstash/config
mkdir -p sample-app

# Create AlertManager configuration
echo "🚨 Creating AlertManager configuration..."
cat > alertmanager.yml << 'EOF'
global:
  smtp_smarthost: 'localhost:587'
  smtp_from: 'monitoring@example.com'

route:
  group_by: ['alertname']
  group_wait: 10s
  group_interval: 10s
  repeat_interval: 1h
  receiver: 'default'

receivers:
  - name: 'default'
    webhook_configs:
      - url: 'http://localhost:5001/webhook'
        send_resolved: true

inhibit_rules:
  - source_match:
      severity: 'critical'
    target_match:
      severity: 'warning'
    equal: ['alertname', 'instance']
EOF

# Create Grafana datasource provisioning
echo "📊 Creating Grafana datasource configuration..."
cat > grafana/provisioning/datasources/prometheus.yml << 'EOF'
apiVersion: 1

datasources:
  - name: Prometheus
    type: prometheus
    access: proxy
    url: http://prometheus:9090
    isDefault: true
    editable: true
EOF

# Create Logstash configuration
echo "📝 Creating Logstash configuration..."
cat > logstash/pipeline/logstash.conf << 'EOF'
input {
  beats {
    port => 5044
  }
  
  tcp {
    port => 5000
    codec => json_lines
  }
}

filter {
  if [fields][log_type] == "application" {
    json {
      source => "message"
    }
    
    date {
      match => [ "timestamp", "ISO8601" ]
    }
  }
}

output {
  elasticsearch {
    hosts => ["elasticsearch:9200"]
    index => "logs-%{+YYYY.MM.dd}"
  }
  
  stdout {
    codec => rubydebug
  }
}
EOF

# Create sample Nginx configuration
echo "🌐 Creating sample application configuration..."
cat > sample-app/nginx.conf << 'EOF'
events {
    worker_connections 1024;
}

http {
    log_format main '$remote_addr - $remote_user [$time_local] "$request" '
                    '$status $body_bytes_sent "$http_referer" '
                    '"$http_user_agent" "$http_x_forwarded_for"';

    access_log /var/log/nginx/access.log main;
    error_log /var/log/nginx/error.log;

    server {
        listen 80;
        server_name localhost;

        location / {
            root /usr/share/nginx/html;
            index index.html;
        }

        location /metrics {
            stub_status on;
            access_log off;
        }
    }
}
EOF

# Create sample HTML page
cat > sample-app/index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Monitoring Demo App</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .container { max-width: 800px; margin: 0 auto; }
        .status { padding: 20px; background: #e8f5e8; border-radius: 5px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🎯 Session 10: Monitoring Demo Application</h1>
        <div class="status">
            <h2>✅ Application Status: Running</h2>
            <p>This is a sample application for monitoring demonstration.</p>
            <ul>
                <li><strong>Prometheus:</strong> <a href="http://localhost:9090">http://localhost:9090</a></li>
                <li><strong>Grafana:</strong> <a href="http://localhost:3000">http://localhost:3000</a> (admin/admin123)</li>
                <li><strong>Kibana:</strong> <a href="http://localhost:5601">http://localhost:5601</a></li>
                <li><strong>AlertManager:</strong> <a href="http://localhost:9093">http://localhost:9093</a></li>
            </ul>
        </div>
    </div>
</body>
</html>
EOF

# Update docker-compose to use the sample app files
echo "🔧 Updating Docker Compose configuration..."
sed -i 's|./sample-app/nginx.conf:/etc/nginx/nginx.conf|./sample-app/nginx.conf:/etc/nginx/nginx.conf\n      - ./sample-app/index.html:/usr/share/nginx/html/index.html|' docker-compose.yml

# Start the monitoring stack
echo "🚀 Starting monitoring stack..."
docker-compose up -d

# Wait for services to start
echo "⏳ Waiting for services to start..."
sleep 30

# Check service status
echo "🔍 Checking service status..."
docker-compose ps

# Display access information
echo ""
echo "🎉 Setup completed successfully!"
echo "=================================================="
echo "📊 Access your monitoring tools:"
echo ""
echo "🔍 Prometheus:    http://localhost:9090"
echo "📊 Grafana:       http://localhost:3000 (admin/admin123)"
echo "📝 Kibana:        http://localhost:5601"
echo "🚨 AlertManager:  http://localhost:9093"
echo "🌐 Sample App:    http://localhost:8080"
echo ""
echo "📚 Next steps:"
echo "1. Open Grafana and import dashboard ID: 1860"
echo "2. Check Prometheus targets: http://localhost:9090/targets"
echo "3. Follow the INSTRUCTIONS.md for hands-on exercises"
echo ""
echo "🆘 Troubleshooting:"
echo "- Check logs: docker-compose logs <service-name>"
echo "- Restart services: docker-compose restart"
echo "- Stop all: docker-compose down"
echo ""
echo "Happy monitoring! 🚀"
