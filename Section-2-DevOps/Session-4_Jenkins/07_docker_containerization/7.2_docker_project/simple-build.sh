#!/bin/bash

# 🐳 Simple Docker Build Script for Address Book
# Clean and simple approach - no Docker Compose complexity

echo "🚀 Building Address Book Docker Container..."

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Step 1: Build Java application
print_info "Building Java application with Maven..."
if mvn clean package -q; then
    print_success "Maven build completed!"
else
    print_error "Maven build failed!"
    exit 1
fi

# Step 2: Build Docker image
print_info "Building Docker image..."
if docker build -t addressbook-app . -q; then
    print_success "Docker image built!"
else
    print_error "Docker build failed!"
    exit 1
fi

# Step 3: Stop and remove existing container
print_info "Cleaning up existing container..."
docker stop addressbook 2>/dev/null || true
docker rm addressbook 2>/dev/null || true

# Step 4: Run new container
print_info "Starting new container..."
if docker run -d -p 8090:8080 --name addressbook addressbook-app; then
    print_success "Container started!"
else
    print_error "Failed to start container!"
    exit 1
fi

# Step 5: Wait and test
print_info "Waiting for application to start..."
sleep 5

if curl -s http://localhost:8090/addressbook/ > /dev/null; then
    print_success "Application is running!"
else
    print_info "Application may still be starting..."
fi

echo ""
echo "🎉 Done!"
echo "📱 Access: http://localhost:8090/addressbook/"
echo "🔍 Logs: docker logs addressbook"
echo "⏹️  Stop: docker stop addressbook"
