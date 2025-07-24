# Section 1: EC2 Instance Launch Basics

## Learning Objectives
By the end of this section, you will understand:
- What is an EC2 instance and why we use it
- How to configure basic instance settings
- Security fundamentals for cloud instances
- Networking basics in AWS

---

## Questions to Answer:

### 1. Instance Name Tag
- **Q1.1:** What is a Name tag in AWS EC2?
- **Q1.2:** Why is it important to use descriptive names for your instances?
- **Q1.3:** What happens if you don't add a Name tag to your instance?

### 2. AMI (Amazon Machine Image)
- **Q2.1:** What is an AMI?
- **Q2.2:** What is the difference between these AMI types:
  - Amazon Linux 2
  - Ubuntu 20.04 LTS
  - Windows Server 2019
- **Q2.3:** Which AMI should you choose for a basic web server? Why?
- **Q2.4:** Can you create your own custom AMI? How?

### 3. Instance Type and Family
- **Q3.1:** What is an instance type?
- **Q3.2:** What is an instance family?
- **Q3.3:** Explain the difference between:
  - t2.micro vs t3.micro
  - t2.micro vs m5.large
  - t2.micro vs c5.large
- **Q3.4:** What are the main instance families and their use cases:
  - General Purpose (T, M series)
  - Compute Optimized (C series)
  - Memory Optimized (R, X series)
  - Storage Optimized (I, D series)
- **Q3.5:** Which instance type should you choose for this homework and why?

### 4. Key Pair Details
- **Q4.1:** What is a key pair in AWS?
- **Q4.2:** What are the two parts of a key pair?
- **Q4.3:** Why do we need key pairs for EC2 instances?
- **Q4.4:** What's the difference between RSA and ED25519 key types?
- **Q4.5:** What file formats are available for download (.pem vs .ppk)?
- **Q4.6:** What should you do if you lose your private key file?

### 5. Security Group Configuration
- **Q5.1:** What is a security group?
- **Q5.2:** What's the difference between security groups and NACLs?
- **Q5.3:** Configure security group with these rules and explain each:
  - Port 22 (SSH) - Source: 0.0.0.0/0
  - Port 80 (HTTP) - Source: 0.0.0.0/0
- **Q5.4:** Why is port 22 needed?
- **Q5.5:** Why is port 80 needed?
- **Q5.6:** Is opening port 22 to 0.0.0.0/0 a security best practice? What would be better?
- **Q5.7:** What does 0.0.0.0/0 mean in CIDR notation?

### 6. VPC, Subnet, and Availability Zone
- **Q6.1:** What is a VPC (Virtual Private Cloud)?
- **Q6.2:** What is a subnet?
- **Q6.3:** What is an Availability Zone?
- **Q6.4:** What's the difference between public and private subnets?
- **Q6.5:** Which type of subnet should you choose for a web server that needs internet access?
- **Q6.6:** What is an Internet Gateway and why do we need it?

---

## Practical Task:

### Launch Your First EC2 Instance

**Instance Specifications:**
- **Name:** MyFirstWebServer-[YourName]
- **AMI:** Amazon Linux 2
- **Instance Type:** t2.micro
- **Key Pair:** Create a new one called "homework-key-[yourname]"
- **Security Group:** Create new with name "web-server-sg"
  - Allow SSH (22) from anywhere (0.0.0.0/0)
  - Allow HTTP (80) from anywhere (0.0.0.0/0)
- **Subnet:** Use default public subnet
- **Storage:** Default 8 GB gp2

### Step-by-Step Checklist:
- [ ] Navigate to EC2 Console
- [ ] Click "Launch Instance"
- [ ] Set instance name
- [ ] Select Amazon Linux 2 AMI
- [ ] Choose t2.micro instance type
- [ ] Create new key pair and download .pem file
- [ ] Create new security group with required ports
- [ ] Select public subnet
- [ ] Review and launch instance
- [ ] Wait for instance to reach "Running" state

### Deliverables for Section 1:
1. **Screenshot:** EC2 Dashboard showing your running instance
2. **Screenshot:** Instance details page showing all configurations
3. **Screenshot:** Security group rules
4. **Document:** Answer all questions above
5. **File:** Save your .pem key file securely (don't share it!)

---

## Important Notes:
- ⚠️ **Security Warning:** Never share your private key (.pem) file
- 💰 **Cost Alert:** t2.micro is free tier eligible for 750 hours/month
- 🔒 **Best Practice:** Always use descriptive names and tags
- 📍 **Region:** Make note of which AWS region you're using

---

## Next Steps:
Once you complete this section, proceed to:
- **Section 2:** Access and Configuration
- **Section 3:** Web Server Setup

---

## Need Help?
- Check the solution folder for detailed answers
- Review AWS documentation for EC2
- Ask your instructor if you're stuck
