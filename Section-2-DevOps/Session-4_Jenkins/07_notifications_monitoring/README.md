# 📧 Module 07: Notifications & Monitoring

<div align="center">

![Notifications](https://img.shields.io/badge/Notifications-Email-red?style=for-the-badge&logo=gmail&logoColor=white)
![Monitoring](https://img.shields.io/badge/Monitoring-Alerts-orange?style=for-the-badge&logo=prometheus&logoColor=white)

**🎯 Build Notifications | 📊 Pipeline Monitoring | 📧 Email Integration**

</div>

---

## 📋 Module Overview

This module covers implementing comprehensive notification and monitoring systems for your Jenkins pipelines. You'll learn to set up email notifications, Slack integration, and build monitoring.

### 🎯 **Learning Objectives**
- ✅ Configure email notifications for build results
- ✅ Set up Slack and Teams integration
- ✅ Implement build monitoring and alerting
- ✅ Create custom notification templates
- ✅ Monitor pipeline performance and health

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
<td><strong>7.1</strong></td>
<td><strong><a href="./7.1_email_notification">Email Notifications</a></strong></td>
<td>Configure comprehensive email notification system for build results and pipeline status</td>
<td>Email Configuration, SMTP Setup, Notification Templates, Alert Management</td>
</tr>

</table>

---

## 📧 **Email Notification System**

### **Basic Email Configuration**
```groovy
pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
    }
    
    post {
        success {
            emailext (
                subject: "✅ Build Success: ${env.JOB_NAME} - ${env.BUILD_NUMBER}",
                body: """
                    <h2>Build Successful!</h2>
                    <p><strong>Job:</strong> ${env.JOB_NAME}</p>
                    <p><strong>Build Number:</strong> ${env.BUILD_NUMBER}</p>
                    <p><strong>Build URL:</strong> <a href="${env.BUILD_URL}">${env.BUILD_URL}</a></p>
                    <p><strong>Duration:</strong> ${currentBuild.durationString}</p>
                """,
                to: "${env.CHANGE_AUTHOR_EMAIL}",
                mimeType: 'text/html'
            )
        }
        
        failure {
            emailext (
                subject: "❌ Build Failed: ${env.JOB_NAME} - ${env.BUILD_NUMBER}",
                body: """
                    <h2>Build Failed!</h2>
                    <p><strong>Job:</strong> ${env.JOB_NAME}</p>
                    <p><strong>Build Number:</strong> ${env.BUILD_NUMBER}</p>
                    <p><strong>Build URL:</strong> <a href="${env.BUILD_URL}">${env.BUILD_URL}</a></p>
                    <p><strong>Console Output:</strong> <a href="${env.BUILD_URL}console">View Logs</a></p>
                """,
                to: "${env.CHANGE_AUTHOR_EMAIL}",
                mimeType: 'text/html'
            )
        }
    }
}
```

---

## ➡️ Next Steps

**Proceed to Module 08** - [Real-World Projects](../08_real_world_projects/README.md)

---

<div align="center">

### 🎯 **Stay Informed with Smart Notifications!**

**Start Configuring: [7.1 Email Notifications](./7.1_email_notification/README.md)**

</div>
