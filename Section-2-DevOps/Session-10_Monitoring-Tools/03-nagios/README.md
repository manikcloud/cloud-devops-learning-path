# 🔍 **Nagios Monitoring Lab - Complete Learning Guide**

## 🎯 **Learning Objectives**

By the end of this lab, you will understand:
- **What is monitoring** and why it's critical in DevOps
- **Nagios architecture** and core components
- **Host vs Service monitoring** concepts
- **Visual monitoring dashboards** with red/green status indicators
- **Incident simulation** and response procedures
- **Real-world monitoring** best practices

---

## 📚 **What is Nagios?**

**Nagios** is an open-source monitoring system that helps organizations:
- **Monitor infrastructure** - Servers, networks, applications
- **Detect problems** - Before users notice them
- **Send alerts** - Notify teams when issues occur
- **Maintain uptime** - Ensure services stay available
- **Track performance** - Monitor response times and resource usage

### **Why Monitoring Matters in DevOps:**
- **Prevent outages** - Catch issues early
- **Improve reliability** - Maintain service availability
- **Faster incident response** - Know what's broken and where
- **Performance optimization** - Identify bottlenecks
- **Compliance** - Meet SLA requirements

---

## 🏗️ **Nagios Architecture & Components**

### **Core Components:**

#### **1. Nagios Core Engine**
- **Purpose:** Central monitoring daemon
- **Function:** Schedules checks, processes results, sends notifications
- **Location:** Runs on monitoring server

#### **2. Web Interface (CGI)**
- **Purpose:** Visual dashboard for monitoring
- **Function:** Display status, graphs, reports
- **Access:** Web browser interface

#### **3. Configuration Files**
- **hosts.cfg** - Defines what to monitor (servers, devices)
- **services.cfg** - Defines how to monitor (checks, tests)
- **commands.cfg** - Defines monitoring commands
- **contacts.cfg** - Defines who gets alerts

#### **4. Plugins**
- **Purpose:** Perform actual monitoring checks
- **Examples:** check_http, check_ping, check_disk
- **Location:** /usr/lib/nagios/plugins/

#### **5. Status Files**
- **status.dat** - Current status of all monitored items
- **nagios.log** - Historical events and alerts
- **retention.dat** - Persistent state information

### **How It All Works Together:**

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Nagios Core   │───▶│     Plugins      │───▶│  Target Hosts   │
│   (Scheduler)   │    │  (check_http,    │    │  (Web servers,  │
│                 │    │   check_ping)    │    │   databases)    │
└─────────────────┘    └──────────────────┘    └─────────────────┘
         │                       │                       │
         ▼                       ▼                       ▼
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│  Web Interface  │    │  Status Files    │    │  Log Files      │
│  (Dashboard)    │    │  (status.dat)    │    │  (nagios.log)   │
└─────────────────┘    └──────────────────┘    └─────────────────┘
```

---

## 🎓 **Key Monitoring Concepts**

### **Host vs Service Monitoring**

#### **Host Monitoring:**
- **What:** The physical/virtual machine itself
- **Example:** Web server, database server, router
- **Status:** UP (working) or DOWN (failed)
- **Check:** Usually PING to test network connectivity

#### **Service Monitoring:**
- **What:** Specific applications or functions on a host
- **Example:** HTTP service, MySQL database, SSH access
- **Status:** OK, WARNING, CRITICAL, UNKNOWN
- **Check:** Application-specific tests

#### **Real-World Example:**
```
Host: web-server-01 (Status: UP)
├── Service: HTTP (Status: OK)
├── Service: HTTPS (Status: OK)
├── Service: SSH (Status: OK)
└── Service: Disk Space (Status: WARNING - 85% full)
```

### **Status States Explained:**

#### **Host States:**
- 🟢 **UP** - Host is reachable and responding
- 🔴 **DOWN** - Host is not reachable (network/power failure)
- 🟡 **UNREACHABLE** - Host may be up but path to it is blocked

#### **Service States:**
- 🟢 **OK** - Service is working normally
- 🟡 **WARNING** - Service has minor issues (slow response, high usage)
- 🔴 **CRITICAL** - Service has major issues (not responding, failed)
- ⚪ **UNKNOWN** - Cannot determine service status

### **Check Types:**

#### **Active Checks:**
- **How:** Nagios initiates the check
- **When:** Scheduled intervals (every 5 minutes)
- **Example:** Nagios runs check_http against web server

#### **Passive Checks:**
- **How:** External system sends results to Nagios
- **When:** Event-driven or irregular intervals
- **Example:** Application sends performance data to Nagios

---

## 🚀 **Lab Setup & Prerequisites**

### **What You Need:**
- Docker installed and running
- Docker Compose installed
- Ports 8080, 8081, 8082 available
- Web browser for accessing dashboard

### **Lab Architecture:**
```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│  Nagios Server  │───▶│  Nginx Target   │    │ Apache Target   │
│  (Port 8080)    │    │  (Port 8081)    │    │  (Port 8082)    │
│                 │    │                 │    │                 │
│  - Monitors     │    │  - Web Server   │    │  - Web Server   │
│  - Alerts       │    │  - HTTP Service │    │  - HTTP Service │
│  - Dashboard    │    │  - PING Check   │    │  - PING Check   │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

