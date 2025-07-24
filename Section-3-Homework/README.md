# Section 3: AWS EC2 Homework - Complete Learning Path

## Overview
This homework is designed to give you hands-on experience with AWS EC2 fundamentals through a structured, step-by-step approach. You'll learn essential cloud computing skills by launching an instance, configuring it, and deploying your first web server.

## Learning Path Structure

The homework is divided into three progressive sections, each building upon the previous one:

### 📚 Section 1: EC2 Instance Launch Basics
**Focus:** Understanding AWS fundamentals and launching your first instance
- Instance configuration and naming
- AMI selection and differences
- Instance types and families
- Key pair creation and management
- Security group configuration
- VPC, subnets, and networking basics

**Time Estimate:** 45-60 minutes  
**Difficulty:** Beginner  
**Prerequisites:** AWS account with free tier access

### 🔧 Section 2: Instance Access and Configuration
**Focus:** Connecting to your instance and basic Linux administration
- SSH and EC2 Instance Connect
- Linux command line fundamentals
- User management and sudo privileges
- System updates and package management
- File operations and permissions

**Time Estimate:** 30-45 minutes  
**Difficulty:** Beginner to Intermediate  
**Prerequisites:** Completed Section 1

### 🌐 Section 3: Web Server Setup and HTML Creation
**Focus:** Installing Apache and creating your first website
- Apache HTTP Server installation
- Service management with systemctl
- Web directory structure
- vim editor usage
- HTML creation and styling
- Public web access testing

**Time Estimate:** 60-90 minutes  
**Difficulty:** Intermediate  
**Prerequisites:** Completed Sections 1 & 2

---

## Quick Start Guide

### For Students:
1. **Start with Section 1** - Launch your EC2 instance
2. **Complete each section sequentially** - Each builds on the previous
3. **Follow the problem statements** in each section's README
4. **Check solutions only after attempting** the problems yourself
5. **Take screenshots** as requested for your submissions
6. **Document your learning** - Keep notes of challenges and solutions

### For Instructors:
1. **Review the complete structure** before assigning
2. **Adjust time estimates** based on your students' experience level
3. **Use the solutions** as grading rubrics
4. **Encourage troubleshooting** - Common issues and solutions are provided
5. **Extend with advanced tasks** if students finish early

---

## Directory Structure

```
Section-3-Homework/
├── README.md (this file)
├── problem/
│   ├── section-1-instance-launch/
│   │   └── README.md (Questions and tasks for EC2 launch)
│   ├── section-2-access-configuration/
│   │   └── README.md (Questions and tasks for access/config)
│   └── section-3-web-server-setup/
│       └── README.md (Questions and tasks for web server)
└── solution/
    ├── section-1-instance-launch/
    │   └── README.md (Detailed solutions and explanations)
    ├── section-2-access-configuration/
    │   └── README.md (Step-by-step solutions)
    └── section-3-web-server-setup/
        └── README.md (Complete implementation guide)
```

---

## Learning Objectives

By completing this homework, students will be able to:

### Technical Skills:
- ✅ Launch and configure EC2 instances
- ✅ Manage AWS security groups and networking
- ✅ Use SSH for secure remote access
- ✅ Navigate Linux command line confidently
- ✅ Install and configure web servers
- ✅ Create and edit HTML content
- ✅ Troubleshoot common cloud infrastructure issues

### Conceptual Understanding:
- ✅ Cloud computing fundamentals
- ✅ Infrastructure as a Service (IaaS) concepts
- ✅ Network security in the cloud
- ✅ Linux system administration basics
- ✅ Web server architecture
- ✅ Public vs private networking

### Professional Skills:
- ✅ Following technical documentation
- ✅ Problem-solving and troubleshooting
- ✅ Security best practices awareness
- ✅ Cost management in cloud environments
- ✅ Documentation and communication

---

## Assessment Criteria

### Section 1 (25 points):
- **Instance Launch (15 points):** Correct configuration and successful launch
- **Security Setup (5 points):** Proper security group configuration
- **Documentation (5 points):** Complete answers to all questions

### Section 2 (25 points):
- **Access Methods (10 points):** Successful connection via EC2 Instance Connect
- **Linux Commands (10 points):** Demonstration of command line proficiency
- **System Management (5 points):** Proper use of sudo and system updates

