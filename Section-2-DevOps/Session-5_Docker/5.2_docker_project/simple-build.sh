#!/bin/bash

# Simple Docker Build Script for Address Book

echo "Building Address Book Docker Container..."

# Build Java application
echo "Building Java application..."
mvn clean package
if [ $? -ne 0 ]; then
    echo "Maven build failed!"
    exit 1
fi

# Build Docker image
echo "Building Docker image..."
docker build -t addressbook-app .
if [ $? -ne 0 ]; then
    echo "Docker build failed!"
    exit 1
fi

# Stop and remove existing container
echo "Cleaning up existing container..."
docker stop addressbook 2>/dev/null
docker rm addressbook 2>/dev/null

# Run new container
echo "Starting new container..."
docker run -d -p 8090:8080 --name addressbook addressbook-app
if [ $? -ne 0 ]; then
    echo "Failed to start container!"
    exit 1
fi

# Wait for application to start
echo "Waiting for application to start..."
sleep 5

# Test application
if curl -s http://localhost:8090/addressbook/ > /dev/null; then
    echo "Success! Application is running at http://localhost:8090/addressbook/"
else
    echo "Application may still be starting. Check with: docker logs addressbook"
fi

echo "Done!"