---

## 🏗️ **Step 1: Start the Lab Environment**

### **Clone Repository:**
```bash
git clone https://github.com/manikcloud/cloud-devops-learning-path.git
cd cloud-devops-learning-path/Section-2-DevOps/Session-10_Monitoring-Tools/03-nagios
```

### **Start All Services:**
```bash
# Start the monitoring environment
docker-compose up -d

# Verify all containers are running
docker ps
```

**Expected Output:**
```
CONTAINER ID   IMAGE                        PORTS                    NAMES
abc123def456   jasonrivers/nagios:latest    0.0.0.0:8080->80/tcp     nagios-server
def456ghi789   nginx:alpine                 0.0.0.0:8081->80/tcp     nginx-target
ghi789jkl012   httpd:alpine                 0.0.0.0:8082->80/tcp     apache-target
```

---

## 🌐 **Step 2: Access Nagios Dashboard**

### **Login to Nagios:**
1. **Open browser:** http://localhost:8080/nagios
2. **Username:** `admin`
3. **Password:** `nagios123`

### **Dashboard Overview:**
- **Left Menu:** Navigation panel
- **Main Area:** Status displays and information
- **Top Bar:** Quick status summary

---

## 📊 **Step 3: Navigate the Monitoring Dashboard**

### **Main Menu Sections:**

#### **🏠 Home**
- **Tactical Overview** - Quick status summary with numbers
- **Map** - Visual network topology (if configured)
- **3D Status Map** - Interactive status visualization

#### **📈 Current Status**
- **Hosts** - All monitored servers/devices
- **Services** - All monitored applications/checks
- **Host Groups** - Organized collections of hosts
- **Service Groups** - Organized collections of services
- **Problems** - Only items with issues (red status)

#### **📋 Reports**
- **Trends** - Historical performance data
- **Availability** - Uptime/downtime statistics
- **Notifications** - Alert history
- **Event Log** - Detailed event timeline

#### **⚙️ System**
- **Process Info** - Nagios engine status
- **Performance Info** - Monitoring system performance
- **Scheduling Queue** - Upcoming checks

### **Key Pages for Students:**

#### **Host Status Page:**
```
Navigation: Current Status → Hosts
URL: http://localhost:8080/nagios/cgi-bin/status.cgi?hostgroup=all&style=hostdetail
```

**What You'll See:**
- **Host Name** - nginx-target, apache-target
- **Status** - UP (🟢 green) or DOWN (🔴 red)
- **Last Check** - When last monitored
- **Duration** - How long in current state
- **Status Information** - Details about current status

