#!/bin/bash

echo "🚀 Generating web traffic for log analysis..."

# Generate various types of requests
for i in {1..30}; do
    # Normal requests
    curl -s http://localhost:8081/ > /dev/null
    curl -s http://localhost:8082/ > /dev/null
    
    # 404 errors
    curl -s http://localhost:8081/missing-page > /dev/null
    curl -s http://localhost:8082/not-found > /dev/null
    
    # Different paths
    curl -s http://localhost:8081/test > /dev/null
    curl -s http://localhost:8082/info > /dev/null
    
    echo "Generated request batch $i"
    sleep 1
done

echo "✅ Traffic generation complete!"
echo "📊 Check Kibana at http://localhost:5601 in 2-3 minutes"
