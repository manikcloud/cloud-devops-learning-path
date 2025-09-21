# 🔍 Nagios Monitoring Lab - Complete Runbook (FIXED VERSION)

Learn Nagios monitoring with Docker containers - step-by-step guide for students.

> **⚠️ IMPORTANT:** This is a **FIXED VERSION** of the original repository. The original has configuration issues that prevent proper operation. Use the files in this directory for a working setup.

## 🚨 **Issues Fixed from Original Repository**

### **Original Problems:**
- ❌ **Volume mapping error:** `/opt/nagios/etc/objects` should be `/opt/nagios/etc/conf.d`
- ❌ **Duplicate localhost config:** Causes Nagios startup failure
- ❌ **CGI permissions:** User `admin` not authorized to view status
- ❌ **Network connectivity:** May fail in corporate environments

### **Fixed Solutions:**
- ✅ **Correct volume mapping:** Uses `/opt/nagios/etc/conf.d`
- ✅ **Clean configuration:** No duplicate host definitions
- ✅ **Proper permissions:** Admin user authorized for all functions
- ✅ **Working setup:** All containers start and monitor correctly

## 📋 Prerequisites

- Docker installed and running
- Docker Compose installed
- Git installed
- Ports 8080, 8081, 8082 available

## 🚀 Step 1: Use Fixed Setup

### **Option A: Use This Fixed Directory**
```bash
# You're already in the fixed directory
cd /home/k8s/nagios-test

# Start with working configuration
docker-compose -f docker-compose-working.yml up -d
```

### **Option B: Clone Original (Has Issues)**
```bash
# Clone the original repository (for reference only)
git clone https://github.com/manikcloud/cloud-devops-learning-path.git

# Navigate to Nagios directory
cd cloud-devops-learning-path/Section-2-DevOps/Session-10_Monitoring-Tools/03-nagios

# ⚠️ WARNING: This will have the issues mentioned above
```

## 🏗️ Step 2: Start the Monitoring Stack

### **Using Fixed Version (Recommended):**
```bash
# Start all services with working configuration
docker-compose -f docker-compose-working.yml up -d

# Check all containers are running
docker ps | grep -E "(nginx|apache|nagios)"
```

### **Using Original (Will Have Issues):**
```bash
# Make start script executable
chmod +x start.sh

# Start all services (may fail)
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

> **🔧 Fix Applied:** Admin user is now properly authorized to view all status information.

## 📊 Step 4: Navigate the Nagios Dashboard

### Main Menu Options:
- **Tactical Overview** - Quick status summary
- **Map** - Network topology view
- **Hosts** - All monitored hosts
- **Services** - All monitored services
- **Problems** - Current issues
- **Event Log** - Historical events

### Key Views to Explore:

#### 4.1 Host Status (🟢 Green/🔴 Red Status)
```
Current Status → Hosts → All Hosts
```
You should see:
- `localhost` - Status: UP (🟢 Green background)
- `nginx-target` - Status: UP (🟢 Green background)
- `apache-target` - Status: UP (🟢 Green background)

#### 4.2 Service Status
```
Current Status → Services → All Services
```
You should see:
- `nginx-target` - PING: OK (🟢 Green)
- `nginx-target` - HTTP: OK (🟢 Green)
- `apache-target` - PING: OK (🟢 Green)
- `apache-target` - HTTP: OK (🟢 Green)

> **🎯 Teaching Tip:** The visual green/red status is now clearly visible for effective student demonstrations.

## 🧪 Step 5: Test Monitoring (Hands-On)

### Test 1: Service Failure Simulation (Create 🔴 Red Status)
```bash
# Stop nginx container
docker-compose -f docker-compose-working.yml stop nginx-target

# Wait 3-5 minutes, then check Nagios UI
# nginx-target should show as DOWN with RED background
```

**Expected Result:**
- Host `nginx-target` status changes to DOWN (🔴 Red)
- HTTP service shows CRITICAL (🔴 Red)
- PING service shows CRITICAL (🔴 Red)

### Test 2: Service Recovery (Return to 🟢 Green Status)
```bash
# Restart nginx container
docker-compose -f docker-compose-working.yml start nginx-target

