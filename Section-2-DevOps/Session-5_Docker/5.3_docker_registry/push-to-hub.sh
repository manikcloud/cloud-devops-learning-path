#!/bin/bash

# Simple script to build and push to Docker Hub

echo "Building and pushing to Docker Hub..."

# Get Docker Hub username
read -p "Enter your Docker Hub username: " USERNAME

# Navigate to project directory
cd ../5.2_docker_project

# Build application
echo "Building Java application..."
mvn clean package
if [ $? -ne 0 ]; then
    echo "Maven build failed!"
    exit 1
fi

# Build Docker image
echo "Building Docker image..."
docker build -t $USERNAME/addressbook-app:latest .
if [ $? -ne 0 ]; then
    echo "Docker build failed!"
    exit 1
fi

# Push to Docker Hub
echo "Pushing to Docker Hub..."
docker push $USERNAME/addressbook-app:latest
if [ $? -ne 0 ]; then
    echo "Docker push failed! Make sure you're logged in with 'docker login'"
    exit 1
fi

echo "Success! Image pushed to Docker Hub."
echo "Check your account at: https://hub.docker.com"
echo "Run with: docker run -d -p 9090:8080 --name addressbook $USERNAME/addressbook-app"
