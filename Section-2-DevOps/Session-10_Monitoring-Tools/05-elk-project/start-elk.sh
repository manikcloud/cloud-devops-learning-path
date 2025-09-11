#!/bin/bash

echo "🚀 Starting ELK Stack Setup..."

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Installing Docker..."
    sudo apt update
    sudo apt install docker.io docker-compose -y
    sudo usermod -aG docker $USER
    echo "✅ Docker installed. Please logout and login again."
    exit 1
fi

# Configure Elasticsearch
echo "🔧 Configuring Elasticsearch..."
sudo sysctl -w vm.max_map_count=262144

# Start ELK Stack
echo "🐳 Starting ELK Stack with Docker Compose..."
docker-compose up -d

# Wait for services to start
echo "⏳ Waiting for services to start..."
sleep 30

# Check service health
echo "🔍 Checking service health..."
echo "Elasticsearch: $(curl -s http://localhost:9200/_cluster/health | jq -r '.status' 2>/dev/null || echo 'Not ready')"
echo "Kibana: $(curl -s -o /dev/null -w '%{http_code}' http://localhost:5601 2>/dev/null || echo 'Not ready')"

echo ""
echo "🎉 ELK Stack is starting up!"
echo ""
echo "📊 Access your services:"
echo "   Kibana:        http://localhost:5601"
echo "   Elasticsearch: http://localhost:9200"
echo ""
echo "📝 Generate test logs:"
echo "   ./generate-logs.sh"
echo ""
echo "🛑 To stop:"
echo "   docker-compose down"