# Wait 3-5 minutes, then check Nagios UI
# nginx-target should show as UP with GREEN background
```

**Expected Result:**
- Host `nginx-target` status changes to UP (🟢 Green)
- All services return to OK status (🟢 Green)

### Test 3: Partial Service Failure
```bash
# Stop only Apache
docker-compose -f docker-compose-working.yml stop apache-target

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
- **UP/OK**: Everything working (🟢 Green)
- **DOWN/CRITICAL**: Service failed (🔴 Red)
- **WARNING**: Service degraded (🟡 Yellow)
- **UNKNOWN**: Cannot determine status (⚪ Gray)

## 🔧 Step 7: View Configuration Files

### Check Host Configuration
```bash
# View monitored hosts (fixed version)
cat nagios-config/hosts.cfg
```

### Check Service Configuration
```bash
# View monitored services (fixed version)
cat nagios-config/services.cfg
```

### Check Commands
```bash
# View check commands (if using original)
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

### Problem: "Could not read host and service status information"
**Root Cause:** Configuration errors or permission issues
**Solution:**
```bash
# Use the fixed configuration
docker-compose -f docker-compose-working.yml restart nagios

# Check configuration is valid
docker exec nagios-server nagios -v /opt/nagios/etc/nagios.cfg
```

### Problem: "No permission to view information"
**Root Cause:** CGI authorization issue
**Solution:** Already fixed in this version - admin user is authorized

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
docker network inspect nagios-test_monitoring

# Restart all services
docker-compose down && docker-compose -f docker-compose-working.yml up -d
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
docker-compose -f docker-compose-working.yml up -d
```

## 🎯 Step 10: Learning Exercises

### Exercise 1: Add a New Service Check
1. Edit `nagios-config/services.cfg`
2. Add a new service check
3. Restart: `docker-compose restart nagios`

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
docker-compose -f docker-compose-working.yml down

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
# Start monitoring (fixed version)
docker-compose -f docker-compose-working.yml up -d

# Check status
docker-compose ps

# View logs
docker-compose logs -f

# Stop services
docker-compose -f docker-compose-working.yml down

# Restart specific service
docker-compose restart nginx-target

# Access URLs
# Nagios: http://localhost:8080/nagios (admin/nagios123)
# Nginx: http://localhost:8081
# Apache: http://localhost:8082
```

## 🎓 Assessment Checklist

- [ ] Successfully started all containers
- [ ] Logged into Nagios web interface
- [ ] Viewed host and service status with green/red colors
- [ ] Simulated service failure (red status)
- [ ] Observed status changes in UI
- [ ] Restored failed service (green status)
- [ ] Reviewed configuration files
- [ ] Understood basic monitoring concepts

## 📁 **File Comparison: Original vs Fixed**

### **Original Repository Files:**
```
README.md                    # Good documentation but setup has issues
docker-compose.yml           # ❌ Wrong volume mapping
start.sh                     # Works but uses broken config
nagios/
├── Dockerfile              # ❌ Incomplete configuration
├── config/
│   ├── hosts.cfg           # ❌ May have duplicate localhost
│   ├── services.cfg        # Basic service definitions
│   └── ...                 # Other config files
```

### **Fixed Version Files:**
```
README_UPDATED.md           # This file - addresses all issues
docker-compose-working.yml  # ✅ Correct volume mapping
nagios-config/
├── hosts.cfg              # ✅ Clean host definitions
└── services.cfg           # ✅ Working service checks
QUICK_FIX.md               # Troubleshooting guide
STUDENT_GUIDE.md           # Navigation instructions
PRESENTATION_GUIDE.md      # Teaching script
```

---

## 🎉 **Summary**

**Use this fixed version for:**
- ✅ **Working demonstrations** with visual red/green status
- ✅ **Student labs** that actually function
- ✅ **Teaching materials** with proper navigation
- ✅ **Production-ready** monitoring setup

**Original repository is good for:**
- 📚 **Reference documentation** structure
- 🎓 **Learning objectives** and exercises
- 📝 **Assessment criteria** and best practices

**🎓 Congratulations!** You now have a fully working Nagios monitoring lab that demonstrates real-world infrastructure monitoring concepts with visual status indicators.
