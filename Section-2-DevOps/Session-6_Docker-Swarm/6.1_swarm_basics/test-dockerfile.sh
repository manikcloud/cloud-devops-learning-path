#!/bin/bash

# Test script for Docker Swarm Hello World application
# This script tests the Dockerfile and ensures everything works correctly

set -e  # Exit on any error

echo "🐝 Testing Docker Swarm Hello World Application"
echo "================================================"

# Check if required files exist
echo "📁 Checking required files..."
if [ ! -f "Dockerfile" ]; then
    echo "❌ Dockerfile not found!"
    exit 1
fi

if [ ! -f "index.html" ]; then
    echo "❌ index.html not found!"
    exit 1
fi

echo "✅ All required files found"

# Check if Docker is running
echo "🐳 Checking Docker status..."
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running or not accessible"
    echo "💡 Try: sudo systemctl start docker"
    exit 1
fi

echo "✅ Docker is running"

# Build the image
echo "🔨 Building Docker image..."
if docker build -t hello-swarm-test . > /dev/null 2>&1; then
    echo "✅ Docker image built successfully"
else
    echo "❌ Docker build failed"
    echo "🔍 Running build with verbose output:"
    docker build -t hello-swarm-test .
    exit 1
fi

# Test the container
echo "🚀 Testing container..."
CONTAINER_ID=$(docker run -d -p 8081:80 hello-swarm-test)

# Wait for container to start
sleep 3

# Test if the web server is responding
if curl -s http://localhost:8081 > /dev/null; then
    echo "✅ Container is running and web server is accessible"
else
    echo "❌ Web server is not accessible"
    echo "🔍 Container logs:"
    docker logs $CONTAINER_ID
    docker stop $CONTAINER_ID > /dev/null
    docker rm $CONTAINER_ID > /dev/null
    exit 1
fi

# Cleanup
echo "🧹 Cleaning up test container..."
docker stop $CONTAINER_ID > /dev/null
docker rm $CONTAINER_ID > /dev/null

echo ""
echo "🎉 All tests passed! Your Dockerfile is working correctly."
echo "📝 You can now proceed with the Docker Swarm setup."
echo ""
echo "Next steps:"
echo "1. docker build -t hello-swarm ."
echo "2. docker swarm init"
echo "3. docker service create --name hello-swarm --publish 8080:80 --replicas 3 hello-swarm"
