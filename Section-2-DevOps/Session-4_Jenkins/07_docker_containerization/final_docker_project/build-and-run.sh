#!/bin/bash

# 🐳 Address Book Docker Build and Run Script
# This script automates the entire process of building and running the containerized application

echo "🚀 Starting Address Book Docker Deployment..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Maven is installed
if ! command -v mvn &> /dev/null; then
    print_error "Maven is not installed. Please install Maven first."
    exit 1
fi

# Check if Docker is installed and running
if ! command -v docker &> /dev/null; then
    print_error "Docker is not installed. Please install Docker first."
    exit 1
fi

if ! docker info &> /dev/null; then
    print_error "Docker is not running. Please start Docker first."
    exit 1
fi

print_status "All prerequisites are met!"

# Step 1: Clean up any existing containers
print_status "Cleaning up existing containers..."
docker-compose down 2>/dev/null || true
docker rm -f addressbook-app 2>/dev/null || true

# Step 2: Build the Java application
print_status "Building Java application with Maven..."
if mvn clean package -q; then
    print_success "Maven build completed successfully!"
else
    print_error "Maven build failed!"
    exit 1
fi

# Check if WAR file was created
if [ ! -f "target/addressbook.war" ]; then
    print_error "WAR file not found! Maven build may have failed."
    exit 1
fi

print_success "WAR file created: target/addressbook.war"

# Step 3: Build Docker image
print_status "Building Docker image..."
if docker build -t addressbook-app . -q; then
    print_success "Docker image built successfully!"
else
    print_error "Docker image build failed!"
    exit 1
fi

# Step 4: Run with Docker Compose
print_status "Starting application with Docker Compose..."
if docker-compose up -d; then
    print_success "Application started successfully!"
else
    print_error "Failed to start application with Docker Compose!"
    exit 1
fi

# Step 5: Wait for application to start
print_status "Waiting for application to start..."
sleep 10

# Step 6: Test if application is accessible
print_status "Testing application accessibility..."
if curl -s http://localhost:8090/addressbook/ > /dev/null; then
    print_success "Application is accessible!"
else
    print_warning "Application may still be starting. Please wait a moment and try again."
fi

# Step 7: Display status and access information
echo ""
echo "🎉 Deployment Complete!"
echo "=================================="
echo "📱 Application URL: http://localhost:8090/addressbook/"
echo "🐳 Container Name: addressbook-app"
echo "🔍 View Logs: docker-compose logs -f"
echo "⏹️  Stop App: docker-compose down"
echo ""

# Display running containers
print_status "Running containers:"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

echo ""
print_success "Address Book application is now running in Docker!"
print_status "Open your browser and navigate to: http://localhost:8090/addressbook/"