### Section 3 (35 points):
- **Web Server Setup (15 points):** Apache installation and configuration
- **HTML Creation (10 points):** Functional webpage with proper styling
- **Public Access (10 points):** Website accessible via public IP

### Overall Assessment (15 points):
- **Troubleshooting (5 points):** Evidence of problem-solving skills
- **Best Practices (5 points):** Following security and operational guidelines
- **Cleanup (5 points):** Proper resource termination to avoid charges

**Total: 100 points**

---

## Prerequisites and Requirements

### AWS Account Requirements:
- Active AWS account with free tier eligibility
- Basic understanding of AWS Console navigation
- Credit card on file (for account verification - free tier resources used)

### Technical Requirements:
- Web browser with internet access
- Basic computer literacy
- No prior Linux or cloud experience required

### Recommended Preparation:
- Review AWS free tier limits
- Familiarize yourself with AWS Console layout
- Have a text editor ready for documentation

---

## Getting Started

### Choose Your Path:

**🎯 Ready to Start?**
- Go to `problem/section-1-instance-launch/README.md` to begin

**📖 Need Solutions?**
- Check `solution/section-1-instance-launch/README.md` for detailed answers

**🔍 Want Overview?**
- Continue reading this document for complete information

---

## Important Warnings and Best Practices

### 💰 Cost Management:
- **Use t2.micro instances only** (free tier eligible)
- **Terminate instances when done** - don't just stop them
- **Monitor your AWS billing dashboard** regularly
- **Set up billing alerts** for peace of mind

### 🔒 Security Reminders:
- **Never share your private key (.pem) files**
- **Don't commit keys to version control**
- **Use strong, unique passwords for AWS account**
- **Enable MFA on your AWS account**
- **Restrict SSH access to your IP when possible**

### 📋 Submission Guidelines:
- **Take screenshots as requested** in each section
- **Answer all questions completely** - partial answers receive partial credit
- **Document your process** - show your work
- **Include troubleshooting notes** - what problems did you encounter?
- **Submit before the deadline** - late submissions may be penalized

---

## Support and Resources

### Getting Help:
1. **Check the solutions** after attempting problems
2. **Review troubleshooting sections** in each solution guide
3. **Consult AWS documentation** for additional details
4. **Ask instructors** for clarification on concepts
5. **Collaborate with peers** on understanding (not copying)

### Additional Resources:
- [AWS EC2 User Guide](https://docs.aws.amazon.com/ec2/)
- [AWS Free Tier Details](https://aws.amazon.com/free/)
- [Linux Command Line Basics](https://ubuntu.com/tutorials/command-line-for-beginners)
- [HTML Tutorial](https://www.w3schools.com/html/)
- [Apache HTTP Server Documentation](https://httpd.apache.org/docs/)

---

## What's Next?

After completing this homework, you'll be ready for:

### Immediate Next Steps:
- **Load Balancers:** Distribute traffic across multiple instances
- **Auto Scaling:** Automatically adjust capacity based on demand
- **RDS Databases:** Add database functionality to your web applications
- **CloudFormation:** Infrastructure as Code for repeatable deployments

### Advanced Topics:
- **Container Services:** Docker and Amazon ECS
- **Serverless Computing:** AWS Lambda functions
- **CI/CD Pipelines:** Automated deployment workflows
- **Monitoring and Logging:** CloudWatch and application insights

### Career Paths:
- **Cloud Solutions Architect**
- **DevOps Engineer**
- **Site Reliability Engineer (SRE)**
- **Cloud Security Specialist**
- **Full-Stack Developer with Cloud Skills**

---

## Conclusion

This homework provides a solid foundation in AWS EC2 and cloud computing fundamentals. By working through each section methodically, you'll gain practical skills that are directly applicable to real-world cloud infrastructure projects.

Remember: **The goal is learning, not just completion.** Take time to understand each concept, experiment with variations, and don't hesitate to ask questions.

**Good luck, and welcome to the world of cloud computing!** 🚀

---

**Note:** Remember to terminate your instance after completing the homework to avoid unnecessary charges!

*Last Updated: July 2024*  
*Version: 1.0*  
*Estimated Completion Time: 4-6 hours total*
