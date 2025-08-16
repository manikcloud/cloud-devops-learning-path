# 📱 Manual Deployment - Address Book Application

## 🎯 Objective
Deploy the Address Book application manually to understand the deployment process before automating it.

## 🚀 Steps

### **1. Build Application**
```bash
# Clean and build
mvn clean install

# Verify WAR file created
ls -la target/addressbook.war
```

### **2. Deploy to Tomcat**
```bash
# Copy WAR to Tomcat webapps
sudo cp target/addressbook.war /var/lib/tomcat9/webapps/

# Wait for deployment (auto-extract)
sleep 10

# Check deployment
ls -la /var/lib/tomcat9/webapps/addressbook/
```

### **3. Access Application**
```
URL: http://YOUR_SERVER_IP:8090/addressbook/
```

### **4. Test Application**
- Add new contacts
- Edit existing contacts
- Search contacts
- Delete contacts

## ✅ Success Criteria
- Application loads without errors
- All CRUD operations work
- Ready for pipeline automation
