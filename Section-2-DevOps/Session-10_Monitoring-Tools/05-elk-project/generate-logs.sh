#!/bin/bash

echo "📝 Generating sample logs for ELK Stack..."

# Create log directory if it doesn't exist
sudo mkdir -p /var/log/elk-demo

# Generate application logs
for i in {1..50}; do
    timestamp=$(date '+%Y-%m-%d %H:%M:%S.%3N')
    level=$(shuf -n1 -e "INFO" "WARN" "ERROR" "DEBUG")
    thread="thread-$((RANDOM % 10))"
    logger="com.example.Application"
    message="Sample log message $i with random data: $RANDOM"
    
    echo "$timestamp [$thread] $level $logger - $message" | sudo tee -a /var/log/elk-demo/application.log > /dev/null
done

# Generate access logs
for i in {1..30}; do
    ip="192.168.1.$((RANDOM % 255))"
    timestamp=$(date '+%d/%b/%Y:%H:%M:%S %z')
    method=$(shuf -n1 -e "GET" "POST" "PUT" "DELETE")
    path=$(shuf -n1 -e "/api/users" "/api/orders" "/health" "/metrics")
    status=$(shuf -n1 -e "200" "404" "500" "301")
    size=$((RANDOM % 5000))
    
    echo "$ip - - [$timestamp] \"$method $path HTTP/1.1\" $status $size" | sudo tee -a /var/log/elk-demo/access.log > /dev/null
done

# Generate error logs
for i in {1..10}; do
    timestamp=$(date '+%Y-%m-%d %H:%M:%S.%3N')
    error_msg=$(shuf -n1 -e "NullPointerException" "SQLException" "TimeoutException" "ConnectionException")
    
    echo "$timestamp [ERROR] com.example.Service - $error_msg occurred while processing request $i" | sudo tee -a /var/log/elk-demo/error.log > /dev/null
done

echo "✅ Generated logs:"
echo "   Application logs: /var/log/elk-demo/application.log (50 entries)"
echo "   Access logs:      /var/log/elk-demo/access.log (30 entries)"
echo "   Error logs:       /var/log/elk-demo/error.log (10 entries)"
echo ""
echo "🔍 View logs in Kibana: http://localhost:5601"
echo "📊 Create index pattern: logs-*"
