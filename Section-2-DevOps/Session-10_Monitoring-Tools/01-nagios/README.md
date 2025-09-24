# 🔍 **Nagios Monitoring - Infrastructure Monitoring Foundation**

## 🎯 **Why Monitor Infrastructure?**

### **The Monitoring Lifecycle:**

```mermaid
graph TD
    A[Services Running 🟢] --> B{Health Check}
    B --> C[All Good ✅]
    B --> D[Problem Detected ⚠️]
    C --> E[Users Happy 😊]
    D --> F[Alert Sent 📧]
    F --> G[Team Responds 🚀]
    G --> H[Problem Fixed 🔧]
    H --> E
    
    style A fill:#e1f5fe
    style C fill:#c8e6c9
    style D fill:#ffcdd2
    style E fill:#c8e6c9
    style F fill:#fff3e0
    style G fill:#e1f5fe
    style H fill:#c8e6c9
```

- **Prevent outages** - Catch issues early
- **Improve reliability** - Maintain service availability
- **Faster incident response** - Know what's broken and where
- **Performance optimization** - Identify bottlenecks
- **Compliance** - Meet SLA requirements

---

## 🏗️ **Nagios Architecture & Components**

### **System Architecture Overview:**

```mermaid
graph TB
    subgraph "Nagios Server"
        A[Nagios Core Engine]
        B[Web Interface CGI]
        C[Configuration Files]
        D[Status Files]
        E[Plugins Directory]
    end
    
    subgraph "Target Systems"
        F[Web Server 1]
        G[Database Server]
        H[Web Server 2]
    end
    
    A --> E
    E --> F
    E --> G
    E --> H
    A --> D
    D --> B
    C --> A
    
    style A fill:#e3f2fd
    style B fill:#e8f5e8
    style C fill:#fff3e0
    style D fill:#f3e5f5
    style E fill:#e0f2f1
    style F fill:#fce4ec
    style G fill:#fce4ec
    style H fill:#fce4ec
```

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

### **Monitoring Flow:**

```mermaid
sequenceDiagram
    participant NC as Nagios Core
    participant P as Plugin
    participant T as Target Service
    participant WI as Web Interface
    participant U as User
    
    NC->>P: Execute check_http
    P->>T: HTTP Request
    T-->>P: HTTP Response (200 OK)
    P-->>NC: Status: OK
    NC->>NC: Update status.dat
    U->>WI: View Dashboard
    WI->>NC: Read status.dat
    WI-->>U: Show Green Status ✅
    
    Note over NC,T: Every 5 minutes
    Note over U,WI: Real-time dashboard
```

---

## 🎓 **Key Monitoring Concepts**

### **Host vs Service Monitoring**

```mermaid
graph TD
    subgraph "Host Monitoring"
        A[Physical/Virtual Server]
        A --> B[Network Connectivity]
        A --> C[Power Status]
        A --> D[Basic Availability]
    end
    
    subgraph "Service Monitoring"
        E[Applications on Host]
        E --> F[Web Server HTTP]
        E --> G[Database Connection]
        E --> H[SSH Access]
        E --> I[Disk Space]
    end
    
    A -.-> E
    
    style A fill:#e3f2fd
    style E fill:#e8f5e8
    style B fill:#fff3e0
    style C fill:#fff3e0
    style D fill:#fff3e0
    style F fill:#f3e5f5
    style G fill:#f3e5f5
    style H fill:#f3e5f5
    style I fill:#f3e5f5
```

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

### **Status States Flow:**

```mermaid
stateDiagram-v2
    [*] --> OK
    OK --> WARNING: Performance degraded
    WARNING --> OK: Performance restored
    WARNING --> CRITICAL: Service failed
    CRITICAL --> OK: Service restored
    OK --> CRITICAL: Service failed suddenly
    CRITICAL --> UNKNOWN: Cannot determine status
    UNKNOWN --> OK: Status determined - working
    UNKNOWN --> CRITICAL: Status determined - failed
    
    note right of OK: 🟢 Green - Everything working
    note right of WARNING: 🟡 Yellow - Minor issues
    note right of CRITICAL: 🔴 Red - Major failure
    note right of UNKNOWN: ⚪ Gray - Status unclear
```

### **Check Types:**

