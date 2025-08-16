#!/bin/bash

# Simple script to push to Docker Hub

echo "Pushing to Docker Hub..."

# Get username
read -p "Enter your Docker Hub username: " USERNAME

# Go to project
cd ../5.2_docker_project

# Build app
mvn clean package

# Build image
docker build -t $USERNAME/addressbook-app .

# Push to Docker Hub
docker push $USERNAME/addressbook-app

echo "Done! Check: https://hub.docker.com"
echo "Run with: docker run -d -p 9090:8080 $USERNAME/addressbook-app"