#### **Service Status Page:**
```
Navigation: Current Status → Services
URL: http://localhost:8080/nagios/cgi-bin/status.cgi?host=all
```

**What You'll See:**
- **Host** - Which server the service runs on
- **Service** - HTTP, PING, etc.
- **Status** - OK (🟢), WARNING (🟡), CRITICAL (🔴)
- **Last Check** - When last tested
- **Duration** - How long in current state
- **Status Information** - Detailed check results

---

## 🧪 **Step 4: Hands-On Monitoring Exercises**

### **Exercise 1: Observe Normal Operations (Green Status)**

#### **View Host Status:**
1. Navigate to **Current Status → Hosts**
2. Observe all hosts show **UP** status with 🟢 green background
3. Note the **Last Check** times and **Duration**

#### **View Service Status:**
1. Navigate to **Current Status → Services**
2. Observe all services show **OK** status with 🟢 green background
3. Identify different service types: HTTP, PING

**Learning Points:**
- Green = Everything working normally
- Regular check intervals (every 5 minutes)
- Multiple services per host

### **Exercise 2: Simulate Service Failure (Red Status)**

#### **Create a Failure:**
```bash
# Stop the nginx web server
docker-compose stop nginx-target

# Wait 3-5 minutes for Nagios to detect the failure
```

#### **Observe the Impact:**
1. **Refresh** the Nagios dashboard (F5)
2. **Navigate to Hosts page**
   - nginx-target should show **DOWN** with 🔴 red background
3. **Navigate to Services page**
   - nginx-target HTTP: **CRITICAL** (🔴 red)
   - nginx-target PING: **CRITICAL** (🔴 red)
4. **Check Problems page**
   - Only failed items appear here

**Learning Points:**
- Red = Service/host failure
- Multiple services affected by single host failure
- Problems page filters to show only issues
- Status changes take time to detect (check intervals)

### **Exercise 3: Partial Service Recovery**

#### **Restart the Failed Service:**
```bash
# Restart the nginx container
docker-compose start nginx-target

# Wait 3-5 minutes for Nagios to detect recovery
```

#### **Observe Recovery:**
1. **Refresh** the dashboard
2. **Watch status change** from red back to green
3. **Check Problems page** - should be empty again

**Learning Points:**
- Green = Service restored
- Recovery detection also takes time
- Problems automatically clear when fixed

### **Exercise 4: Understand Check Details**

#### **View Detailed Check Information:**
1. **Click on any service name** in the Services page
2. **Review the detailed information:**
   - Check command used
   - Output from the check
   - Performance data
   - Check history

#### **Example HTTP Check Details:**
```
Check Command: check_http
Status Information: HTTP OK: HTTP/1.1 200 OK - 1234 bytes in 0.045 second
Performance Data: time=0.045s;;;0.000000 size=1234B;;;0
```

**Learning Points:**
- Each check runs a specific command
- Output shows detailed results
- Performance data tracks metrics over time
- History shows status changes

---

## 🔧 **Step 5: Understanding Configuration**

### **Host Configuration (hosts.cfg):**
```bash
# View host definitions
cat nagios/config/hosts.cfg
```

**Example Host Definition:**
```
define host {
    use                     linux-server        # Template to inherit from
    host_name               nginx-target        # Unique identifier
    alias                   Nginx Web Server    # Human-readable name
    address                 nginx-target        # IP address or hostname
    check_command           check-host-alive    # How to check if host is up
    max_check_attempts      3                   # Retry 3 times before marking DOWN
    check_period            24x7                # When to perform checks
    notification_interval   30                  # How often to send alerts (minutes)
    notification_period     24x7                # When to send alerts
}
```

### **Service Configuration (services.cfg):**
```bash
# View service definitions
cat nagios/config/services.cfg
```

