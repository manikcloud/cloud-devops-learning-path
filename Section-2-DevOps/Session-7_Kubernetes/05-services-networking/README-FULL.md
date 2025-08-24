# 🌐 Services & Networking - Complete Guide

<div align="center">

![Services](https://img.shields.io/badge/Services-Networking-blue?style=for-the-badge&logo=kubernetes&logoColor=white)
![Complete](https://img.shields.io/badge/Complete-Guide-green?style=for-the-badge&logo=check&logoColor=white)

**🎯 Connect to Pods | 🌐 Expose Apps | ⚖️ Load Balance | 🔍 Service Discovery**

</div>

---

## 📥 Get Started

### **Navigate to Services & Networking Directory**
```bash
# Navigate to the services and networking directory
cd cloud-devops-learning-path/Section-2-DevOps/Session-7_Kubernetes/05-services-networking

# List the service YAML files
ls -la *.yaml
```

---

## 🎯 What We'll Learn

```mermaid
graph TD
    A[Step 1: Write Service YAML - ClusterIP and NodePort] --> B[Step 2: Internal Communication - ClusterIP Services]
    B --> C[Step 3: External Access - NodePort Services]
    C --> D[Step 4: Cloud LoadBalancer - AWS ALB Integration]
    D --> E[Step 5: Service Discovery - Apps find each other]
    E --> F[Step 6: Load Balancing - Traffic distribution]
    F --> G[Step 7: Complete App - Frontend + Backend + DB]
    
    style A fill:#e1f5fe
    style B fill:#fff3e0
    style C fill:#e8f5e8
    style D fill:#ff9800
    style E fill:#f3e5f5
    style F fill:#fce4ec
    style G fill:#c8e6c9
```

**Build from simple services to complete multi-service applications!**

---

## 🧠 Understanding the Problem: Why Do We Need Services?

### **The Challenge Without Services**
Imagine you have a web application with multiple components:

```mermaid
graph TB
    subgraph "Without Services - Problems"
        FRONTEND1[Frontend Pod - IP: 10.42.0.5]
        API1[API Pod - IP: 10.42.0.8]
        DB1[Database Pod - IP: 10.42.0.12]
        
        FRONTEND1 -.->|Hard-coded IP| API1
        API1 -.->|Hard-coded IP| DB1
    end
    
    subgraph "What Happens When Pods Restart?"
        FRONTEND2[Frontend Pod - IP: 10.42.0.15 NEW IP!]
        API2[API Pod - IP: 10.42.0.22 NEW IP!]
        DB2[Database Pod - IP: 10.42.0.31 NEW IP!]
        
        FRONTEND2 -.->|Broken Connection| API2
        API2 -.->|Broken Connection| DB2
    end
    
    style FRONTEND1 fill:#ffebee
    style API1 fill:#ffebee
    style DB1 fill:#ffebee
    style FRONTEND2 fill:#ffcdd2
    style API2 fill:#ffcdd2
    style DB2 fill:#ffcdd2
```

**Problems Without Services:**
- 🚫 **Pod IPs change** when pods restart
- 🚫 **Hard to scale** - Can't add more pods easily
- 🚫 **No load balancing** - Traffic goes to one pod only
- 🚫 **Complex configuration** - Must track all IP addresses
- 🚫 **Brittle connections** - One pod failure breaks everything

### **The Solution: Services Act as Stable Intermediaries**

```mermaid
graph TB
    subgraph "With Services - Stable and Reliable"
        FRONTEND[Frontend Pods - Multiple instances]
        FRONTEND_SVC[Frontend Service - Stable IP and DNS]
        
        API[API Pods - Multiple instances]
        API_SVC[API Service - Stable IP and DNS]
        
        DB[Database Pod - Single instance]
        DB_SVC[Database Service - Stable IP and DNS]
        
        FRONTEND --> API_SVC
        API_SVC --> API
        API --> DB_SVC
        DB_SVC --> DB
        FRONTEND_SVC --> FRONTEND
    end
    
    style FRONTEND_SVC fill:#c8e6c9
    style API_SVC fill:#c8e6c9
    style DB_SVC fill:#c8e6c9
    style FRONTEND fill:#e1f5fe
    style API fill:#e1f5fe
    style DB fill:#e1f5fe
```

**Benefits With Services:**
- ✅ **Stable endpoints** - Services never change their IP/DNS
- ✅ **Automatic load balancing** - Traffic distributed across pods
- ✅ **Service discovery** - Find services by name, not IP
- ✅ **Health checking** - Only route to healthy pods
- ✅ **Easy scaling** - Add/remove pods without breaking connections

---

## 🌐 Understanding Services - The Foundation

### **What Exactly is a Service?**

Think of a Service as a **smart phone directory** for your applications:

```mermaid
graph TB
    USER[User - Wants to call Pizza Shop] --> DIRECTORY[Phone Directory - Pizza Shop = 555-PIZZA]
    DIRECTORY --> PIZZA[Pizza Shop - Actual phone: 555-PIZZA]
    
    subgraph "In Kubernetes"
        APP[App - Wants to call api-service] --> SERVICE[Service - api-service = 10.96.0.100]
        SERVICE --> POD1[API Pod 1 - IP: 10.42.0.5]
        SERVICE --> POD2[API Pod 2 - IP: 10.42.0.6]
        SERVICE --> POD3[API Pod 3 - IP: 10.42.0.7]
    end
    
    style USER fill:#e3f2fd
    style DIRECTORY fill:#e8f5e8
    style PIZZA fill:#fff3e0
    style APP fill:#e3f2fd
    style SERVICE fill:#e8f5e8
    style POD1 fill:#e1f5fe
    style POD2 fill:#e1f5fe
    style POD3 fill:#e1f5fe
```

**Key Service Concepts:**
- 🎯 **Abstraction Layer** - Hides complexity of individual pods
- 📱 **Stable Interface** - Same IP and DNS name always
- ⚖️ **Load Balancer** - Distributes traffic automatically
- 🔍 **Service Discovery** - Apps find services by name
- 🏷️ **Label Selector** - Finds pods using labels

### **How Services Find Pods: The Label System**

```mermaid
graph TB
    subgraph "Pods with Labels"
        POD1[Pod 1 - Labels: app=web, version=v1, tier=frontend]
        POD2[Pod 2 - Labels: app=web, version=v1, tier=frontend]
        POD3[Pod 3 - Labels: app=api, version=v2, tier=backend]
        POD4[Pod 4 - Labels: app=db, version=v1, tier=database]
    end
    
    subgraph "Services with Selectors"
        SVC1[Web Service - Selector: app=web, tier=frontend]
        SVC2[API Service - Selector: app=api, tier=backend]
        SVC3[DB Service - Selector: app=db]
    end
    
    SVC1 --> POD1
    SVC1 --> POD2
    SVC2 --> POD3
    SVC3 --> POD4
    
    style POD1 fill:#e1f5fe
    style POD2 fill:#e1f5fe
    style POD3 fill:#fff3e0
    style POD4 fill:#f3e5f5
    style SVC1 fill:#c8e6c9
    style SVC2 fill:#c8e6c9
    style SVC3 fill:#c8e6c9
```

**How Label Selection Works:**
1. **Service defines selector** - Specifies which labels to match
2. **Kubernetes scans all pods** - Looks for matching labels
3. **Creates endpoint list** - Maintains list of matching pod IPs
4. **Updates automatically** - Adds/removes pods as they change
5. **Routes traffic** - Sends requests to healthy endpoints only

---

## 🌐 How Kubernetes Networking Works

### **The Big Picture: Pod-to-Pod Communication**

```mermaid
graph TB
    subgraph "Node 1 Worker"
        POD1[Pod A - IP: 10.42.0.5 - App: Frontend]
        POD2[Pod B - IP: 10.42.0.6 - App: API]
        BRIDGE1[Bridge Network - 10.42.0.0/24]
        POD1 --- BRIDGE1
        POD2 --- BRIDGE1
    end
    
    subgraph "Node 2 Worker"
        POD3[Pod C - IP: 10.42.1.5 - App: Database]
        POD4[Pod D - IP: 10.42.1.6 - App: Cache]
        BRIDGE2[Bridge Network - 10.42.1.0/24]
        POD3 --- BRIDGE2
        POD4 --- BRIDGE2
    end
    
    subgraph "Cluster Network"
        OVERLAY[Overlay Network - Connects all nodes]
    end
    
    BRIDGE1 --- OVERLAY
    BRIDGE2 --- OVERLAY
    
    POD1 -.->|Can talk directly| POD3
    POD2 -.->|Can talk directly| POD4
    
    style POD1 fill:#e1f5fe
    style POD2 fill:#fff3e0
    style POD3 fill:#f3e5f5
    style POD4 fill:#e8f5e8
    style BRIDGE1 fill:#fce4ec
    style BRIDGE2 fill:#fce4ec
    style OVERLAY fill:#e3f2fd
```

**Kubernetes Networking Principles:**
1. **Every pod gets unique IP** - No port conflicts
2. **Pods can talk to any pod** - Across all nodes
3. **No NAT required** - Direct IP communication
4. **Flat network space** - All pods in same network
5. **Container Network Interface (CNI)** - Handles the complexity

### **Why Pod IPs Are Not Reliable**

```mermaid
graph TB
    subgraph "Time: 9:00 AM"
        POD1[Frontend Pod - IP: 10.42.0.5 - Status: Running]
        POD2[API Pod - IP: 10.42.0.8 - Status: Running]
        
        POD1 -->|Calls API| POD2
    end
    
    subgraph "Time: 9:15 AM - Pod Crashes"
        POD1B[Frontend Pod - IP: 10.42.0.5 - Status: Running]
        POD2B[API Pod - IP: 10.42.0.8 - Status: Crashed]
        
        POD1B -.->|Connection Failed| POD2B
    end
    
    subgraph "Time: 9:16 AM - Kubernetes Restarts Pod"
        POD1C[Frontend Pod - IP: 10.42.0.5 - Status: Running]
        POD2C[API Pod - IP: 10.42.0.15 NEW IP! - Status: Running]
        
        POD1C -.->|Still calling old IP| POD2C
    end
    
    style POD1 fill:#c8e6c9
    style POD2 fill:#c8e6c9
    style POD1B fill:#c8e6c9
    style POD2B fill:#ffcdd2
    style POD1C fill:#c8e6c9
    style POD2C fill:#fff3e0
```

**Pod IP Problems:**
- 🔄 **Pods restart frequently** - Updates, crashes, scaling
- 🎲 **New IP every restart** - Kubernetes assigns randomly
- 💥 **Breaks hard-coded connections** - Apps stop working
- 📈 **Scaling issues** - Can't predict how many pods
- 🔍 **Discovery problems** - How to find new pods?

**Services Solve This:**
- 🎯 **Stable IP and DNS** - Never changes
- 🔄 **Automatic updates** - Tracks pod changes
- ⚖️ **Load balancing** - Distributes across all pods
- 🏥 **Health checking** - Only routes to healthy pods

---

## 🏠 Step 2: ClusterIP Services - Internal Communication

### **Understanding ClusterIP: The Default Service Type**

ClusterIP is like having a **private phone line** inside your office building:

```mermaid
graph TB
    subgraph "Office Building - Kubernetes Cluster"
        subgraph "Internal Phone System - ClusterIP"
            RECEPTION[Reception - Extension: 100 - ClusterIP Service]
            
            RECEPTION --> EMP1[Employee 1 - Desk A - Pod 1]
            RECEPTION --> EMP2[Employee 2 - Desk B - Pod 2]
            RECEPTION --> EMP3[Employee 3 - Desk C - Pod 3]
        end
        
        CALLER[Internal Caller - Another Pod] --> RECEPTION
    end
    
    OUTSIDE[Outside World] -.->|Cannot Call| RECEPTION
    
    style RECEPTION fill:#e8f5e8
    style EMP1 fill:#e1f5fe
    style EMP2 fill:#e1f5fe
    style EMP3 fill:#e1f5fe
    style CALLER fill:#fff3e0
    style OUTSIDE fill:#ffebee
```

**ClusterIP Characteristics:**
- 🏠 **Internal Only** - Only accessible from within the cluster
- 🎯 **Default Type** - Created automatically if no type specified
- 💰 **Free** - No additional costs
- ⚖️ **Load Balancing** - Distributes traffic across all pods
- 🔍 **DNS Name** - Accessible by service name

### **How ClusterIP Works Behind the Scenes**

```mermaid
graph TB
    subgraph "Kubernetes Control Plane"
        API[API Server - Receives service creation]
        CONTROLLER[Service Controller - Manages service lifecycle]
        ENDPOINTS[Endpoints Controller - Tracks pod IPs]
    end
    
    subgraph "Worker Nodes"
        KUBE_PROXY[kube-proxy - Updates iptables rules]
        IPTABLES[iptables - Routes traffic to pods]
        
        POD1[Pod 1 - 10.42.0.5:80]
        POD2[Pod 2 - 10.42.0.6:80]
        POD3[Pod 3 - 10.42.0.7:80]
    end
    
    CLIENT[Client Pod] --> IPTABLES
    IPTABLES --> POD1
    IPTABLES --> POD2
    IPTABLES --> POD3
    
    API --> CONTROLLER
    CONTROLLER --> ENDPOINTS
    ENDPOINTS --> KUBE_PROXY
    KUBE_PROXY --> IPTABLES
    
    style API fill:#e3f2fd
    style CONTROLLER fill:#fff3e0
    style ENDPOINTS fill:#e8f5e8
    style KUBE_PROXY fill:#f3e5f5
    style IPTABLES fill:#fce4ec
    style POD1 fill:#e1f5fe
    style POD2 fill:#e1f5fe
    style POD3 fill:#e1f5fe
    style CLIENT fill:#c8e6c9
```

**ClusterIP Process:**
1. **Service Created** - You create a ClusterIP service
2. **IP Allocated** - Kubernetes assigns a virtual IP (10.96.x.x range)
3. **Endpoints Tracked** - Controller finds matching pods
4. **Rules Updated** - kube-proxy updates iptables on all nodes
5. **Traffic Routed** - iptables forwards traffic to healthy pods

### **📝 Step 1: Writing Your First ClusterIP Service**

Let's start with the simplest service - ClusterIP for internal communication:

### **01-clusterip-service.yaml**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: web-service
  labels:
    app: web
spec:
  type: ClusterIP
  ports:
  - port: 80
    targetPort: 80
    protocol: TCP
  selector:
    app: web
    tier: frontend
```

**What each line means:**
- `kind: Service` - We're creating a service
- `name: web-service` - Name of our service
- `type: ClusterIP` - Internal only (default type)
- `port: 80` - Port the service listens on
- `targetPort: 80` - Port on the pod to forward to
- `selector:` - Which pods this service connects to

### **Try it out:**
```bash
# First, create a pod that matches the selector
k run web-pod --image=varunmanik/httpd:blue --labels="app=web,tier=frontend"

# Create the ClusterIP service
k apply -f 01-clusterip-service.yaml

# Check the service
k get services

# Test internal access
k run test --image=busybox --rm -it -- wget -qO- http://web-service

# Clean up
k delete service web-service
k delete pod web-pod
```

---

## 🚪 Step 3: NodePort Services - External Access

### **Understanding NodePort: Opening the Door to the Outside**

NodePort is like having a **public reception desk** that anyone can visit:

```mermaid
graph TB
    subgraph "Office Building - Kubernetes Cluster"
        subgraph "Public Reception - NodePort"
            RECEPTION[Public Reception - Port 30080 - NodePort Service]
            
            RECEPTION --> INTERNAL[Internal System - ClusterIP]
            INTERNAL --> EMP1[Employee 1 - Pod 1]
            INTERNAL --> EMP2[Employee 2 - Pod 2]
            INTERNAL --> EMP3[Employee 3 - Pod 3]
        end
    end
    
    VISITOR1[External Visitor 1] --> RECEPTION
    VISITOR2[External Visitor 2] --> RECEPTION
    VISITOR3[External Visitor 3] --> RECEPTION
    
    style RECEPTION fill:#fff3e0
    style INTERNAL fill:#e8f5e8
    style EMP1 fill:#e1f5fe
    style EMP2 fill:#e1f5fe
    style EMP3 fill:#e1f5fe
    style VISITOR1 fill:#e3f2fd
    style VISITOR2 fill:#e3f2fd
    style VISITOR3 fill:#e3f2fd
```

**NodePort Characteristics:**
- 🌍 **External Access** - Accessible from outside the cluster
- 🚪 **Port Range** - Uses ports 30000-32767 on every node
- 💰 **Free** - No cloud provider charges
- 🎯 **Development Friendly** - Great for testing and development
- ⚖️ **Load Balancing** - Still distributes traffic across pods

### **How NodePort Works: The Complete Journey**

```mermaid
graph TB
    subgraph "External World"
        USER[User - Browser/curl]
        LAPTOP[Your Laptop - 192.168.1.100]
    end
    
    subgraph "Kubernetes Cluster"
        subgraph "Node 1"
            NODE1[Node IP - 10.0.1.10:30080]
            KUBE_PROXY1[kube-proxy - Port forwarding]
        end
        
        subgraph "Node 2"
            NODE2[Node IP - 10.0.1.11:30080]
            KUBE_PROXY2[kube-proxy - Port forwarding]
        end
        
        subgraph "Service Layer"
            NODEPORT_SVC[NodePort Service - Port 80 to 30080]
            CLUSTERIP[ClusterIP - 10.96.0.100:80]
        end
        
        subgraph "Pods"
            POD1[Pod 1 - 10.42.0.5:80]
            POD2[Pod 2 - 10.42.0.6:80]
            POD3[Pod 3 - 10.42.1.5:80]
        end
    end
    
    USER --> LAPTOP
    LAPTOP -->|http://10.0.1.10:30080| NODE1
    LAPTOP -->|http://10.0.1.11:30080| NODE2
    
    NODE1 --> KUBE_PROXY1
    NODE2 --> KUBE_PROXY2
    KUBE_PROXY1 --> NODEPORT_SVC
    KUBE_PROXY2 --> NODEPORT_SVC
    NODEPORT_SVC --> CLUSTERIP
    CLUSTERIP --> POD1
    CLUSTERIP --> POD2
    CLUSTERIP --> POD3
    
    style USER fill:#e3f2fd
    style LAPTOP fill:#e3f2fd
    style NODE1 fill:#fff3e0
    style NODE2 fill:#fff3e0
    style NODEPORT_SVC fill:#fff3e0
    style CLUSTERIP fill:#e8f5e8
    style POD1 fill:#e1f5fe
    style POD2 fill:#e1f5fe
    style POD3 fill:#e1f5fe
```

**NodePort Traffic Flow:**
1. **External Request** - User makes request to any node IP:30080
2. **Node Receives** - Any node can receive the request
3. **kube-proxy Routes** - Forwards to NodePort service
4. **Service Load Balances** - Distributes to healthy pods
5. **Pod Responds** - Response travels back same path

### **NodePort Port Allocation: Understanding the Numbers**

```mermaid
graph TB
    subgraph "Port Number Ranges"
        subgraph "Reserved Ports 1-1023"
            SYSTEM[System Ports - 22 SSH, 80 HTTP, 443 HTTPS, etc.]
        end
        
        subgraph "User Ports 1024-29999"
            USER_PORTS[User Applications - Your apps, databases, web servers, etc.]
        end
        
        subgraph "NodePort Range 30000-32767"
            NODEPORT_RANGE[NodePort Services - 30000, 30001, 30002, ...32767]
        end
    end
    
    style SYSTEM fill:#ffebee
    style USER_PORTS fill:#fff3e0
    style NODEPORT_RANGE fill:#e8f5e8
```

**Why 30000-32767 Range?**
- 🔒 **Avoids Conflicts** - Won't interfere with system or user ports
- 🎯 **Easy to Remember** - Clear separation from other services
- 🔢 **Plenty of Ports** - 2,768 available ports for services
- 🛡️ **Security** - High ports are less likely to be targeted

### **📝 Step 2: Writing Your NodePort Service**

Now let's create a NodePort service for external access:

### **02-nodeport-service.yaml**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: web-nodeport
  labels:
    app: web
spec:
  type: NodePort
  ports:
  - port: 80
    targetPort: 80
    nodePort: 30080
    protocol: TCP
  selector:
    application: web-app
    color: blue
```

**What's new:**
- `type: NodePort` - Allows external access
- `nodePort: 30080` - Specific port on the node (30000-32767 range)
- `selector:` - Matches pods with `application=web-app` and `color=blue`

### **How NodePort Works:**
```mermaid
graph TB
    INTERNET[Internet/Your Computer] --> NODE[Node - Port 30080]
    NODE --> SERVICE[NodePort Service - Port 80]
    SERVICE --> POD1[Pod 1]
    SERVICE --> POD2[Pod 2]
    SERVICE --> POD3[Pod 3]
    
    style INTERNET fill:#e3f2fd
    style NODE fill:#fff3e0
    style SERVICE fill:#e8f5e8
    style POD1 fill:#e1f5fe
    style POD2 fill:#e1f5fe
    style POD3 fill:#e1f5fe
```

### **Try it out:**
```bash
# Create a pod that matches the selector
k run blue-app --image=varunmanik/httpd:blue --labels="application=web-app,color=blue"

# Create the NodePort service
k apply -f 02-nodeport-service.yaml

# Check the service
k get services

# Access from outside the cluster
curl http://localhost:30080

# Or open in browser: http://localhost:30080

# Clean up
k delete service web-nodeport
k delete pod blue-app
```

---

## ☁️ Step 4: LoadBalancer Services - Production Cloud Integration

### **Understanding LoadBalancer: Enterprise-Grade External Access**

LoadBalancer is like having a **professional call center** with multiple operators:

```mermaid
graph TB
    subgraph "Internet"
        USERS[Many Users - From around the world]
    end
    
    subgraph "AWS Cloud"
        subgraph "Professional Call Center - AWS ALB"
            ALB[Application Load Balancer - SSL Termination, Health Checks, Auto Scaling, DDoS Protection]
            
            OPERATOR1[Operator 1 - Availability Zone A]
            OPERATOR2[Operator 2 - Availability Zone B]
            OPERATOR3[Operator 3 - Availability Zone C]
            
            ALB --> OPERATOR1
            ALB --> OPERATOR2
            ALB --> OPERATOR3
        end
        
        subgraph "Your Office - Kubernetes Cluster"
            SERVICE[LoadBalancer Service - Coordinates with ALB]
            
            POD1[Pod 1 - Your App Instance]
            POD2[Pod 2 - Your App Instance]
            POD3[Pod 3 - Your App Instance]
            
            SERVICE --> POD1
            SERVICE --> POD2
            SERVICE --> POD3
        end
    end
    
    USERS --> ALB
    OPERATOR1 --> SERVICE
    OPERATOR2 --> SERVICE
    OPERATOR3 --> SERVICE
    
    style USERS fill:#e3f2fd
    style ALB fill:#ff9800
    style OPERATOR1 fill:#fff3e0
    style OPERATOR2 fill:#fff3e0
    style OPERATOR3 fill:#fff3e0
    style SERVICE fill:#e8f5e8
    style POD1 fill:#e1f5fe
    style POD2 fill:#e1f5fe
    style POD3 fill:#e1f5fe
```

**LoadBalancer vs NodePort: Why Upgrade?**

| Feature | NodePort 🚪 | LoadBalancer ☁️ |
|---------|-------------|-----------------|
| **External Access** | ✅ Node IP:Port | ✅ Dedicated IP/DNS |
| **SSL/HTTPS** | ❌ Manual setup | ✅ Automatic |
| **Health Checks** | ❌ Basic | ✅ Advanced |
| **DDoS Protection** | ❌ None | ✅ Built-in |
| **Auto Scaling** | ❌ Manual | ✅ Automatic |
| **Professional DNS** | ❌ IP addresses | ✅ Custom domains |
| **Cost** | 💰 Free | 💰 ~$16/month |
| **Best For** | 🧪 Development | 🏭 Production |

### **How AWS LoadBalancer Integration Works**

```mermaid
graph TB
    subgraph "Internet Traffic"
        BROWSER[Web Browser - https://myapp.com]
        MOBILE[Mobile App - API calls]
        API_CLIENT[API Client - External integrations]
    end
    
    subgraph "AWS Infrastructure"
        subgraph "Route 53 DNS"
            DNS[DNS Resolution - myapp.com to ALB IP]
        end
        
        subgraph "CloudFront CDN - Optional"
            CDN[Content Delivery - Global edge locations]
        end
        
        subgraph "Application Load Balancer"
            ALB[AWS ALB - SSL Certificate, Health Checks, Access Logs, WAF Integration]
            
            TARGET_GROUP[Target Group - Health Check: /health, Protocol: HTTP, Port: 80]
        end
        
        subgraph "Security Groups"
            SG[Security Group - Port 80: 0.0.0.0/0, Port 443: 0.0.0.0/0]
        end
    end
    
    subgraph "Kubernetes Cluster EKS"
        subgraph "LoadBalancer Service"
            LB_SVC[LoadBalancer Service - Creates ALB, Manages Target Group, Updates Endpoints]
        end
        
        subgraph "Application Pods"
            POD1[Pod 1 - 10.42.0.5:80 - Status: Healthy]
            POD2[Pod 2 - 10.42.0.6:80 - Status: Healthy]
            POD3[Pod 3 - 10.42.0.7:80 - Status: Unhealthy]
        end
    end
    
    BROWSER --> DNS
    MOBILE --> DNS
    API_CLIENT --> DNS
    DNS --> CDN
    CDN --> ALB
    ALB --> TARGET_GROUP
    TARGET_GROUP --> SG
    SG --> LB_SVC
    LB_SVC --> POD1
    LB_SVC --> POD2
    LB_SVC -.->|Excluded| POD3
    
    style BROWSER fill:#e3f2fd
    style MOBILE fill:#e3f2fd
    style API_CLIENT fill:#e3f2fd
    style DNS fill:#fff3e0
    style CDN fill:#e8f5e8
    style ALB fill:#ff9800
    style TARGET_GROUP fill:#fff3e0
    style SG fill:#f3e5f5
    style LB_SVC fill:#e8f5e8
    style POD1 fill:#c8e6c9
    style POD2 fill:#c8e6c9
    style POD3 fill:#ffcdd2
```

**AWS LoadBalancer Features Explained:**

#### **🔒 SSL/TLS Termination**
- **What it does:** Handles HTTPS certificates automatically
- **Benefit:** Your pods only need HTTP, ALB handles HTTPS
- **Cost saving:** No need for SSL certificates in each pod

#### **🏥 Advanced Health Checks**
- **What it does:** Regularly checks if your pods are healthy
- **How:** Sends HTTP requests to `/health` endpoint
- **Benefit:** Automatically removes unhealthy pods from rotation

#### **📊 CloudWatch Integration**
- **What it does:** Provides detailed metrics and logs
- **Metrics:** Request count, response time, error rates
- **Benefit:** Monitor application performance and troubleshoot issues

#### **🛡️ Security Features**
- **DDoS Protection:** Built-in protection against attacks
- **WAF Integration:** Web Application Firewall for advanced security
- **Security Groups:** Fine-grained network access control

### **LoadBalancer Cost Breakdown (AWS)**

```mermaid
graph TB
    subgraph "AWS LoadBalancer Costs"
        subgraph "Fixed Costs Monthly"
            ALB_FIXED[ALB Base Cost - ~$16.20/month - $0.0225/hour]
        end
        
        subgraph "Variable Costs Usage-based"
            LCU[Load Balancer Capacity Units - $0.008 per LCU-hour - Based on traffic volume]
            
            DATA[Data Transfer - $0.09/GB outbound - Free inbound]
        end
        
        subgraph "Cost Optimization Tips"
            TIPS[Save Money: Delete unused LoadBalancers, Use during business hours only, Monitor LCU usage, Consider NodePort for dev]
        end
    end
    
    style ALB_FIXED fill:#ff9800
    style LCU fill:#fff3e0
    style DATA fill:#e8f5e8
    style TIPS fill:#c8e6c9
```

**Example Monthly Cost:**
- **Small App:** ~$20/month (ALB + minimal traffic)
- **Medium App:** ~$50/month (ALB + moderate traffic)
- **Large App:** ~$200+/month (ALB + high traffic)

### **📝 Step 3: Writing Your LoadBalancer Service**

For production applications, you want a proper cloud load balancer with an external IP address:

### **03-loadbalancer-service.yaml**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: web-loadbalancer
  labels:
    app: web
  annotations:
    service.beta.kubernetes.io/aws-load-balancer-type: "alb"
    service.beta.kubernetes.io/aws-load-balancer-scheme: "internet-facing"
    service.beta.kubernetes.io/aws-load-balancer-target-type: "ip"
spec:
  type: LoadBalancer
  ports:
  - port: 80
    targetPort: 80
    protocol: TCP
  selector:
    application: web-app
    color: blue
```

**What's new:**
- `type: LoadBalancer` - Creates cloud load balancer
- `aws-load-balancer-type: "alb"` - Use Application Load Balancer
- `internet-facing` - Accessible from internet
- `target-type: "ip"` - Route directly to pod IPs

### **How AWS LoadBalancer Works:**
```mermaid
graph TB
    INTERNET[Internet] --> ALB[AWS ALB - External IP: 52.1.2.3 - DNS: abc123.us-east-1.elb.amazonaws.com]
    ALB --> SERVICE[LoadBalancer Service - Port 80]
    SERVICE --> POD1[Pod 1 - 10.42.0.5]
    SERVICE --> POD2[Pod 2 - 10.42.0.6]
    SERVICE --> POD3[Pod 3 - 10.42.0.7]
    
    style INTERNET fill:#e3f2fd
    style ALB fill:#ff9800
    style SERVICE fill:#e8f5e8
    style POD1 fill:#e1f5fe
    style POD2 fill:#e1f5fe
    style POD3 fill:#e1f5fe
```

### **AWS LoadBalancer Benefits:**
- 🌍 **External IP Address** - Real internet-accessible IP
- 🔒 **SSL/TLS Termination** - Handle HTTPS certificates
- 🎯 **Health Checks** - Only route to healthy pods
- 📊 **CloudWatch Integration** - Monitoring and metrics
- 🛡️ **Security Groups** - AWS firewall integration
- ⚖️ **Advanced Load Balancing** - Multiple algorithms

### **Try it out (AWS EC2 Required):**
```bash
# Prerequisites: Running on AWS EKS or EC2 with proper IAM roles

# Create a pod that matches the selector
k run blue-app --image=varunmanik/httpd:blue --labels="application=web-app,color=blue"

# Create the LoadBalancer service
k apply -f 03-loadbalancer-service.yaml

# Check the service (this will take 2-3 minutes to provision)
k get services

# Wait for EXTERNAL-IP to show (not <pending>)
k get services -w

# Once you have external IP, test it
# Example: curl http://abc123.us-east-1.elb.amazonaws.com

# Check AWS Console to see the ALB created
# Go to EC2 → Load Balancers to see your new ALB

# Clean up (this will delete the AWS ALB)
k delete service web-loadbalancer
k delete pod blue-app
```

### **AWS LoadBalancer vs Other Types:**
```mermaid
graph TB
    subgraph "ClusterIP"
        A[Internal Only - 10.96.0.100 - Free]
    end
    
    subgraph "NodePort"  
        B[Node IP + Port - 192.168.1.10:30080 - Free]
    end
    
    subgraph "LoadBalancer"
        C[External IP + DNS - abc123.us-east-1.elb.amazonaws.com - AWS Charges Apply]
    end
    
    style A fill:#e1f5fe
    style B fill:#fff3e0
    style C fill:#ff9800
```

**Cost Considerations:**
- 💰 **ALB Cost**: ~$16/month + $0.008 per LCU-hour
- 💰 **Data Transfer**: Standard AWS data transfer rates
- 💰 **Health Checks**: Included in ALB cost
- 💡 **Tip**: Delete LoadBalancer services when not needed to avoid charges

---

## 🔧 Service Types Explained

```mermaid
graph TB
    subgraph "Service Types"
        A[ClusterIP - Internal only - Default type]
        B[NodePort - External access - via node IP:port]
        C[LoadBalancer - Cloud load balancer - External IP]
        D[ExternalName - DNS alias to external service]
    end
    
    style A fill:#e1f5fe
    style B fill:#fff3e0
    style C fill:#e8f5e8
    style D fill:#f3e5f5
```

### **When to Use Each Type:**

#### **🏠 ClusterIP (Internal Only)**
- **Use for:** Internal microservices communication
- **Access:** Only from within the cluster
- **Perfect for:** APIs, databases, internal services
- **Default type** - Most common

#### **🚪 NodePort (External Access)**
- **Use for:** Simple external access, development, testing
- **Access:** From outside the cluster via node IP:port
- **Port range:** 30000-32767
- **Good for:** Development environments

#### **☁️ LoadBalancer (Cloud)**
- **Use for:** Production external access
- **Access:** External IP address from cloud provider
- **Requires:** Cloud environment (AWS, GCP, Azure)
- **Best for:** Production applications

#### **☁️ LoadBalancer (Production Cloud)**
- **Use for:** Production external access with enterprise features
- **Access:** External IP address and DNS name from AWS
- **Features:** SSL termination, health checks, CloudWatch integration
- **Cost:** AWS charges apply (~$16/month + usage)
- **Best for:** Production applications requiring high availability
- **Requirements:** AWS EKS cluster or EC2 with proper IAM roles

#### **🔗 ExternalName**
- **Use for:** Integrating with external services
- **Access:** DNS alias to external service
- **No pods involved** - Just DNS mapping

---

## 🔍 Step 5: Service Discovery - How Apps Find Each Other

### **Understanding Service Discovery: The Phone Book of Kubernetes**

Service Discovery is like having a **smart phone book** that updates automatically:

```mermaid
graph TB
    subgraph "Traditional Phone Book Problems"
        OLD_BOOK[Old Phone Book - John: 555-1234, Mary: 555-5678, Bob: 555-9012]
        
        PROBLEMS[Problems: Numbers change, People move, Book gets outdated, Hard to update]
        
        OLD_BOOK -.-> PROBLEMS
    end
    
    subgraph "Kubernetes Service Discovery"
        DNS_SERVER[CoreDNS - Kubernetes DNS Server]
        
        subgraph "Automatic Updates"
            SERVICE1[frontend-service - 10.96.0.100]
            SERVICE2[api-service - 10.96.0.101]
            SERVICE3[database-service - 10.96.0.102]
        end
        
        APP[Your App] --> DNS_SERVER
        DNS_SERVER --> SERVICE1
        DNS_SERVER --> SERVICE2
        DNS_SERVER --> SERVICE3
    end
    
    style OLD_BOOK fill:#ffebee
    style PROBLEMS fill:#ffcdd2
    style DNS_SERVER fill:#e8f5e8
    style SERVICE1 fill:#c8e6c9
    style SERVICE2 fill:#c8e6c9
    style SERVICE3 fill:#c8e6c9
    style APP fill:#e1f5fe
```

**Service Discovery Benefits:**
- 🔄 **Automatic Updates** - DNS records update when services change
- 🎯 **Simple Names** - Use "api-service" instead of "10.96.0.101"
- 🌐 **Works Everywhere** - Same names work from any pod
- 🔍 **No Configuration** - Built into Kubernetes automatically

### **How DNS Resolution Works in Kubernetes**

```mermaid
graph TB
    subgraph "Your Application Pod"
        APP[Frontend App - Wants to call API]
        
        CODE[Application Code: fetch('http://api-service/users')]
    end
    
    subgraph "DNS Resolution Process"
        STEP1[1. DNS Query - What IP is 'api-service'?]
        STEP2[2. CoreDNS Lookup - Checks service registry]
        STEP3[3. IP Response - Returns 10.96.0.101]
        STEP4[4. HTTP Request - Connects to 10.96.0.101:80]
    end
    
    subgraph "Target Service"
        API_SERVICE[api-service - ClusterIP: 10.96.0.101]
        
        API_POD1[API Pod 1 - 10.42.0.5:8080]
        API_POD2[API Pod 2 - 10.42.0.6:8080]
        
        API_SERVICE --> API_POD1
        API_SERVICE --> API_POD2
    end
    
    APP --> CODE
    CODE --> STEP1
    STEP1 --> STEP2
    STEP2 --> STEP3
    STEP3 --> STEP4
    STEP4 --> API_SERVICE
    
    style APP fill:#e1f5fe
    style CODE fill:#fff3e0
    style STEP1 fill:#e8f5e8
    style STEP2 fill:#e8f5e8
    style STEP3 fill:#e8f5e8
    style STEP4 fill:#e8f5e8
    style API_SERVICE fill:#c8e6c9
    style API_POD1 fill:#e1f5fe
    style API_POD2 fill:#e1f5fe
```

**DNS Resolution Steps:**
1. **App Makes Request** - Code calls "api-service"
2. **DNS Query** - Pod asks "What IP is api-service?"
3. **CoreDNS Responds** - Returns service ClusterIP
4. **Connection Made** - App connects to service IP
5. **Service Routes** - Service forwards to healthy pod

### **DNS Name Formats: From Simple to Specific**

```mermaid
graph TB
    subgraph "DNS Name Hierarchy"
        subgraph "Simple Names Same Namespace"
            SIMPLE[api-service - Works within same namespace]
        end
        
        subgraph "Cross-Namespace Names"
            CROSS[api-service.production - Works across namespaces]
        end
        
        subgraph "Fully Qualified Names"
            FULL[api-service.production.svc.cluster.local - Works everywhere, always]
        end
    end
    
    subgraph "Namespace Examples"
        DEV_NS[development namespace - frontend-service, api-service, db-service]
        
        PROD_NS[production namespace - frontend-service, api-service, db-service]
        
        MONITOR_NS[monitoring namespace - prometheus-service, grafana-service]
    end
    
    SIMPLE --> DEV_NS
    CROSS --> PROD_NS
    FULL --> MONITOR_NS
    
    style SIMPLE fill:#c8e6c9
    style CROSS fill:#fff3e0
    style FULL fill:#e8f5e8
    style DEV_NS fill:#e1f5fe
    style PROD_NS fill:#f3e5f5
    style MONITOR_NS fill:#fce4ec
```

**When to Use Each Format:**
- **Simple Name** (`api-service`) - Same namespace, most common
- **Cross-Namespace** (`api-service.production`) - Different namespace
- **Fully Qualified** (`api-service.production.svc.cluster.local`) - Always works, debugging

### **Service Discovery Methods Comparison**

```mermaid
graph TB
    subgraph "Service Discovery Methods"
        subgraph "DNS Names Recommended"
            DNS_METHOD[DNS Resolution - Easy to use, Human readable, Automatic updates, Works everywhere]
        end
        
        subgraph "Environment Variables Legacy"
            ENV_METHOD[Environment Variables - API_SERVICE_HOST=10.96.0.101, API_SERVICE_PORT=80, Set at pod creation, Don't update automatically]
        end
        
        subgraph "Service Mesh Advanced"
            MESH_METHOD[Service Mesh - Istio, Linkerd, Advanced routing, Security policies, Observability]
        end
    end
    
    subgraph "Comparison"
        COMPARISON[Which to Use? DNS: 99% of cases, Env Vars: Legacy apps, Service Mesh: Complex apps]
    end
    
    DNS_METHOD --> COMPARISON
    ENV_METHOD --> COMPARISON
    MESH_METHOD --> COMPARISON
    
    style DNS_METHOD fill:#c8e6c9
    style ENV_METHOD fill:#fff3e0
    style MESH_METHOD fill:#e8f5e8
    style COMPARISON fill:#e1f5fe
```

### **Real-World Service Discovery Example**

```mermaid
graph TB
    subgraph "E-Commerce Application"
        subgraph "Frontend Tier"
            WEB[web-frontend - React/Angular App]
        end
        
        subgraph "API Tier"
            USER_API[user-service - User management]
            PRODUCT_API[product-service - Product catalog]
            ORDER_API[order-service - Order processing]
            PAYMENT_API[payment-service - Payment processing]
        end
        
        subgraph "Data Tier"
            USER_DB[user-database - PostgreSQL]
            PRODUCT_DB[product-database - MongoDB]
            ORDER_DB[order-database - PostgreSQL]
        end
        
        subgraph "External Services"
            REDIS[redis-cache - Session storage]
            ELASTIC[elasticsearch - Search engine]
        end
    end
    
    WEB -->|fetch('http://user-service/profile')| USER_API
    WEB -->|fetch('http://product-service/search')| PRODUCT_API
    WEB -->|fetch('http://order-service/history')| ORDER_API
    
    USER_API -->|user-database:5432| USER_DB
    PRODUCT_API -->|product-database:27017| PRODUCT_DB
    ORDER_API -->|order-database:5432| ORDER_DB
    
    USER_API -->|redis-cache:6379| REDIS
    PRODUCT_API -->|elasticsearch:9200| ELASTIC
    
    ORDER_API -->|payment-service/charge| PAYMENT_API
    
    style WEB fill:#e1f5fe
    style USER_API fill:#fff3e0
    style PRODUCT_API fill:#fff3e0
    style ORDER_API fill:#fff3e0
    style PAYMENT_API fill:#fff3e0
    style USER_DB fill:#f3e5f5
    style PRODUCT_DB fill:#f3e5f5
    style ORDER_DB fill:#f3e5f5
    style REDIS fill:#e8f5e8
    style ELASTIC fill:#e8f5e8
```

**Service Discovery in Action:**
- **Frontend** calls APIs by service name (user-service, product-service)
- **APIs** connect to databases by service name (user-database, product-database)
- **Services** find each other automatically (order-service → payment-service)
- **No hard-coded IPs** - everything uses DNS names

### **Exercise: Service Discovery in Action**

```mermaid
graph TB
    subgraph "Service Discovery Methods"
        A[DNS Names - my-service.default.svc.cluster.local]
        B[Short Names - my-service (same namespace)]
        C[Environment Variables - MY_SERVICE_SERVICE_HOST]
    end
    
    subgraph "Your App"
        APP[Application] --> A
        APP --> B
        APP --> C
    end
    
    style A fill:#e8f5e8
    style B fill:#c8e6c9
    style C fill:#fff3e0
    style APP fill:#e1f5fe
```

### **Exercise: Service Discovery in Action**
```bash
# Create multiple services
k create deployment frontend --image=varunmanik/httpd:blue --replicas=2
k create deployment api --image=varunmanik/httpd:green --replicas=2
k create deployment database --image=postgres:13 --replicas=1

# Expose them as services
k expose deployment frontend --port=80
k expose deployment api --port=80
k expose deployment database --port=5432

# Test service discovery
k run discovery-test --image=busybox --rm -it -- /bin/sh

# Inside the pod, try these commands:
# nslookup frontend
# nslookup api
# nslookup database
# wget -qO- http://frontend
# wget -qO- http://api
# exit

# Clean up
k delete deployment frontend api database
k delete service frontend api database
```

---

## 🛠️ Hands-On Exercise: Blue-Green Service Switching

This exercise shows how services can switch between different versions of your app:

```bash
# Step 1: Create blue and green versions
k run blue-app --image=varunmanik/httpd:blue --labels="app=web,version=blue"
k run green-app --image=varunmanik/httpd:green --labels="app=web,version=green"

# Step 2: Create a service pointing to blue version
cat <<EOF | k apply -f -
apiVersion: v1
kind: Service
metadata:
  name: web-switch
spec:
  type: NodePort
  ports:
  - port: 80
    targetPort: 80
    nodePort: 30090
  selector:
    app: web
    version: blue
EOF

# Step 3: Test blue version
curl http://localhost:30090
# You should see the blue-themed page

# Step 4: Switch to green version
k patch service web-switch -p '{"spec":{"selector":{"version":"green"}}}'

# Step 5: Test green version
curl http://localhost:30090
# Now you should see the green-themed page!

# Clean up
k delete service web-switch
k delete pod blue-app green-app
```

---

## 🧪 Building a Complete Multi-Service Application

Let's build a realistic 3-tier application with proper networking:

```mermaid
graph TB
    USER[User] --> FRONTEND[Frontend - Web UI]
    FRONTEND --> API[API - Business Logic]
    API --> DB[Database - Data Storage]
    
    subgraph "Services"
        FSVC[Frontend Service - NodePort 30080]
        ASVC[API Service - ClusterIP]
        DSVC[Database Service - ClusterIP]
    end
    
    USER --> FSVC
    FSVC --> FRONTEND
    FRONTEND --> ASVC
    ASVC --> API
    API --> DSVC
    DSVC --> DB
    
    style USER fill:#e3f2fd
    style FRONTEND fill:#e8f5e8
    style API fill:#fff3e0
    style DB fill:#f3e5f5
    style FSVC fill:#c8e6c9
    style ASVC fill:#c8e6c9
    style DSVC fill:#c8e6c9
```

### **Exercise: Complete Application with AWS LoadBalancer**
```bash
# 1. Create Database (Internal only)
k create deployment database --image=postgres:13
k set env deployment/database POSTGRES_DB=myapp POSTGRES_USER=user POSTGRES_PASSWORD=password
k expose deployment database --port=5432

# 2. Create API (Internal only)
k create deployment api --image=varunmanik/httpd:green --replicas=2
k expose deployment api --port=80

# 3. Create Frontend with AWS LoadBalancer (External access)
k create deployment frontend --image=varunmanik/httpd:blue --replicas=3

# Create LoadBalancer service for frontend
cat <<EOF | k apply -f -
apiVersion: v1
kind: Service
metadata:
  name: frontend-lb
  annotations:
    service.beta.kubernetes.io/aws-load-balancer-type: "alb"
    service.beta.kubernetes.io/aws-load-balancer-scheme: "internet-facing"
    service.beta.kubernetes.io/aws-load-balancer-target-type: "ip"
spec:
  type: LoadBalancer
  ports:
  - port: 80
    targetPort: 80
  selector:
    app: frontend
EOF

# 4. Wait for LoadBalancer to be ready (2-3 minutes)
echo "Waiting for LoadBalancer to be ready..."
k get services frontend-lb -w

# 5. Once EXTERNAL-IP appears, test the application
EXTERNAL_IP=$(k get service frontend-lb -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
echo "Application available at: http://$EXTERNAL_IP"

# 6. Test internal communication
k run test --image=busybox --rm -it -- /bin/sh
# Inside the test pod:
# wget -qO- http://api
# nslookup database
# exit

# 7. Check AWS Console
echo "Check AWS Console → EC2 → Load Balancers to see your ALB"

# 8. Clean up when done (important to avoid AWS charges!)
k delete service frontend-lb
k delete deployment database api frontend
k delete service database api
```

### **Exercise: Complete Application**
```bash
# 1. Create Database (Internal only)
k create deployment database --image=postgres:13
k set env deployment/database POSTGRES_DB=myapp POSTGRES_USER=user POSTGRES_PASSWORD=password
k expose deployment database --port=5432

# 2. Create API (Internal only)
k create deployment api --image=varunmanik/httpd:green --replicas=2
k expose deployment api --port=80

# 3. Create Frontend (External access)
k create deployment frontend --image=varunmanik/httpd:blue --replicas=3
k expose deployment frontend --port=80 --type=NodePort

# 4. Check everything is running
k get all

# 5. Test the application
k get services
# Access frontend via NodePort (e.g., http://localhost:30XXX)

# 6. Test internal communication
k run test --image=busybox --rm -it -- /bin/sh
# Inside the test pod:
# wget -qO- http://api
# nslookup database
# nslookup frontend
# exit

# 7. Clean up when done
k delete deployment database api frontend
k delete service database api frontend
```

---

## ⚖️ Load Balancing in Action

Services automatically load balance traffic across healthy pods:

### **Exercise: See Load Balancing Work**
```bash
# Create deployment with multiple replicas
k create deployment web --image=nginx --replicas=3

# Customize each pod to show different responses
k get pods -l app=web

# For each pod, add a custom response
for pod in $(k get pods -l app=web -o jsonpath='{.items[*].metadata.name}'); do
  k exec $pod -- /bin/sh -c "echo 'Hello from $pod' > /usr/share/nginx/html/index.html"
done

# Create service
k expose deployment web --port=80 --type=NodePort

# Test load balancing (run multiple times)
SERVICE_PORT=$(k get service web -o jsonpath='{.spec.ports[0].nodePort}')
echo "Testing load balancing on port $SERVICE_PORT:"

for i in {1..10}; do
  echo "Request $i:"
  curl -s http://localhost:$SERVICE_PORT
  echo ""
done

# You should see responses from different pods!

# Clean up
k delete deployment web
k delete service web
```

---

## 🔧 Advanced Service Configuration

### **Multi-Port Service Example**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: multi-port-service
spec:
  type: NodePort
  ports:
  - name: http
    port: 80
    targetPort: 8080
    nodePort: 30080
  - name: https
    port: 443
    targetPort: 8443
    nodePort: 30443
  selector:
    app: web-app
```

### **Service with Session Affinity**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: sticky-service
spec:
  type: ClusterIP
  sessionAffinity: ClientIP  # Stick to same pod
  ports:
  - port: 80
    targetPort: 80
  selector:
    app: web-app
```

---

## 🔍 Troubleshooting Services & Networking

### **Common Issues and Solutions**

#### **🚨 Service Not Accessible**
```bash
# 1. Check service exists
k get services

# 2. Check service has endpoints
k get endpoints <service-name>

# 3. If no endpoints, check pod labels
k get pods --show-labels
k describe service <service-name>

# 4. Verify selector matches pod labels
```

#### **🚨 DNS Not Working**
```bash
# Test DNS resolution
k run dns-test --image=busybox --rm -it -- nslookup <service-name>

# Check CoreDNS is running
k get pods -n kube-system -l k8s-app=kube-dns

# Check DNS configuration
k get configmap coredns -n kube-system -o yaml
```

#### **🚨 NodePort Not Accessible**
```bash
# Check service type and port
k get service <service-name>

# Verify port is in valid range (30000-32767)
# Check if port is already in use
netstat -tulpn | grep <port>

# Test from inside cluster first
k run test --image=busybox --rm -it -- wget -qO- http://<service-name>
```

#### **🚨 LoadBalancer Stuck in Pending**
```bash
# Check if you're running on AWS EKS or have proper IAM roles
k describe service <loadbalancer-service-name>

# Check events for error messages
k get events --sort-by=.metadata.creationTimestamp

# Verify AWS Load Balancer Controller is installed
k get pods -n kube-system | grep aws-load-balancer

# Check service annotations are correct
k describe service <service-name> | grep Annotations

# Common issues:
# - Not running on AWS EKS
# - Missing IAM roles for load balancer controller
# - Incorrect annotations
# - Insufficient AWS permissions
```

#### **🚨 LoadBalancer Created but Not Accessible**
```bash
# Check if LoadBalancer has external IP
k get service <service-name>

# Check AWS Security Groups
# Go to AWS Console → EC2 → Security Groups
# Ensure port 80/443 is open from 0.0.0.0/0

# Check target group health in AWS Console
# Go to EC2 → Target Groups → Check health status

# Verify pods are running and healthy
k get pods -l app=<app-name>
k describe pods -l app=<app-name>
```

#### **🚨 Load Balancing Not Working**
```bash
# Check if multiple pods are running and ready
k get pods -l app=<app-name>

# Check service endpoints
k get endpoints <service-name>

# Verify all pods are healthy
k describe pods -l app=<app-name>
```

---

## 📋 Essential Service Commands

### **Create Services**
```bash
# Create ClusterIP service (default)
k expose deployment <name> --port=80

# Create NodePort service
k expose deployment <name> --port=80 --type=NodePort

# Create service with specific NodePort
k expose deployment <name> --port=80 --type=NodePort --node-port=30080

# Create LoadBalancer service (AWS)
k expose deployment <name> --port=80 --type=LoadBalancer

# Create LoadBalancer with annotations
k annotate service <name> service.beta.kubernetes.io/aws-load-balancer-type=alb

# Apply from YAML file
k apply -f service.yaml
```

### **Manage Services**
```bash
# List services
k get services
k get svc                  # Short form

# Service details
k describe service <name>

# Check service endpoints
k get endpoints <service-name>

# Edit service
k edit service <name>

# Delete service
k delete service <name>
```

### **Test Services**
```bash
# Test internal service
k run test --image=busybox --rm -it -- wget -qO- http://<service-name>

# Test DNS resolution
k run test --image=busybox --rm -it -- nslookup <service-name>

# Port forward for local testing
k port-forward service/<service-name> 8080:80

# Check service connectivity from pod
k exec <pod-name> -- curl http://<service-name>
```

---

## 📝 Service YAML Templates

### **Basic ClusterIP Service**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-clusterip-service
  labels:
    app: my-app
spec:
  type: ClusterIP  # Default, can be omitted
  ports:
  - port: 80
    targetPort: 8080
    protocol: TCP
  selector:
    app: my-app
    tier: backend
```

### **NodePort Service with Custom Port**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-nodeport-service
  labels:
    app: my-app
spec:
  type: NodePort
  ports:
  - port: 80
    targetPort: 8080
    nodePort: 30080  # Optional, auto-assigned if not specified
    protocol: TCP
  selector:
    app: my-app
    tier: frontend
```

### **AWS LoadBalancer Service**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-loadbalancer-service
  annotations:
    service.beta.kubernetes.io/aws-load-balancer-type: "alb"
    service.beta.kubernetes.io/aws-load-balancer-scheme: "internet-facing"
    service.beta.kubernetes.io/aws-load-balancer-target-type: "ip"
    service.beta.kubernetes.io/aws-load-balancer-ssl-cert: "arn:aws:acm:region:account:certificate/cert-id"  # Optional SSL
spec:
  type: LoadBalancer
  ports:
  - port: 80
    targetPort: 8080
    protocol: TCP
  - port: 443      # Optional HTTPS
    targetPort: 8080
    protocol: TCP
  selector:
    app: my-app
    tier: frontend
```

### **Multi-Port Service**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-multi-port-service
spec:
  type: NodePort
  ports:
  - name: web
    port: 80
    targetPort: 8080
    nodePort: 30080
  - name: api
    port: 8080
    targetPort: 8080
    nodePort: 30081
  selector:
    app: my-app
```

---

## ✅ Knowledge Check

### **Quiz Questions**
1. **Which service type allows external access?**
   - ClusterIP ❌
   - NodePort ✅
   - Both ❌

2. **How do pods find services?**
   - IP addresses ❌
   - DNS names ✅
   - Port numbers ❌

3. **What happens if a service selector doesn't match any pods?**
   - Service fails ❌
   - No endpoints, traffic goes nowhere ✅
   - Kubernetes creates pods automatically ❌

4. **What port range is used for NodePort services?**
   - 1-1000 ❌
   - 30000-32767 ✅
   - 8000-9000 ❌

### **Practical Test**
```bash
# Can you build this complete application?
# 1. Database deployment (1 replica) with ClusterIP service
# 2. API deployment (2 replicas) with ClusterIP service  
# 3. Frontend deployment (3 replicas) with NodePort service
# 4. Test that frontend can reach API
# 5. Test that API can reach database
# 6. Test external access to frontend
# 7. Demonstrate load balancing across API pods
```

---

## ✅ Success Criteria

You're ready for the next section when you can:

- [ ] ✅ Write service YAML files from scratch
- [ ] ✅ Create ClusterIP services for internal communication
- [ ] ✅ Create NodePort services for external access
- [ ] ✅ Use service discovery to connect applications
- [ ] ✅ Understand and demonstrate load balancing
- [ ] ✅ Build complete multi-service applications
- [ ] ✅ Troubleshoot common networking issues
- [ ] ✅ Switch traffic between different app versions

---

## 🚀 Next Steps

**Fantastic!** 🎉 You now understand Kubernetes services and networking completely!

### **What You Accomplished:**
- ✅ **Service YAML Writing** - Created ClusterIP and NodePort services
- ✅ **Internal Communication** - Connected apps within the cluster
- ✅ **External Access** - Exposed apps to the outside world
- ✅ **Service Discovery** - Apps finding each other by name
- ✅ **Load Balancing** - Traffic distribution across multiple pods
- ✅ **Multi-Service Apps** - Built complete 3-tier applications
- ✅ **Blue-Green Switching** - Advanced deployment patterns
- ✅ **Troubleshooting** - Diagnosed and fixed networking issues

### **Ready for More?**
- **[→ Back to Pods](../03-pods/)** - Review pod concepts
- **[→ Next: Final Project](../06-project/)** - Build a complete application

---

## 📚 Quick Reference

### **Service Discovery DNS Names**
```bash
# Same namespace
<service-name>

# Different namespace  
<service-name>.<namespace>

# Full DNS name
<service-name>.<namespace>.svc.cluster.local
```

### **Port Mapping Explained**
- **port**: Service port (what clients connect to)
- **targetPort**: Pod port (where traffic actually goes)
- **nodePort**: External port on nodes (for NodePort services)

### **Common Service Patterns**
```bash
# Internal API service
k expose deployment api --port=80 --type=ClusterIP

# External web service
k expose deployment web --port=80 --type=NodePort

# Database service
k expose deployment db --port=5432 --type=ClusterIP
```

---

*Excellent work! Your applications can now communicate effectively and scale properly.* 🌐🚀