```mermaid
graph LR
    subgraph "Active Checks"
        A[Nagios Core] --> B[Plugin]
        B --> C[Target Service]
        C --> D[Result]
        D --> A
    end
    
    subgraph "Passive Checks"
        E[External System] --> F[Result]
        F --> G[Nagios Core]
    end
    
    style A fill:#e3f2fd
    style B fill:#e8f5e8
    style C fill:#fff3e0
    style D fill:#f3e5f5
    style E fill:#fce4ec
    style F fill:#f3e5f5
    style G fill:#e3f2fd
```

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

### **Lab Architecture:**

```mermaid
graph TB
    subgraph "Docker Environment"
        subgraph "Nagios Container"
            A[Nagios Server<br/>Port 8080]
            A1[Web Dashboard]
            A2[Monitoring Engine]
            A3[Configuration]
        end
        
        subgraph "Target Containers"
            B[Nginx Server<br/>Port 8081]
            C[Apache Server<br/>Port 8082]
        end
        
        subgraph "Monitoring Network"
            D[Docker Bridge Network]
        end
    end
    
    A2 --> B
    A2 --> C
    A1 --> A2
    A3 --> A2
    B --> D
    C --> D
    A --> D
    
    style A fill:#e3f2fd
    style A1 fill:#e8f5e8
    style A2 fill:#fff3e0
    style A3 fill:#f3e5f5
    style B fill:#fce4ec
    style C fill:#fce4ec
    style D fill:#e0f2f1
```

### **What You Need:**
- Docker installed and running
- Docker Compose installed
- Ports 8080, 8081, 8082 available
- Web browser for accessing dashboard

---

## 🏗️ **Step 1: Start the Lab Environment**

### **Clone Repository:**
```bash
git clone https://github.com/manikcloud/cloud-devops-learning-path.git
cd cloud-devops-learning-path/Section-2-DevOps/Session-10_Monitoring-Tools/01-nagios
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

### **Dashboard Navigation Flow:**

```mermaid
graph TD
    A[Login Page] --> B[Main Dashboard]
    B --> C[Current Status]
    B --> D[Reports]
    B --> E[System]
    
    C --> F[Hosts]
    C --> G[Services]
    C --> H[Problems]
    
    F --> I[Host Details]
    G --> J[Service Details]
    H --> K[Problem Analysis]
    
    style A fill:#ffcdd2
    style B fill:#e3f2fd
    style C fill:#e8f5e8
    style D fill:#fff3e0
    style E fill:#f3e5f5
    style F fill:#c8e6c9
    style G fill:#c8e6c9
    style H fill:#ffcdd2
    style I fill:#e1f5fe
    style J fill:#e1f5fe
    style K fill:#ffebee
```

---

## 📊 **Step 3: Navigate the Monitoring Dashboard**

### **Status Visualization:**

```mermaid
graph TB
    subgraph "Normal Operations - All Green"
        A1[nginx-target: UP 🟢]
        A2[apache-target: UP 🟢]
        A3[HTTP Services: OK 🟢]
        A4[PING Services: OK 🟢]
    end
    
    subgraph "Service Failure - Red Alert"
        B1[nginx-target: DOWN 🔴]
        B2[apache-target: UP 🟢]
        B3[nginx HTTP: CRITICAL 🔴]
        B4[nginx PING: CRITICAL 🔴]
        B5[apache HTTP: OK 🟢]
        B6[apache PING: OK 🟢]
    end
    
    A1 -.->|Container Stopped| B1
    A3 -.->|Service Failed| B3
    A4 -.->|Host Unreachable| B4
    
    style A1 fill:#c8e6c9
    style A2 fill:#c8e6c9
    style A3 fill:#c8e6c9
    style A4 fill:#c8e6c9
    style B1 fill:#ffcdd2
    style B2 fill:#c8e6c9
    style B3 fill:#ffcdd2
    style B4 fill:#ffcdd2
    style B5 fill:#c8e6c9
    style B6 fill:#c8e6c9
```

### **Key Pages for Students:**

#### **Host Status Page:**
```
Navigation: Current Status → Hosts
URL: http://localhost:8080/nagios/cgi-bin/status.cgi?hostgroup=all&style=hostdetail
```

#### **Service Status Page:**
```
Navigation: Current Status → Services
URL: http://localhost:8080/nagios/cgi-bin/status.cgi?host=all
```

---

## 🧪 **Step 4: Hands-On Monitoring Exercises**

### **Exercise Flow:**

```mermaid
graph TD
    A[Start: All Services Green 🟢] --> B[Stop nginx Container]
    B --> C[Wait 3-5 Minutes]
    C --> D[Observe Red Status 🔴]
    D --> E[Analyze Impact]
    E --> F[Restart nginx Container]
    F --> G[Wait 3-5 Minutes]
    G --> H[Confirm Green Status 🟢]
    H --> I[Exercise Complete ✅]
    
    style A fill:#c8e6c9
    style D fill:#ffcdd2
    style H fill:#c8e6c9
    style I fill:#e3f2fd
