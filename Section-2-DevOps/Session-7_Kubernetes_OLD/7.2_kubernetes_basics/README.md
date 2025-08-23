# 📚 7.2 Kubernetes Basics & Pods

<div align="center">

![Kubernetes](https://img.shields.io/badge/Kubernetes-Fundamentals-blue?style=for-the-badge&logo=kubernetes&logoColor=white)
![Pods](https://img.shields.io/badge/Pods-Building%20Blocks-green?style=for-the-badge&logo=kubernetes&logoColor=white)

**🎯 Architecture Understanding | 🔧 kubectl Mastery | 📦 Pod Management**

</div>

---

## 📖 What is Kubernetes?

**Kubernetes (K8s)** is an open-source container orchestration platform that automates the deployment, scaling, and management of containerized applications.

### **Why Kubernetes?**
- **Container Orchestration** - Manage containers across multiple hosts
- **Auto-scaling** - Scale applications automatically
- **Self-healing** - Restart failed containers automatically
- **Service Discovery** - Built-in DNS and load balancing
- **Rolling Updates** - Deploy new versions with zero downtime

---

## 🏗️ Kubernetes Architecture

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        ☸️ KUBERNETES ARCHITECTURE                          │
└─────────────────────────────────────────────────────────────────────────────┘

                            👨‍💻 Developer
                                  │
                                  │ kubectl commands
                                  ▼
                    ┌─────────────────────────────────┐
                    │        🎛️ CONTROL PLANE        │
                    │                                 │
                    │  📡 API Server                  │
                    │  • REST API endpoint            │
                    │  • Gateway to cluster           │
                    │                                 │
                    │  🗄️ etcd                        │
                    │  • Cluster state storage        │
                    │  • Configuration data           │
                    │                                 │
                    │  📅 Scheduler                   │
                    │  • Pod placement decisions      │
                    │  • Resource optimization        │
                    │  • Constraint satisfaction      │
                    │                                 │
                    │  🎮 Controller Manager          │
                    │  • Desired state enforcement    │
                    │  • Node/Pod lifecycle           │
                    │  • Replication management       │
                    └─────────────────────────────────┘
                                  │
                          📡 Cluster Network
                                  │
                    ┌─────────────┼─────────────┐
                    │             │             │
                    ▼             ▼             ▼
            ┌─────────────┐ ┌─────────────┐ ┌─────────────┐
            │🖥️ Worker-1   │ │🖥️ Worker-2   │ │🖥️ Worker-3   │
            │             │ │             │ │             │
            │ kubelet     │ │ kubelet     │ │ kubelet     │
            │ • Pod mgmt  │ │ • Pod mgmt  │ │ • Pod mgmt  │
            │ • Node agent│ │ • Node agent│ │ • Node agent│
            │             │ │             │ │             │
            │ kube-proxy  │ │ kube-proxy  │ │ kube-proxy  │
            │ • Networking│ │ • Networking│ │ • Networking│
            │ • Load bal. │ │ • Load bal. │ │ • Load bal. │
            │             │ │             │ │             │
            │ Container   │ │ Container   │ │ Container   │
            │ Runtime     │ │ Runtime     │ │ Runtime     │
            │ (Docker)    │ │ (containerd)│ │ (CRI-O)     │
            │             │ │             │ │             │
            │ 📦 Pod-A    │ │ 📦 Pod-B    │ │ 📦 Pod-C    │
            │ 📦 Pod-D    │ │ 📦 Pod-E    │ │ 📦 Pod-F    │
            └─────────────┘ └─────────────┘ └─────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│  🎯 Result: Automated Container Management | 🔄 Self-healing | 📈 Scalable   │
└─────────────────────────────────────────────────────────────────────────────┘
```

### **Control Plane Components**

**🎛️ API Server (kube-apiserver)**
- Central management entity and communication hub
- Exposes Kubernetes API (REST interface)
- Handles authentication, authorization, and validation
- All cluster communication goes through the API server

**🗄️ etcd**
- Distributed, reliable key-value store
- Stores all cluster data and configuration
- Provides strong consistency and high availability
- Backup and restore point for cluster state

**📅 Scheduler (kube-scheduler)**
- Assigns pods to nodes based on resource requirements
- Considers constraints like node affinity, taints, and tolerations
- Optimizes resource utilization across the cluster
- Makes intelligent placement decisions

**🎮 Controller Manager (kube-controller-manager)**
- Runs controller processes that regulate cluster state
- Node Controller: Monitors node health
- Replication Controller: Maintains desired pod replicas
- Service Controller: Manages service endpoints

### **Worker Node Components**

**🤖 kubelet**
- Primary node agent that communicates with API server
- Manages pod lifecycle on the node
- Ensures containers are running and healthy
- Reports node and pod status back to control plane

**🌐 kube-proxy**
- Network proxy that maintains network rules
- Implements Kubernetes service abstraction
- Handles load balancing for services
- Manages iptables rules for traffic routing

**📦 Container Runtime**
- Software responsible for running containers
- Supports Docker, containerd, CRI-O
- Pulls container images and manages container lifecycle
- Provides container isolation and resource management

---

## 📋 Essential kubectl Commands

**Note**: All these commands work perfectly with k3s - no differences from other Kubernetes distributions!

### **Cluster Information**
```bash
# Check cluster info and endpoints
kubectl cluster-info

# Get cluster nodes with detailed information
kubectl get nodes -o wide

# Describe a specific node (shows capacity, conditions, etc.)
kubectl describe node $(kubectl get nodes -o jsonpath='{.items[0].metadata.name}')

# Check cluster and client version
kubectl version --short

# View cluster configuration
kubectl config view

# Get cluster events
kubectl get events --sort-by=.metadata.creationTimestamp
```

### **Pod Management**
```bash
# List all pods in current namespace
kubectl get pods

# List pods with more details (IP, node, etc.)
kubectl get pods -o wide

# List pods in all namespaces
kubectl get pods --all-namespaces

# Create a pod imperatively
kubectl run nginx --image=nginx --port=80

# Describe a pod (shows events, conditions, containers)
kubectl describe pod nginx

# Get pod logs
kubectl logs nginx

# Follow pod logs in real-time
kubectl logs -f nginx

# Execute commands in a pod
kubectl exec -it nginx -- /bin/bash

# Port forward to access pod locally
kubectl port-forward pod/nginx 8080:80

# Delete a pod
kubectl delete pod nginx
```

### **Deployment Management**
```bash
# Create deployment imperatively
kubectl create deployment nginx --image=nginx --replicas=3

# List deployments
kubectl get deployments

# Describe deployment (shows replica sets, conditions)
kubectl describe deployment nginx

# Scale deployment up or down
kubectl scale deployment nginx --replicas=5

# Update deployment image (rolling update)
kubectl set image deployment/nginx nginx=nginx:1.21

# Check rollout status
kubectl rollout status deployment/nginx

# View rollout history
kubectl rollout history deployment/nginx

# Rollback to previous version
kubectl rollout undo deployment/nginx

# Delete deployment
kubectl delete deployment nginx
```

### **Service Management**
```bash
# Expose deployment as ClusterIP service (internal only)
kubectl expose deployment nginx --port=80 --target-port=80

# Expose as NodePort service (external access)
kubectl expose deployment nginx --port=80 --type=NodePort

# List services
kubectl get services

# Describe service (shows endpoints, selectors)
kubectl describe service nginx

# Get service endpoints
kubectl get endpoints nginx

# Delete service
kubectl delete service nginx
```

### **Resource Management**
```bash
# Get all resources in current namespace
kubectl get all

# Get specific resource types
kubectl get pods,services,deployments

# Use labels to filter resources
kubectl get pods -l app=nginx

# Show resource usage (requires metrics server)
kubectl top nodes
kubectl top pods

# Explain resource definitions
kubectl explain pod
kubectl explain deployment.spec
```

---

## 🧪 Hands-On Exercises with Theory

### **Prerequisites**
```bash
# 1. Make sure you have a cluster running (from 7.1)
kubectl get nodes  # Should show your cluster nodes

# 2. Clone the repository
git clone https://github.com/manikcloud/cloud-devops-learning-path.git
cd cloud-devops-learning-path/Section-2-DevOps/Session-7_Kubernetes/7.2_kubernetes_basics

# 3. Verify cluster is working
kubectl cluster-info
```

---

## 📚 Progressive Learning Exercises

### **Exercise 1: Simple Pod Creation**

**🎯 Theory**: Understanding the most basic Kubernetes workload unit

**Concepts Covered**:
- **Pod Definition**: Smallest deployable unit in Kubernetes
- **Container Specification**: How to define container images and basic configuration
- **YAML Structure**: Basic Kubernetes manifest structure
- **Resource Lifecycle**: Creating, viewing, and deleting resources

**Real-world Application**: This represents the foundation of all Kubernetes workloads. Every application, whether simple or complex, starts with understanding how to create and manage individual pods.

```bash
# Deploy the simplest possible pod
kubectl apply -f 01-simple-pod.yaml

# Observe pod creation process
kubectl get pods -w  # Watch pods in real-time

# Check if it's running
kubectl get pods

# See detailed information about the pod
kubectl describe pod simple-pod

# Check what's happening inside
kubectl logs simple-pod

# Clean up
kubectl delete -f 01-simple-pod.yaml
```

**🔍 What's Happening**:
- Kubernetes scheduler finds a suitable node
- kubelet on the node pulls the container image
- Container runtime starts the container
- Pod gets an IP address from the cluster network

---

### **Exercise 2: Pod with Proper Naming and Metadata**

**🎯 Theory**: Kubernetes resource identification and metadata management

**Concepts Covered**:
- **Metadata**: Name, namespace, and resource identification
- **Naming Conventions**: Best practices for resource naming
- **Resource Organization**: How Kubernetes organizes and tracks resources
- **Cluster State**: How etcd stores resource definitions

**Real-world Application**: In production environments, proper naming and metadata are crucial for resource management, monitoring, and troubleshooting across teams.

```bash
# Deploy a properly named pod
kubectl apply -f 02-pod-with-name.yaml

# Check the pod with its proper name
kubectl get pods

# See how Kubernetes stores metadata
kubectl describe pod web-server

# View the full resource definition
kubectl get pod web-server -o yaml

# Clean up
kubectl delete -f 02-pod-with-name.yaml
```

**🔍 What's Happening**:
- Kubernetes validates the resource name
- Metadata is stored in etcd with proper indexing
- Resource becomes queryable by name across the cluster

---

### **Exercise 3: Labels and Selectors**

**🎯 Theory**: Kubernetes resource organization and selection mechanism

**Concepts Covered**:
- **Labels**: Key-value pairs for resource organization
- **Selectors**: How services find and connect to pods
- **Resource Grouping**: Organizing resources by environment, version, team
- **Service Discovery**: Foundation for how services locate pods

**Real-world Application**: Labels are the backbone of Kubernetes networking and organization. They enable services to find pods, deployments to manage replicas, and operators to organize resources.

```bash
# Deploy pod with labels for organization
kubectl apply -f 03-pod-with-labels.yaml

# Check labels on the pod
kubectl get pods --show-labels

# Filter pods by specific labels
kubectl get pods -l name=myapp
kubectl get pods -l environment=development

# Use multiple label selectors
kubectl get pods -l name=myapp,environment=development

# Port forward to test the application
kubectl port-forward pod/myapp 8080:80

# Test in another terminal
curl http://localhost:8080

# Clean up
kubectl delete -f 03-pod-with-labels.yaml
```

**🔍 What's Happening**:
- Labels are stored as metadata in etcd
- Label selectors use efficient indexing for fast queries
- This forms the basis for service-to-pod communication

---

### **Exercise 4: Blue-Green Deployment Pattern**

**🎯 Theory**: Zero-downtime deployment strategies and traffic management

**Concepts Covered**:
- **Deployment Strategies**: Blue-green vs rolling updates
- **Traffic Switching**: How to route traffic between versions
- **Version Management**: Managing multiple application versions
- **Risk Mitigation**: Reducing deployment risks

**Real-world Application**: Blue-green deployments are used in production for zero-downtime updates, especially for critical applications where any downtime is unacceptable.

```bash
# Deploy blue version (current production)
kubectl apply -f 04-blue-pod.yaml

# Deploy green version (new release)
kubectl apply -f 05-green-pod.yaml

# Check both versions are running
kubectl get pods -l application=web-app

# See different versions
kubectl get pods -l color=blue
kubectl get pods -l color=green

# Test both versions (simulate traffic switching)
kubectl port-forward pod/blue-app 8081:80 &
kubectl port-forward pod/green-app 8082:80 &

# Test both versions
curl http://localhost:8081  # Blue version
curl http://localhost:8082  # Green version

# In production, you'd switch service selectors here
# Clean up
kubectl delete -f 04-blue-pod.yaml
kubectl delete -f 05-green-pod.yaml
```

**🔍 What's Happening**:
- Two identical environments run simultaneously
- Traffic can be instantly switched between versions
- Rollback is immediate if issues are detected

---

### **Exercise 5: Database Pod with Environment Variables**

**🎯 Theory**: Configuration management and stateful applications

**Concepts Covered**:
- **Environment Variables**: Passing configuration to containers
- **Stateful Applications**: Running databases in Kubernetes
- **Configuration Management**: Separating config from code
- **Security Considerations**: Handling sensitive data

**Real-world Application**: Most applications require configuration and many need databases. This exercise shows how to configure applications and run stateful workloads.

```bash
# Deploy database pod with configuration
kubectl apply -f 06-database-pod.yaml

# Check the pod is running
kubectl get pods

# Examine the pod configuration
kubectl describe pod postgres-database

# Check environment variables are set correctly
kubectl exec postgres-database -- env | grep POSTGRES

# Connect to database (optional - requires psql client)
kubectl exec -it postgres-database -- psql -U postgres -d myapp

# Inside psql:
# \l  (list databases)
# \q  (quit)

# Clean up
kubectl delete -f 06-database-pod.yaml
```

**🔍 What's Happening**:
- Environment variables are injected into the container
- Database initializes with provided configuration
- Data is stored in the container (ephemeral in this example)

---

### **Exercise 6: Multi-Container Pod (Sidecar Pattern)**

**🎯 Theory**: Advanced pod patterns and container communication

**Concepts Covered**:
- **Sidecar Pattern**: Helper containers alongside main application
- **Shared Resources**: Containers sharing network and storage
- **Container Communication**: How containers in a pod interact
- **Design Patterns**: Common Kubernetes application patterns

**Real-world Application**: Sidecar patterns are used for logging, monitoring, proxies, and data synchronization. Examples include Istio service mesh, Fluentd logging, and monitoring agents.

```bash
# Deploy multi-container pod (main app + sidecar)
kubectl apply -f 07-multi-container-pod.yaml

# Check the pod shows 2/2 containers ready
kubectl get pods

# Check logs from the main container
kubectl logs multi-container -c nginx

# Check logs from the sidecar container
kubectl logs multi-container -c alpine-sidecar

# Execute into the main container
kubectl exec -it multi-container -c nginx -- /bin/bash

# Execute into the sidecar container
kubectl exec -it multi-container -c alpine-sidecar -- /bin/sh

# Clean up
kubectl delete -f 07-multi-container-pod.yaml
```

**🔍 What's Happening**:
- Both containers share the same network (localhost communication)
- Both containers can share volumes if configured
- Sidecar can monitor, log, or proxy for the main container

---

### **Exercise 7: Production-Ready Pod with Resource Limits**

**🎯 Theory**: Resource management and production best practices

**Concepts Covered**:
- **Resource Requests**: Guaranteed resources for containers
- **Resource Limits**: Maximum resources containers can use
- **Quality of Service**: How Kubernetes prioritizes pods
- **Production Readiness**: Essential configurations for production

**Real-world Application**: Resource management is critical in production to ensure application performance, prevent resource starvation, and enable proper cluster capacity planning.

```bash
# Deploy production-ready pod with resource limits
kubectl apply -f exercise-1-first-pod.yaml

# Check pod is running with resource constraints
kubectl get pods

# See detailed resource information
kubectl describe pod my-first-pod

# Check resource usage (if metrics server is available)
kubectl top pod my-first-pod

# Port forward to test
kubectl port-forward pod/my-first-pod 8080:80

# Test the application
curl http://localhost:8080

# Clean up
kubectl delete -f exercise-1-first-pod.yaml
```

**🔍 What's Happening**:
- Kubernetes scheduler considers resource requests for placement
- Container runtime enforces resource limits
- Pod gets QoS class based on resource configuration

---

### **Exercise 8: Troubleshooting and Debugging**

**🎯 Theory**: Kubernetes troubleshooting and debugging techniques

**Concepts Covered**:
- **Pod States**: Understanding pod lifecycle states
- **Error Diagnosis**: Reading pod events and logs
- **Debugging Techniques**: Common troubleshooting approaches
- **Resource Recovery**: Fixing and recovering from failures

**Real-world Application**: Troubleshooting is a critical skill for Kubernetes operators. Understanding how to diagnose and fix issues quickly is essential for maintaining production systems.

```bash
# Try to create a pod with wrong image (this will fail)
kubectl run broken-pod --image=nginx:wrong-tag

# Check what happened
kubectl get pods

# See the error details
kubectl describe pod broken-pod

# Check events for more information
kubectl get events --sort-by=.metadata.creationTimestamp

# Fix the issue by deleting and recreating
kubectl delete pod broken-pod
kubectl run fixed-pod --image=nginx:1.21

# Verify it works
kubectl get pods
kubectl logs fixed-pod

# Clean up
kubectl delete pod fixed-pod
```

**🔍 What's Happening**:
- Kubernetes attempts to pull the non-existent image
- kubelet reports the failure back to API server
- Pod enters ImagePullBackOff state
- Events provide detailed error information

---

## 📝 Key Concepts Summary

### **Pods**
- **Definition**: Smallest deployable unit containing one or more containers
- **Networking**: Each pod gets a unique IP address
- **Storage**: Containers in a pod can share volumes
- **Lifecycle**: Pods are ephemeral and can be created/destroyed

### **Labels and Selectors**
- **Labels**: Key-value pairs for organizing resources
- **Selectors**: Query mechanism for finding resources
- **Use Cases**: Service discovery, resource grouping, deployment targeting

### **Resource Management**
- **Requests**: Guaranteed resources (used for scheduling)
- **Limits**: Maximum resources (enforced by runtime)
- **QoS Classes**: Guaranteed, Burstable, BestEffort

### **Container Patterns**
- **Single Container**: One application per pod
- **Sidecar**: Helper container alongside main application
- **Ambassador**: Proxy container for external communication
- **Adapter**: Transform container output for consumption

---

## 🎯 Learning Outcomes

After completing this module, you will:

- ✅ **Understand Kubernetes architecture** and core components deeply
- ✅ **Master kubectl commands** for cluster management and troubleshooting
- ✅ **Create and manage pods** using declarative YAML configurations
- ✅ **Use labels and selectors** effectively for resource organization
- ✅ **Apply resource management** best practices for production workloads
- ✅ **Implement container patterns** like sidecar for real-world scenarios
- ✅ **Troubleshoot common issues** and debug Kubernetes problems
- ✅ **Understand pod lifecycle** and container management principles

---

## ✅ Success Criteria
- [ ] Can explain Kubernetes architecture components and their roles
- [ ] Successfully created pods using different configuration patterns
- [ ] Understand and can use labels for resource organization
- [ ] Can troubleshoot pod creation and runtime issues
- [ ] Implemented multi-container pod patterns
- [ ] Applied resource limits and requests appropriately
- [ ] Can use kubectl effectively for cluster management
- [ ] Understand the foundation for higher-level Kubernetes abstractions

## 🚀 Next Steps

Ready to work with Pods in detail? Continue with:

**[7.3 - Pods Management →](../7.3_pods_management/)**

Learn advanced pod management, networking, and real-world deployment patterns.

---

*Understand the architecture before building applications!* ☸️
