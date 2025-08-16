# 🔄 Pipeline Deployment - Automated CI/CD

## 🎯 Objective
Automate the manual deployment process using Jenkins pipeline.

## 🔧 Setup

### **1. Update Server IP**
```bash
# Edit Jenkinsfile
vim Jenkinsfile

# Change this line to your server IP:
SERVER_IP = 'YOUR_SERVER_IP'  // Replace with your server IP
```

### **2. Jenkins Configuration**
- **Credentials:** tomcat-9 (admin/admin)
- **Maven Tool:** my_mvn
- **Repository:** https://github.com/manikcloud/cloud-devops-learning-path.git
- **Script Path:** Section-2-DevOps/Session-4_Jenkins/06_final_project/pipeline_deployment/Jenkinsfile

## 📊 Pipeline Stages
1. **Checkout** - Get code from repository
2. **Navigate** - Change to project directory  
3. **Clean** - Clean previous builds
4. **Build** - Compile source code
5. **Test** - Run unit tests
6. **Package** - Create WAR file
7. **Deploy** - Deploy to Tomcat

## ✅ Success Criteria
- All stages pass ✅
- Application deployed automatically
- Same result as manual deployment
