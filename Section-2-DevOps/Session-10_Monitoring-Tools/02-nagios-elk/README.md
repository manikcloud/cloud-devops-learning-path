# 📊 **Nagios + ELK Stack - Complete Monitoring & Log Analysis**

## 🎯 **What This Provides**
- **Nagios** - Infrastructure monitoring (nginx, apache)
- **Elasticsearch** - Log storage and search
- **Logstash** - Log processing and parsing
- **Kibana** - Log visualization and dashboards
- **Web Services** - nginx and apache for testing

## 🚀 **Step-by-Step Usage Guide**

### **Step 1: Start All Services**
```bash
# Navigate to directory
cd 02-nagios-elk

# Start complete stack
docker-compose up -d

# Wait for services to initialize (2-3 minutes)
sleep 180

# Check all containers are running
docker-compose ps
```

### **Step 2: Access Nagios Monitoring**
```bash
# Open browser: http://localhost:8080/nagios/
# Username: nagiosadmin
# Password: nagios

# What you'll see:
# - Click "Hosts" → nginx-elk, apache-elk status
# - Click "Services" → HTTP monitoring for both services
```

### **Step 3: Generate Test Traffic for ELK**
```bash
# Generate web traffic to create logs
for i in {1..50}; do
  curl -s http://localhost:8081/ > /dev/null
  curl -s http://localhost:8082/ > /dev/null
  curl -s http://localhost:8081/test-$i > /dev/null
  curl -s http://localhost:8082/api/status > /dev/null
  echo "Generated request batch $i"
  sleep 1
done

# Generate some 404 errors
for i in {1..10}; do
  curl -s http://localhost:8081/missing-$i > /dev/null
  curl -s http://localhost:8082/notfound-$i > /dev/null
done
```

### **Step 4: Set Up Kibana for Log Analysis**
```bash
# 1. Wait for Elasticsearch to be ready
curl http://localhost:9200/_cluster/health

# 2. Open Kibana: http://localhost:5601
# 3. Go to Management → Stack Management → Index Patterns
# 4. Create index pattern: web-logs-*
# 5. Select @timestamp as time field
# 6. Click "Create index pattern"
```

### **Step 5: Explore Logs in Kibana**
```bash
# In Kibana Discover tab:
# - View recent logs (last 15 minutes)
# - Search for errors: response:404
# - Filter by service: log_source:nginx
# - View successful requests: response:200
```

### **Step 6: Create Kibana Visualizations**
```bash
# 1. Response Code Distribution (Pie Chart):
#    - Visualization → Create → Pie Chart
#    - Buckets → Split Slices → Terms → response.keyword

# 2. Traffic Over Time (Line Chart):
#    - Visualization → Create → Line Chart  
#    - X-axis → Date Histogram → @timestamp
#    - Y-axis → Count

# 3. Top URLs (Data Table):
#    - Visualization → Create → Data Table
#    - Buckets → Split Rows → Terms → request.keyword
```

### **Step 7: Build Monitoring Dashboard**
```bash
# 1. Go to Dashboard → Create Dashboard
# 2. Add your saved visualizations
# 3. Arrange panels for overview
# 4. Save as "Web Traffic Monitoring"
```

### **Step 8: Test Incident Response**
```bash
# Simulate nginx failure
docker stop nginx-elk

# Check Nagios (should show CRITICAL for nginx)
# Check Kibana (nginx logs should stop appearing)

# Restore service
docker start nginx-elk

# Verify recovery in both Nagios and Kibana
```

## 📊 **Service Access Points**

| Service | URL | Credentials | Purpose |
|---------|-----|-------------|---------|
| **Nagios** | http://localhost:8080/nagios/ | nagiosadmin / nagios | Infrastructure monitoring |
| **Kibana** | http://localhost:5601 | None | Log visualization |
| **Elasticsearch** | http://localhost:9200 | None | Search API |
| **Nginx** | http://localhost:8081 | None | Test web server |
| **Apache** | http://localhost:8082 | None | Test web server |

## 🔍 **Verification Commands**

```bash
# Check all services health
docker-compose ps

# Test web services
curl http://localhost:8081
curl http://localhost:8082

# Check Elasticsearch
curl http://localhost:9200/_cluster/health

# View log indices
curl http://localhost:9200/_cat/indices?v

# Check log count
curl http://localhost:9200/web-logs-*/_count

# Monitor logstash processing
docker logs logstash --tail 20
```

## 🧪 **Advanced Testing Scenarios**

### **Load Testing**
```bash
# Generate high traffic
for i in {1..100}; do
  curl -s http://localhost:8081/ > /dev/null &
  curl -s http://localhost:8082/ > /dev/null &
  if [ $((i % 10)) -eq 0 ]; then
    wait
    echo "Completed batch $i"
  fi
done
```

### **Error Pattern Testing**
```bash
# Create different error patterns
curl -s http://localhost:8081/404-page > /dev/null
curl -s http://localhost:8082/server-error > /dev/null
curl -s http://localhost:8081/timeout > /dev/null

# Search in Kibana: response:>=400
```

### **User Journey Simulation**
```bash
# Simulate e-commerce user flow
for user in user{1..5}; do
  curl -s "http://localhost:8081/?user=$user" > /dev/null
  curl -s "http://localhost:8081/products?user=$user" > /dev/null
  curl -s "http://localhost:8081/cart?user=$user" > /dev/null
  curl -s "http://localhost:8082/checkout?user=$user" > /dev/null
  sleep 2
done
```

## 🚨 **Troubleshooting**

### **Common Issues**
| Problem | Solution |
|---------|----------|
| Kibana not loading | Wait 3-5 minutes for full startup |
| No logs in Kibana | Generate traffic, check logstash logs |
| Elasticsearch yellow | Normal for single-node setup |
| Nagios shows all critical | Check container networking |

### **Debug Commands**
```bash
# Check container logs
docker logs elasticsearch --tail 50
docker logs logstash --tail 50
docker logs kibana --tail 50
docker logs nagios-elk --tail 50

# Check network connectivity
docker exec nagios-elk ping nginx-elk
docker exec nagios-elk ping apache-elk

# Restart specific service
docker-compose restart logstash
```

## 🛑 **Stop All Services**

```bash
# Stop and remove containers
docker-compose down

# Remove volumes (deletes all data)
docker-compose down -v
```

## 📈 **What You'll Learn**

✅ **Infrastructure Monitoring** - Real-time service health  
✅ **Log Aggregation** - Centralized log collection  
✅ **Data Visualization** - Interactive dashboards  
✅ **Incident Response** - Correlate monitoring + logs  
✅ **Performance Analysis** - Traffic patterns and trends  
✅ **Troubleshooting** - Root cause analysis workflow  

## 🎯 **Success Criteria**

After completing this lab:
- [ ] All 6 containers running successfully
- [ ] Nagios shows green status for nginx/apache
- [ ] Kibana displays web server logs
- [ ] Can create visualizations and dashboards
- [ ] Can simulate and detect service failures
- [ ] Understand monitoring + logging correlation

*📊 Complete observability stack - Monitor everything, visualize insights!* 🚀
