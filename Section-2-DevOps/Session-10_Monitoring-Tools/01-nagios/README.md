# 🔍 **Nagios Monitoring - Infrastructure Monitoring Foundation**

## 🎯 **Quick Start**

```bash
# Start Nagios monitoring
docker-compose up -d

# Check status
docker-compose ps
```

## 📊 **Access Information**

• **URL:** http://localhost:8080/nagios/
• **Username:** nagiosadmin
• **Password:** nagios

## 🌐 **Test Services**

| Service | URL | Purpose |
|---------|-----|---------|
| **Nagios** | http://localhost:8080/nagios/ | Monitoring dashboard |
| **Nginx** | http://localhost:8081 | Test web server |
| **Apache** | http://localhost:8082 | Test web server |

## 🧪 **Testing Steps**

### 1. Verify All Services Running
```bash
# Check containers
docker-compose ps

# Test web services
curl http://localhost:8081
curl http://localhost:8082
```

### 2. Access Nagios Dashboard
1. Open: http://localhost:8080/nagios/
2. Login: nagiosadmin / nagios
3. Click **Hosts** to see nginx-target and apache-target
4. Click **Services** to see HTTP monitoring status

### 3. Simulate Service Failure
```bash
# Stop nginx to trigger alert
docker stop nginx-target

# Check Nagios - nginx should show CRITICAL
# Wait 2-3 minutes for status update

# Restart nginx
docker start nginx-target
```

## 🔧 **What's Being Monitored**

- **Host Status** - nginx-target, apache-target availability
- **HTTP Services** - Web server response checks
- **Response Time** - Service performance monitoring

## 🚨 **Understanding Nagios Status**

| Status | Color | Meaning |
|--------|-------|---------|
| **OK** | 🟢 Green | Service working normally |
| **WARNING** | 🟡 Yellow | Service degraded but functional |
| **CRITICAL** | 🔴 Red | Service failed or unavailable |
| **UNKNOWN** | 🟣 Purple | Cannot determine service status |

## 🛑 **Stop Services**

```bash
docker-compose down
```

## 📚 **Next Steps**

After mastering basic Nagios monitoring:
- **Advanced configuration** - Custom checks and alerts
- **ELK Stack integration** - Move to `../02-nagios-elk/`
- **Production deployment** - Scale monitoring infrastructure

*🔍 Master infrastructure monitoring fundamentals with Nagios!*
