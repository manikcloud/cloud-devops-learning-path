#!/bin/bash

echo "🚀 Starting Complete Monitoring Stack..."

# Start all services
docker-compose up -d

echo "⏳ Waiting for services to start..."
sleep 10

echo "✅ Monitoring Stack is ready!"
echo ""
echo "📊 Access your services:"
echo "   Grafana:    http://localhost:3000 (admin/admin123)"
echo "   Prometheus: http://localhost:9090"
echo "   Web App:    http://localhost:8080"
echo "   Metrics:    http://localhost:9100/metrics"
echo ""
echo "🎯 Next steps:"
echo "   1. Login to Grafana"
echo "   2. Add Prometheus data source: http://prometheus:9090"
echo "   3. Import dashboard ID: 1860"
echo ""
echo "🛑 To stop: docker-compose down"
