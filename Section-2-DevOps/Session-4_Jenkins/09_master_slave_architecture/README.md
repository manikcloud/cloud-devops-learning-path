# 🏗️ Module 09: Master-Slave Architecture

<div align="center">

![Architecture](https://img.shields.io/badge/Architecture-Master%20Slave-blue?style=for-the-badge&logo=jenkins&logoColor=white)
![Scalability](https://img.shields.io/badge/Scalability-Distributed-green?style=for-the-badge&logo=kubernetes&logoColor=white)

**🎯 Distributed Builds | 🔧 Scalable Architecture | 📊 Load Distribution**

</div>

---

## 📋 Module Overview

This module covers setting up and managing Jenkins Master-Slave architecture for scalable, distributed build environments. You'll learn to configure multiple build agents and optimize build distribution.

<div align="center">

![Jenkins Architecture](../images/jenkins-architecture.svg)

</div>

### 🎯 **Learning Objectives**
- ✅ Configure Jenkins Master-Slave architecture
- ✅ Set up multiple build agents (slaves)
- ✅ Implement distributed build strategies
- ✅ Optimize build performance and resource utilization
- ✅ Manage agent labels and build distribution

---

## 🛤️ Module Structure

<table>
<tr>
<th width="10%">Project</th>
<th width="30%">Name</th>
<th width="40%">Description</th>
<th width="20%">Skills</th>
</tr>

<tr>
<td><strong>9.1</strong></td>
<td><strong><a href="./9.1_master_slave">Master-Slave Setup</a></strong></td>
<td>Configure Jenkins Master-Slave architecture with multiple build agents for distributed builds</td>
<td>Distributed Architecture, Agent Configuration, Build Distribution, Performance Optimization</td>
</tr>

</table>

---

## 🏗️ **Architecture Benefits**

### **Scalability**
- 🚀 **Parallel Builds** - Multiple builds running simultaneously
- 📈 **Resource Scaling** - Add agents based on demand
- 🎯 **Specialized Agents** - Different environments for different projects
- 💪 **High Availability** - Fault tolerance through distribution

### **Performance**
- ⚡ **Faster Builds** - Distributed processing power
- 🔄 **Load Distribution** - Balanced workload across agents
- 📊 **Resource Optimization** - Efficient hardware utilization
- 🎯 **Environment Isolation** - Separate build environments

---

## 🔧 **Agent Configuration**

### **SSH Agent Setup**
```groovy
// Pipeline with specific agent
pipeline {
    agent { label 'linux-maven' }
    
    stages {
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
    }
}
```

### **Multi-Agent Pipeline**
```groovy
pipeline {
    agent none
    
    stages {
        stage('Build on Linux') {
            agent { label 'linux' }
            steps {
                sh 'make build'
            }
        }
        
        stage('Test on Windows') {
            agent { label 'windows' }
            steps {
                bat 'run-tests.bat'
            }
        }
        
        stage('Deploy') {
            agent { label 'deployment' }
            steps {
                sh 'deploy.sh'
            }
        }
    }
}
```

---

## ➡️ Next Steps

**Proceed to Module 10** - [Final Project](../10_final_project/README.md)

---

<div align="center">

### 🎯 **Scale Your Jenkins Infrastructure!**

**Start Scaling: [9.1 Master-Slave Setup](./9.1_master_slave/README.md)**

</div>
