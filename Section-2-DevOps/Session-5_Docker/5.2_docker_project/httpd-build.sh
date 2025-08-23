#!/bin/bash

echo "🐳 Building Apache HTTPD Docker Container..."

# Build the Docker image
echo "📦 Building Docker image..."
docker build -f Dockerfile.httpd -t my-httpd .

# Check if build was successful
if [ $? -eq 0 ]; then
    echo "✅ Build successful!"
    
    # Stop and remove existing container if it exists
    echo "🧹 Cleaning up existing container..."
    docker stop my-apache 2>/dev/null
    docker rm my-apache 2>/dev/null
    
    # Run the new container
    echo "🚀 Starting Apache container..."
    docker run -d -p 8080:80 --name my-apache my-httpd
    
    if [ $? -eq 0 ]; then
        echo "✅ Apache HTTPD is running!"
        echo "🌐 Access your website at: http://localhost:8080"
        echo ""
        echo "📊 Container status:"
        docker ps | grep my-apache
    else
        echo "❌ Failed to start container"
    fi
else
    echo "❌ Build failed"
fi
