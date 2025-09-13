#!/bin/bash

echo "🚀 Starting Simple Nagios Monitoring Setup..."

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker first."
    exit 1
fi

# Check if docker-compose is available
if ! command -v docker-compose &> /dev/null; then
    echo "❌ docker-compose not found. Please install docker-compose."
    exit 1
fi

# Start the services
echo "📦 Building and starting containers..."
docker-compose up -d --build

# Wait for services to be ready
echo "⏳ Waiting for services to start..."
sleep 30

# Check if services are running
if docker-compose ps | grep -q "Up"; then
    echo "✅ Services are running!"
    echo ""
    echo "🌐 Access URLs:"
    echo "   Nagios Web UI: http://localhost:8080/nagios"
    echo "   Login: admin / nagios123"
    echo ""
    echo "   Nginx Target: http://localhost:8081"
    echo "   Apache Target: http://localhost:8082"
    echo ""
    echo "📊 View logs: docker-compose logs -f nagios"
    echo "🛑 Stop all: docker-compose down"
else
    echo "❌ Some services failed to start. Check logs:"
    docker-compose logs
fi
