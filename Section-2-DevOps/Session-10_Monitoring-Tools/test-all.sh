#!/bin/bash

echo "🧪 Testing All Monitoring Services..."

# Function to test URL
test_url() {
    local url=$1
    local name=$2
    
    if curl -s -o /dev/null -w "%{http_code}" "$url" | grep -q "200\|302"; then
        echo "✅ $name is working: $url"
    else
        echo "❌ $name is not responding: $url"
    fi
}

echo ""
echo "🔍 Checking services..."

# Test common endpoints
test_url "http://localhost:3000" "Grafana"
test_url "http://localhost:9090" "Prometheus"
test_url "http://localhost:5000" "Flask App"
test_url "http://localhost:8080" "Nagios"
test_url "http://localhost:5601" "Kibana"
test_url "http://localhost:9200" "Elasticsearch"

echo ""
echo "🐳 Running containers:"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

echo ""
echo "📊 Access your services:"
echo "   Grafana:       http://localhost:3000 (admin/admin123)"
echo "   Prometheus:    http://localhost:9090"
echo "   Flask App:     http://localhost:5000"
echo "   Nagios:        http://localhost:8080/nagios (nagiosadmin/nagios)"
echo "   Kibana:        http://localhost:5601"
echo "   Elasticsearch: http://localhost:9200"