**Example Service Definition:**
```
define service {
    use                     generic-service     # Template to inherit from
    host_name               nginx-target        # Which host this service runs on
    service_description     HTTP                # Human-readable service name
    check_command           check_http          # Command to test the service
    max_check_attempts      3                   # Retry 3 times before marking CRITICAL
    check_interval          5                   # Check every 5 minutes
    retry_interval          1                   # Retry every 1 minute if failed
    check_period            24x7                # When to perform checks
    notification_interval   30                  # How often to send alerts
    notification_period     24x7                # When to send alerts
}
```

### **Key Configuration Concepts:**

#### **Templates (use directive):**
- **Purpose:** Inherit common settings
- **Examples:** linux-server, generic-service
- **Benefit:** Reduces duplication, easier maintenance

#### **Check Commands:**
- **check-host-alive:** PING test for host connectivity
- **check_http:** Test web server response
- **check_ping:** Network connectivity with thresholds

#### **Time Periods:**
- **24x7:** Always active
- **workhours:** Business hours only
- **Custom:** Define your own schedules

#### **Notification Settings:**
- **notification_interval:** How often to repeat alerts
- **notification_period:** When alerts are allowed
- **contacts:** Who receives alerts

---

## 📝 **Step 6: Monitor Logs and Events**

### **View Real-Time Logs:**
```bash
# Watch Nagios logs in real-time
docker-compose logs -f nagios

# View specific container logs
docker-compose logs nginx-target
docker-compose logs apache-target
```

### **Key Log Messages:**

#### **Service Alerts:**
```
SERVICE ALERT: nginx-target;HTTP;CRITICAL;HARD;3;Connection refused
SERVICE ALERT: nginx-target;HTTP;OK;HARD;1;HTTP OK: HTTP/1.1 200 OK
```

#### **Host Alerts:**
```
HOST ALERT: nginx-target;DOWN;HARD;3;PING CRITICAL - Host Unreachable
HOST ALERT: nginx-target;UP;HARD;1;PING OK - Packet loss = 0%
```

#### **Current State Messages:**
```
CURRENT SERVICE STATE: nginx-target;HTTP;OK;HARD;1;HTTP OK
CURRENT HOST STATE: nginx-target;UP;HARD;1;PING OK
```

### **Understanding Log Entries:**

#### **Alert Types:**
- **SERVICE ALERT** - Service status change
- **HOST ALERT** - Host status change
- **CURRENT STATE** - Status confirmation

#### **State Types:**
- **SOFT** - Temporary state (still retrying)
- **HARD** - Confirmed state (max attempts reached)

#### **Attempt Numbers:**
- **3** - Failed 3 times (max_check_attempts)
- **1** - Succeeded on first try

---

## 🛠️ **Step 7: Troubleshooting Common Issues**

### **Problem: Cannot Access Nagios Web Interface**

#### **Symptoms:**
- Browser shows "Connection refused"
- Page won't load

#### **Diagnosis:**
```bash
# Check if Nagios container is running
docker ps | grep nagios

# Check container logs
docker-compose logs nagios

# Check port binding
netstat -tlnp | grep 8080
```

#### **Solutions:**
```bash
# Restart Nagios container
docker-compose restart nagios

# Rebuild if needed
docker-compose up -d --build

# Check firewall settings
sudo ufw status
```

### **Problem: "Could not read host and service status information"**

#### **Symptoms:**
- Login works but no status data shown
- Error message about reading status

#### **Diagnosis:**
```bash
# Check Nagios configuration
docker exec nagios-server nagios -v /opt/nagios/etc/nagios.cfg

# Check file permissions
docker exec nagios-server ls -la /opt/nagios/var/
```

#### **Solutions:**
```bash
# Restart Nagios to reload config
docker-compose restart nagios

# Wait for initial checks to complete (5-10 minutes)
```

### **Problem: Services Show UNKNOWN Status**

#### **Symptoms:**
- Services show gray/unknown status
- No clear OK/CRITICAL status

#### **Diagnosis:**
```bash
# Check network connectivity between containers
docker network ls
docker network inspect 03-nagios_monitoring

# Test manual connectivity
docker exec nagios-server ping nginx-target
```