```

### **Exercise 1: Observe Normal Operations (Green Status)**

#### **View Host Status:**
1. Navigate to **Current Status → Hosts**
2. Observe all hosts show **UP** status with 🟢 green background
3. Note the **Last Check** times and **Duration**

### **Exercise 2: Simulate Service Failure (Red Status)**

#### **Create a Failure:**
```bash
# Stop the nginx web server
docker-compose stop nginx-target

# Wait 3-5 minutes for Nagios to detect the failure
```

#### **Failure Impact Visualization:**

```mermaid
graph TD
    A[nginx Container Stopped] --> B[Network Unreachable]
    B --> C[PING Check Fails]
    B --> D[HTTP Check Fails]
    C --> E[Host Status: DOWN 🔴]
    D --> F[Service Status: CRITICAL 🔴]
    E --> G[Alert Generated 📧]
    F --> G
    G --> H[Problem Dashboard Updated]
    
    style A fill:#ffcdd2
    style B fill:#ffcdd2
    style C fill:#ffcdd2
    style D fill:#ffcdd2
    style E fill:#ffcdd2
    style F fill:#ffcdd2
    style G fill:#fff3e0
    style H fill:#e3f2fd
```

### **Exercise 3: Service Recovery**

#### **Recovery Flow:**

```mermaid
graph TD
    A[Restart nginx Container] --> B[Container Starts]
    B --> C[Network Accessible]
    C --> D[PING Check Succeeds]
    C --> E[HTTP Check Succeeds]
    D --> F[Host Status: UP 🟢]
    E --> G[Service Status: OK 🟢]
    F --> H[Recovery Alert 📧]
    G --> H
    H --> I[Dashboard Shows Green]
    
    style A fill:#e8f5e8
    style B fill:#c8e6c9
    style C fill:#c8e6c9
    style D fill:#c8e6c9
    style E fill:#c8e6c9
    style F fill:#c8e6c9
    style G fill:#c8e6c9
    style H fill:#e3f2fd
    style I fill:#c8e6c9
```

---

## 🔧 **Step 5: Understanding Configuration**

### **Configuration Relationship:**

```mermaid
graph TB
    subgraph "Configuration Files"
        A[hosts.cfg]
        B[services.cfg]
        C[commands.cfg]
        D[contacts.cfg]
    end
    
    subgraph "Runtime Objects"
        E[Host Objects]
        F[Service Objects]
        G[Command Objects]
        H[Contact Objects]
    end
    
    subgraph "Monitoring Actions"
        I[Check Execution]
        J[Status Updates]
        K[Notifications]
    end
    
    A --> E
    B --> F
    C --> G
    D --> H
    
    E --> I
    F --> I
    G --> I
    I --> J
    J --> K
    H --> K
    
    style A fill:#e3f2fd
    style B fill:#e8f5e8
    style C fill:#fff3e0
    style D fill:#f3e5f5
    style E fill:#e1f5fe
    style F fill:#e8f5e8
    style G fill:#fff3e0
    style H fill:#f3e5f5
    style I fill:#fce4ec
    style J fill:#fce4ec
    style K fill:#fce4ec
```

### **Host Configuration (hosts.cfg):**
```bash
# View host definitions
cat nagios/config/hosts.cfg
```

### **Service Configuration (services.cfg):**
```bash
# View service definitions
cat nagios/config/services.cfg
```

---

## 📝 **Step 6: Monitor Logs and Events**

### **Log Event Flow:**

```mermaid
sequenceDiagram
    participant S as Service
    participant N as Nagios Core
    participant L as Log File
    participant W as Web Interface
    participant U as User
    
    S->>S: Service Fails
    N->>S: Check Service
    S-->>N: No Response
    N->>L: Write: SERVICE ALERT CRITICAL
    N->>N: Update Status
    U->>W: View Dashboard
    W->>N: Read Status
    W-->>U: Show Red Status 🔴
    
    Note over S,N: Check every 5 minutes
    Note over N,L: All events logged
    Note over U,W: Real-time updates
```

### **View Real-Time Logs:**
```bash
# Watch Nagios logs in real-time
docker-compose logs -f nagios

