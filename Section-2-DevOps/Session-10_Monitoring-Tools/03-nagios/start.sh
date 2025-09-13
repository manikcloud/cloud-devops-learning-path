#!/bin/bash

echo "🚀 Starting Simple Nagios Monitoring..."

# Start services
docker-compose up -d

echo "⏳ Waiting for Nagios to start..."
sleep 15

echo "✅ Ready!"
echo ""
echo "🌐 Nagios Web UI: http://localhost:8080/nagios"
echo "🔑 Login: admin / nagios123"
echo ""
echo "📊 View logs: docker-compose logs -f"
echo "🛑 Stop: docker-compose down"