#### **Solutions:**
```bash
# Restart all containers
docker-compose down && docker-compose up -d

# Check DNS resolution
docker exec nagios-server nslookup nginx-target
```

---

## 📊 **Step 8: Monitoring Best Practices**

### **What to Monitor:**

#### **Infrastructure Level:**
- **Host availability** - Is the server reachable?
- **Resource usage** - CPU, memory, disk space
- **Network connectivity** - Ping, bandwidth
- **Hardware health** - Temperature, disk errors

#### **Application Level:**
- **Service availability** - Is the application responding?
- **Response times** - How fast is the application?
- **Error rates** - How many requests are failing?
- **Business metrics** - Users, transactions, revenue

#### **Security Level:**
- **Failed login attempts** - Potential attacks
- **Certificate expiration** - SSL/TLS certificates
- **Security updates** - Patch status
- **Access logs** - Unusual activity

### **Monitoring Frequency Guidelines:**

#### **Critical Services:**
- **Check interval:** 1-2 minutes
- **Examples:** Payment systems, core APIs
- **Rationale:** Fast detection of revenue-impacting issues

#### **Standard Services:**
- **Check interval:** 5 minutes
- **Examples:** Web servers, databases
- **Rationale:** Balance between detection speed and system load

#### **Non-Critical Services:**
- **Check interval:** 15-30 minutes
- **Examples:** Backup systems, reporting tools
- **Rationale:** Reduce monitoring overhead for less critical systems

### **Alert Management:**

#### **Alert Fatigue Prevention:**
- **Tune thresholds** - Avoid false positives
- **Group related alerts** - Don't spam for related failures
- **Escalation policies** - Different urgency levels
- **Maintenance windows** - Suppress alerts during planned work

#### **Notification Channels:**
- **Email** - Standard alerts
- **SMS** - Critical alerts
- **Slack/Teams** - Team notifications
- **PagerDuty** - On-call escalation

---

## 🎯 **Step 9: Real-World Applications**

### **How Companies Use Nagios:**

#### **E-commerce Platform:**
```
Hosts: Web servers, database servers, load balancers
Services: 
- HTTP/HTTPS response times
- Database query performance
- Payment gateway availability
- Shopping cart functionality
- Order processing pipeline
```

#### **Financial Services:**
```
Hosts: Trading servers, compliance systems, backup systems
Services:
- Transaction processing speed
- Market data feeds
- Regulatory reporting systems
- Security monitoring
- Disaster recovery readiness
```

#### **Healthcare System:**
```
Hosts: Patient record systems, imaging servers, network equipment
Services:
- Electronic health records availability
- Medical device connectivity
- Patient portal response times
- Backup system integrity
- Compliance monitoring
```

### **Integration with DevOps Pipeline:**

#### **Continuous Integration:**
- **Build monitoring** - Track build success rates
- **Test environment health** - Ensure test systems are available
- **Deployment monitoring** - Monitor deployment success

#### **Continuous Deployment:**
- **Production readiness** - Verify systems before deployment
- **Rollback triggers** - Automatic rollback on failure detection
- **Performance regression** - Detect performance issues after deployment

#### **Infrastructure as Code:**
- **Automated monitoring setup** - Deploy monitoring with infrastructure
- **Configuration management** - Version control monitoring configs
- **Scaling monitoring** - Add monitoring for new instances automatically

---

## 🧹 **Step 10: Cleanup and Next Steps**

### **Stop the Lab Environment:**
```bash
# Stop all containers
docker-compose down

# Remove containers and networks
docker-compose down --remove-orphans

# Remove images (optional)
docker-compose down --rmi all

# Clean up volumes (optional)
docker-compose down -v
```

### **Verify Cleanup:**
```bash
# Check no containers running
docker ps

# Check port availability
netstat -tlnp | grep -E "808[0-2]"
```

---

