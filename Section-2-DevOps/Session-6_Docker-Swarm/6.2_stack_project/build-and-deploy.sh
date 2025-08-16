#!/bin/bash

echo "🐝 Building and Deploying PHP Login App Stack"

# Build custom PHP image
echo "📦 Building PHP image with MySQL support..."
docker build -t php-mysql-app .

# Check if build was successful
if [ $? -eq 0 ]; then
    echo "✅ Image built successfully!"
    
    # Deploy stack
    echo "🚀 Deploying stack..."
    docker stack deploy -c docker-compose.yml loginapp
    
    # Show stack status
    echo "📊 Stack status:"
    docker stack ls
    
    echo ""
    echo "🎉 Deployment complete!"
    echo "📱 Access the app at: http://localhost:8080"
    echo "👥 View users at: http://localhost:8080/users.php"
    echo ""
    echo "⏳ Wait 30-60 seconds for services to be ready..."
    
else
    echo "❌ Image build failed!"
    exit 1
fi
