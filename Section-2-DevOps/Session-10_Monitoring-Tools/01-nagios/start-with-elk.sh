#!/bin/bash

echo "🚀 Starting Nagios + ELK Stack..."

# Start the services
docker-compose -f docker-compose-with-elk.yml up -d

echo "⏳ Waiting for services to start..."
sleep 30

echo "📊 Services Status:"
echo "- Nagios: http://localhost:8080 (admin/nagios)"
echo "- Nginx: http://localhost:8081"
echo "- Apache: http://localhost:8082"
echo "- Kibana: http://localhost:5601"
echo "- Elasticsearch: http://localhost:9200"

echo "🔄 Generating some web traffic for logs..."
for i in {1..10}; do
  curl -s http://localhost:8081 > /dev/null
  curl -s http://localhost:8082 > /dev/null
  sleep 1
done

echo "✅ Setup complete! Check Kibana for logs in a few minutes."