# View specific container logs
docker-compose logs nginx-target
docker-compose logs apache-target
```

---

## 🛠️ **Step 7: Troubleshooting Common Issues**

### **Troubleshooting Decision Tree:**

```mermaid
graph TD
    A[Problem Detected] --> B{Can Access Web Interface?}
    B -->|No| C[Check Container Status]
    B -->|Yes| D{Seeing Status Data?}
    
    C --> E[Restart Containers]
    E --> F[Check Logs]
    
    D -->|No| G[Check Configuration]
    D -->|Yes| H{Services Showing Unknown?}
    
    G --> I[Validate Config Files]
    I --> J[Restart Nagios]
    
    H -->|Yes| K[Check Network Connectivity]
    H -->|No| L[Monitor Working Correctly]
    
    K --> M[Restart All Containers]
    
    style A fill:#ffcdd2
    style C fill:#fff3e0
    style G fill:#fff3e0
    style K fill:#fff3e0
    style L fill:#c8e6c9
```

---

## 📊 **Step 8: Monitoring Best Practices**

### **Monitoring Strategy Pyramid:**

```mermaid
graph TD
    subgraph "Monitoring Levels"
        A[Business Metrics<br/>Revenue, Users, Transactions]
        B[Application Metrics<br/>Response Time, Error Rate, Throughput]
        C[System Metrics<br/>CPU, Memory, Disk, Network]
        D[Infrastructure Metrics<br/>Host Availability, Network Connectivity]
    end
    
    A --> B
    B --> C
    C --> D
    
    style A fill:#e3f2fd
    style B fill:#e8f5e8
    style C fill:#fff3e0
    style D fill:#f3e5f5
```

### **Alert Escalation Flow:**

```mermaid
graph TD
    A[Service Check Fails] --> B{First Failure?}
    B -->|Yes| C[SOFT State - Retry]
    B -->|No| D[HARD State - Alert]
    
    C --> E[Retry Check]
    E --> F{Check Passes?}
    F -->|Yes| G[Return to OK]
    F -->|No| H{Max Retries?}
    
    H -->|No| C
    H -->|Yes| D
    
    D --> I[Send Notification]
    I --> J[Log Alert]
    J --> K[Update Dashboard]
    
    style A fill:#ffcdd2
    style C fill:#fff3e0
    style D fill:#ffcdd2
    style G fill:#c8e6c9
    style I fill:#e3f2fd
```

---

## 🎯 **Step 9: Real-World Applications**

### **Enterprise Monitoring Architecture:**

```mermaid
graph TB
    subgraph "Production Environment"
        subgraph "Web Tier"
            A[Load Balancer]
            B[Web Server 1]
            C[Web Server 2]
            D[Web Server 3]
        end
        
        subgraph "Application Tier"
            E[App Server 1]
            F[App Server 2]
            G[Message Queue]
        end
        
        subgraph "Data Tier"
            H[Primary DB]
            I[Replica DB]
            J[Cache Server]
        end
        
        subgraph "Monitoring Infrastructure"
            K[Nagios Master]
            L[Nagios Slave 1]
            M[Nagios Slave 2]
        end
    end
    
    A --> B
    A --> C
    A --> D
    B --> E
    C --> F
    E --> G
    F --> G
    E --> H
    F --> H
    H --> I
    E --> J
    F --> J
    
    K --> L
    K --> M
    L -.-> A
    L -.-> B
    L -.-> C
    M -.-> E
    M -.-> F
    M -.-> G
    K -.-> H
    K -.-> I
    K -.-> J
    
    style K fill:#e3f2fd
    style L fill:#e8f5e8
    style M fill:#e8f5e8
```

### **DevOps Integration:**

```mermaid
graph LR
    subgraph "CI/CD Pipeline"
        A[Code Commit] --> B[Build]
        B --> C[Test]
        C --> D[Deploy]
    end
    
    subgraph "Monitoring Integration"
        E[Deploy Monitoring Config]
        F[Health Check Validation]
        G[Performance Baseline]
        H[Alert Configuration]
    end
    
    D --> E
    E --> F
    F --> G
    G --> H
    H --> I[Production Monitoring]
    
    style A fill:#e3f2fd
    style B fill:#e8f5e8
    style C fill:#fff3e0
    style D fill:#f3e5f5
    style E fill:#fce4ec
    style F fill:#fce4ec
    style G fill:#fce4ec
    style H fill:#fce4ec
    style I fill:#c8e6c9
