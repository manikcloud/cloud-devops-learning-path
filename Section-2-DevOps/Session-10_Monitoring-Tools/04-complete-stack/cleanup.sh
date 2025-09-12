#!/bin/bash

# 🧹 Session 10: Monitoring Tools - Cleanup Script
# This script cleans up the monitoring stack

echo "🧹 Cleaning up Session 10: Monitoring Tools"
echo "============================================"

# Stop and remove containers
echo "🛑 Stopping containers..."
docker-compose down

# Remove volumes (optional - uncomment if you want to remove data)
echo "🗑️  Removing volumes..."
read -p "Do you want to remove all monitoring data? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    docker-compose down -v
    echo "✅ All data removed"
else
    echo "📊 Data preserved for next session"
fi

# Remove unused images (optional)
read -p "Do you want to remove unused Docker images? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    docker image prune -f
    echo "✅ Unused images removed"
fi

echo ""
echo "🎉 Cleanup completed!"
echo "To restart the monitoring stack, run: ./setup.sh"
