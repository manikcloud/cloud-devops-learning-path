# 🔍 Nagios Monitoring Lab - Complete Runbook

Learn Nagios monitoring with Docker containers - step-by-step guide for students.

## 📋 Prerequisites

- Docker installed and running
- Docker Compose installed
- Git installed
- Ports 8080, 8081, 8082 available

## 🚀 Step 1: Clone and Setup

```bash
# Clone the repository
git clone https://github.com/manikcloud/cloud-devops-learning-path.git

# Navigate to Nagios directory
cd cloud-devops-learning-path/Section-2-DevOps/Session-10_Monitoring-Tools/03-nagios

# Verify files are present
ls -la
```

**Expected output:**
```
README.md
docker-compose.yml
start.sh
nagios/
```

## 🏗️ Step 2: Start the Monitoring Stack

```bash
# Make start script executable
chmod +x start.sh

# Start all services
./start.sh
```

**What happens:**
- Builds Nagios container with Ubuntu + Nagios4
- Starts Nginx target container (port 8081)
- Starts Apache target container (port 8082)
- Starts Nagios monitoring server (port 8080)

## 🌐 Step 3: Access Nagios Web Interface

1. **Open browser** and go to: http://localhost:8080/nagios
2. **Login credentials:**
   - Username: `admin`
   - Password: `nagios123`

## 📊 Step 4: Navigate the Nagios Dashboard

### Main Menu Options:
- **Tactical Overview** - Quick status summary
- **Map** - Network topology view
- **Hosts** - All monitored hosts
- **Services** - All monitored services
- **Problems** - Current issues
- **Event Log** - Historical events

### Key Views to Explore:

#### 4.1 Host Status
```
Current Status → Hosts → All Hosts
```
You should see:
- `nginx-target` - Status: UP
- `apache-target` - Status: UP

#### 4.2 Service Status
```
Current Status → Services → All Services
```
You should see:
- `nginx-target` - PING: OK
- `nginx-target` - HTTP: OK
- `apache-target` - PING: OK
- `apache-target` - HTTP: OK

## 🧪 Step 5: Test Monitoring (Hands-On)

### Test 1: Service Failure Simulation
```bash
# Stop nginx container
docker-compose stop nginx-target

# Wait 2-3 minutes, then check Nagios UI
# nginx-target should show as DOWN
```

**Expected Result:**
- Host `nginx-target` status changes to DOWN
- HTTP service shows CRITICAL
- PING service shows CRITICAL

### Test 2: Service Recovery
```bash
# Restart nginx container
docker-compose start nginx-target

# Wait 2-3 minutes, then check Nagios UI
# nginx-target should show as UP
```

**Expected Result:**
- Host `nginx-target` status changes to UP
- All services return to OK status

### Test 3: Partial Service Failure
```bash
# Stop only Apache
docker-compose stop apache-target

# Check which services are affected
```

## 📈 Step 6: Understanding Nagios Concepts

### Host vs Service Monitoring
- **Host**: The actual server/container (nginx-target, apache-target)
- **Service**: Specific checks on that host (PING, HTTP)

### Check Types
- **PING**: Tests network connectivity
- **HTTP**: Tests web server response

### Status States
- **UP/OK**: Everything working
- **DOWN/CRITICAL**: Service failed
- **WARNING**: Service degraded
- **UNKNOWN**: Cannot determine status

## 🔧 Step 7: View Configuration Files

### Check Host Configuration
```bash
# View monitored hosts
cat nagios/config/hosts.cfg
```

### Check Service Configuration
```bash
# View monitored services
cat nagios/config/services.cfg
```

### Check Commands
```bash
# View check commands
cat nagios/config/commands.cfg
```

## 📝 Step 8: Monitor Logs

### View Nagios Logs
```bash
# Real-time log monitoring
docker-compose logs -f nagios

# View specific container logs
docker-compose logs nginx-target
docker-compose logs apache-target
```

### Key Log Messages to Look For:
- `SERVICE ALERT` - Service status changes
- `HOST ALERT` - Host status changes
- `CURRENT SERVICE STATE` - Current status
- `SERVICE NOTIFICATION` - Alert notifications

## 🛠️ Step 9: Troubleshooting Guide

### Problem: Cannot access Nagios UI
**Solution:**
```bash
# Check if containers are running
docker-compose ps

# Check Nagios logs
docker-compose logs nagios

# Restart if needed
docker-compose restart nagios
```

### Problem: Services showing as UNKNOWN
**Solution:**
```bash
# Check network connectivity
docker network ls
docker network inspect 03-nagios_monitoring

# Restart all services
docker-compose down && docker-compose up -d
```

### Problem: Containers won't start
**Solution:**
```bash
# Check port conflicts
netstat -tulpn | grep :808

# Check Docker status
docker --version
docker info

# Clean up and restart
docker-compose down
docker system prune -f
./start.sh
```

## 🎯 Step 10: Learning Exercises

### Exercise 1: Add a New Service Check
1. Edit `nagios/config/services.cfg`
2. Add a new service check
3. Rebuild: `docker-compose up -d --build`

### Exercise 2: Monitor Response Times
1. Check service performance data
2. Look for response time metrics
3. Identify slow services

### Exercise 3: Create Alerts
1. Simulate service failures
2. Observe alert generation
3. Check notification logs

## 📊 Step 11: Monitoring Best Practices

### What to Monitor:
- ✅ **Connectivity** (PING)
- ✅ **Service availability** (HTTP)
- ✅ **Response times**
- ✅ **Resource usage**

### Monitoring Frequency:
- **Critical services**: Every 1-2 minutes
- **Standard services**: Every 5 minutes
- **Non-critical**: Every 15 minutes

## 🧹 Step 12: Cleanup

### Stop All Services
```bash
# Stop containers
docker-compose down

# Remove images (optional)
docker-compose down --rmi all

# Clean up volumes (optional)
docker-compose down -v
```

### Verify Cleanup
```bash
# Check no containers running
docker ps

# Check port availability
netstat -tulpn | grep :808
```

## 📚 Step 13: Next Steps

After completing this lab, you should understand:
- ✅ How Nagios monitors services
- ✅ Host vs Service concepts
- ✅ Reading monitoring dashboards
- ✅ Troubleshooting service failures
- ✅ Basic monitoring configuration

### Advanced Topics to Explore:
- Custom check scripts
- SNMP monitoring
- Database monitoring
- Email notifications
- Performance graphing

## 🆘 Quick Reference Commands

```bash
# Start monitoring
./start.sh

# Check status
docker-compose ps

# View logs
docker-compose logs -f

# Stop services
docker-compose down

# Restart specific service
docker-compose restart nginx-target

# Access URLs
# Nagios: http://localhost:8080/nagios
# Nginx: http://localhost:8081
# Apache: http://localhost:8082
```

## 🎓 Assessment Checklist

- [ ] Successfully started all containers
- [ ] Logged into Nagios web interface
- [ ] Viewed host and service status
- [ ] Simulated service failure
- [ ] Observed status changes in UI
- [ ] Restored failed service
- [ ] Reviewed configuration files
- [ ] Understood basic monitoring concepts

---

**🎉 Congratulations!** You've completed the Nagios monitoring lab. You now understand the fundamentals of infrastructure monitoring with Nagios.