```

---

## 🔧 **Step 5: Understanding Configuration**

### **Configuration Overview:**
Nagios uses multiple configuration files to define what to monitor and how. For detailed technical information, see our [Configuration Guide](./config-guide/CONFIGURATION-GUIDE.md).

### **Key Configuration Files:**

```mermaid
graph TB
    A[nagios.cfg<br/>Main Config] --> B[Object Files]
    B --> C[hosts.cfg<br/>Define Servers]
    B --> D[services.cfg<br/>Define Checks]
    B --> E[commands.cfg<br/>Define Commands]
    B --> F[contacts.cfg<br/>Define Alerts]
    
    style A fill:#e3f2fd
    style B fill:#e8f5e8
    style C fill:#fff3e0
    style D fill:#f3e5f5
    style E fill:#fce4ec
    style F fill:#e1f5fe
```

### **Quick Configuration Examples:**

#### **View Host Configuration:**
```bash
cat nagios/config/hosts.cfg
```

#### **View Service Configuration:**
```bash
cat nagios/config/services.cfg
```

#### **Basic Host Definition:**
```bash
define host {
    use                     linux-server        # Template
    host_name               nginx-target        # Unique name
    alias                   Nginx Web Server    # Description
    address                 nginx-target        # IP/hostname
    check_command           check-host-alive    # How to check
}
```

#### **Basic Service Definition:**
```bash
define service {
    use                     generic-service     # Template
    host_name               nginx-target        # Which host
    service_description     HTTP                # Service name
    check_command           check_http          # How to test
    check_interval          5                   # Every 5 minutes
}
```

**📚 For complete configuration details, examples, and best practices, see [Configuration Guide](./config-guide/CONFIGURATION-GUIDE.md)**

## 🧹 **Step 10: Cleanup and Next Steps**

### **Cleanup Process:**

```mermaid
graph TD
    A[Lab Complete] --> B[Stop Containers]
    B --> C[Remove Containers]
    C --> D[Clean Networks]
    D --> E[Remove Images Optional]
    E --> F[Verify Cleanup]
    F --> G[Environment Clean ✅]
    
    style A fill:#e3f2fd
    style G fill:#c8e6c9
```

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

### **Monitoring Evolution:**

```mermaid
graph TD
    A[Traditional Monitoring<br/>Nagios, Zabbix] --> B[Modern Metrics<br/>Prometheus, Grafana]
    B --> C[Observability<br/>Traces, Logs, Metrics]
    C --> D[AI/ML Monitoring<br/>Anomaly Detection]
    
    style A fill:#fff3e0
    style B fill:#e8f5e8
    style C fill:#e3f2fd
    style D fill:#f3e5f5
```

### **Technology Comparison:**

```mermaid
graph TB
    subgraph "Monitoring Tools Landscape"
        A[Nagios<br/>Traditional Infrastructure]
        B[Prometheus<br/>Metrics & Alerting]
        C[Grafana<br/>Visualization]
        D[ELK Stack<br/>Log Analysis]
        E[DataDog<br/>Cloud SaaS]
        F[New Relic<br/>APM]
    end
    
    A -.-> B
    B --> C
    A -.-> D
    B -.-> E
    C -.-> E
    D -.-> F
    
    style A fill:#fff3e0
    style B fill:#e8f5e8
    style C fill:#e3f2fd
    style D fill:#f3e5f5
    style E fill:#fce4ec
    style F fill:#e1f5fe
```

---

## 🎓 **Assessment and Learning Outcomes**

### **Learning Progress:**

```mermaid
graph TD
    A[Basic Concepts] --> B[Hands-On Practice]
    B --> C[Problem Solving]
    C --> D[Real-World Application]
    D --> E[Advanced Topics]
    
    A1[Host vs Service] --> A
    A2[Status States] --> A
    A3[Check Types] --> A
    
    B1[Navigate Dashboard] --> B
    B2[Simulate Failures] --> B
    B3[Read Logs] --> B
    
    C1[Troubleshoot Issues] --> C
    C2[Analyze Problems] --> C
    C3[Fix Configuration] --> C
    
    D1[Design Strategy] --> D
    D2[Best Practices] --> D
    D3[Integration] --> D
    
    E1[Custom Scripts] --> E
    E2[Advanced Tools] --> E
    E3[Cloud Monitoring] --> E
    
    style A fill:#e3f2fd
    style B fill:#e8f5e8
    style C fill:#fff3e0
    style D fill:#f3e5f5
    style E fill:#fce4ec
```

### **Competency Checklist:**
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
