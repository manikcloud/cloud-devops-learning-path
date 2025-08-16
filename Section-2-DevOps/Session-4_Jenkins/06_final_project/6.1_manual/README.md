# 📱 6.1 Manual Deployment - Address Book Application

## 🎯 Objective
Deploy the Address Book application manually to understand the deployment process before automating it.

## 📋 Prerequisites
- ✅ Infrastructure setup completed (from main README)
- ✅ Tomcat 9 running on port 8090
- ✅ Maven installed and configured
- ✅ Java 11+ installed

---

## 🚀 Manual Deployment Steps

### **Step 1: Clone Repository**
```bash
# Clone the repository
git clone https://github.com/manikcloud/cloud-devops-learning-path.git

# Navigate to manual deployment directory
cd cloud-devops-learning-path/Section-2-DevOps/Session-4_Jenkins/06_final_project/6.1_manual
```

### **Step 2: Build Application**
```bash
# Clean and build
mvn clean install

# Verify WAR file created
ls -la target/addressbook.war
```

### **Step 3: Deploy to Tomcat**


```bash
# Copy WAR to Tomcat webapps
# Ubuntu:
sudo cp target/addressbook.war /var/lib/tomcat9/webapps/
# Amazon Linux:
sudo cp target/addressbook.war /opt/tomcat/latest/webapps/

# Check deployment
# Ubuntu:
ls -la /var/lib/tomcat9/webapps/
# Amazon Linux:
ls -la /opt/tomcat/latest/webapps/
```

### **Step 4: Wait for Auto-Deployment**
```bash
# Wait for Tomcat to extract WAR file (30 seconds)
sleep 30

# Check if application directory is created
# Ubuntu:
ls -la /var/lib/tomcat9/webapps/addressbook/
# Amazon Linux:
ls -la /opt/tomcat/latest/webapps/addressbook/

```

### **Step 5: Access Application**
```bash
# Replace YOUR_SERVER_IP with your actual server IP
# Example: http://3.82.130.168:8090/addressbook/
http://YOUR_SERVER_IP:8090/addressbook/
```

---

## 🧪 Test Application

### **✅ Functionality Tests**
1. **Add Contact** - Click "Add Contact" and fill details
2. **Edit Contact** - Click on existing contact to edit
3. **Search Contact** - Use search box to filter contacts
4. **Delete Contact** - Select contact and delete

### **✅ Verification Steps**
```bash
# Check application logs (Ubuntu)
sudo tail -f /var/log/tomcat9/catalina.out

# Check application logs (Amazon Linux)
sudo tail -f /opt/tomcat/latest/logs/catalina.out

# Test application response
curl -I http://YOUR_SERVER_IP:8090/addressbook/
```

---

## 📊 Expected Results

### **✅ Success Indicators**
- WAR file builds successfully
- Application deploys without errors
- Web interface loads properly
- All CRUD operations work
- No errors in Tomcat logs

### **📱 Application Screenshot**
![Address Book Application](./addressbook_screenshot.png)

---

## 🛠️ Troubleshooting

### **❌ Common Issues**

| Issue | Cause | Solution |
|-------|-------|----------|
| **Build fails** | Missing dependencies | Check internet connection, run `mvn clean install -U` |
| **WAR not created** | Compilation errors | Check `mvn compile` output for errors |
| **Deployment fails** | Permission issues | Use `sudo` for copying WAR file |
| **App not accessible** | Firewall/Security Group | Allow port 8090 in firewall |
| **404 Error** | WAR not extracted | Wait longer, check Tomcat logs |

---

## 🎯 Learning Outcomes

After completing manual deployment:

### **✅ Understanding Gained**
- Maven build lifecycle (clean, compile, test, package)
- WAR file creation and structure
- Tomcat deployment process
- Application testing procedures

### **✅ Skills Developed**
- Command line build tools
- Manual deployment process
- Troubleshooting deployment issues
- Application verification

---

## 🚀 Next Steps

1. **✅ Manual deployment completed**
2. **📝 Document any issues encountered**
3. **🔄 Ready for automation** → Go to [../6.2_pipeline/](../6.2_pipeline/)
4. **🎯 Compare manual vs automated process**

---

<div align="center">

**🎉 Manual deployment successful? Time to automate it!**

**Next:** [6.2 Pipeline Automation](../6.2_pipeline/)

</div>