## 📚 **Advanced Topics to Explore**

### **Custom Monitoring Scripts:**
- Write your own check plugins
- Monitor custom applications
- Business-specific metrics

### **SNMP Monitoring:**
- Monitor network devices
- Router and switch health
- Bandwidth utilization

### **Database Monitoring:**
- MySQL, PostgreSQL, Oracle
- Query performance
- Connection pools
- Replication status

### **Cloud Monitoring:**
- AWS CloudWatch integration
- Azure Monitor integration
- Google Cloud Monitoring

### **Modern Alternatives:**
- **Prometheus + Grafana** - Metrics and visualization
- **ELK Stack** - Log aggregation and analysis
- **DataDog** - Cloud-based monitoring
- **New Relic** - Application performance monitoring

---

## 🎓 **Assessment and Learning Outcomes**

### **Knowledge Check:**

#### **Conceptual Understanding:**
- [ ] Can explain the difference between host and service monitoring
- [ ] Understands the purpose of different status states (OK, WARNING, CRITICAL)
- [ ] Can identify when to use different check intervals
- [ ] Knows how to interpret monitoring dashboards

#### **Practical Skills:**
- [ ] Can navigate the Nagios web interface
- [ ] Can simulate and observe service failures
- [ ] Can read and interpret log files
- [ ] Can troubleshoot common monitoring issues

#### **Real-World Application:**
- [ ] Can design a monitoring strategy for a simple application
- [ ] Understands how monitoring fits into DevOps practices
- [ ] Can explain monitoring best practices to others
- [ ] Knows when to escalate monitoring alerts

### **Hands-On Competencies:**
- [ ] Successfully started the monitoring environment
- [ ] Logged into Nagios web interface
- [ ] Navigated to host and service status pages
- [ ] Observed green (OK) status for all services
- [ ] Simulated service failure and observed red (CRITICAL) status
- [ ] Restored failed service and confirmed green (OK) status
- [ ] Reviewed configuration files and understood their purpose
- [ ] Analyzed log files and identified key events
- [ ] Troubleshot common issues independently

---

## 🆘 **Quick Reference**

### **Essential Commands:**
```bash
# Start monitoring
docker-compose up -d

# Check container status
docker ps

# View logs
docker-compose logs -f nagios

# Stop specific service (create failure)
docker-compose stop nginx-target

# Start specific service (restore)
docker-compose start nginx-target

# Stop everything
docker-compose down
```

### **Key URLs:**
- **Nagios Dashboard:** http://localhost:8080/nagios
- **Host Status:** http://localhost:8080/nagios/cgi-bin/status.cgi?hostgroup=all&style=hostdetail
- **Service Status:** http://localhost:8080/nagios/cgi-bin/status.cgi?host=all
- **Problems Only:** http://localhost:8080/nagios/cgi-bin/status.cgi?host=all&servicestatustypes=28
- **Nginx Target:** http://localhost:8081
- **Apache Target:** http://localhost:8082

### **Login Credentials:**
- **Username:** admin
- **Password:** nagios123

### **Status Color Guide:**
- 🟢 **Green (UP/OK)** - Everything working normally
- 🟡 **Yellow (WARNING)** - Minor issues, still functional
- 🔴 **Red (DOWN/CRITICAL)** - Major issues, service failed
- ⚪ **Gray (UNKNOWN)** - Cannot determine status

---

## 🎉 **Congratulations!**

You have successfully completed the Nagios monitoring lab! You now understand:

- **Infrastructure monitoring fundamentals**
- **Nagios architecture and components**
- **Visual monitoring with status indicators**
- **Incident simulation and response**
- **Real-world monitoring applications**
- **Best practices for production environments**

**Next Steps:**
- Explore advanced monitoring tools (Prometheus, Grafana)
- Learn about alerting and notification systems
- Study monitoring in cloud environments
- Practice with larger, more complex infrastructures

**You're now ready to implement monitoring in real DevOps environments!** 🚀
