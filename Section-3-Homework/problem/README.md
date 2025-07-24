# Section 3 - Homework: AWS EC2 Basics

## Part 1: Launch an EC2 Instance

### Questions to Answer:

1. **Instance Name Tag**
   - What is a Name tag in AWS EC2?
   - Why is it important to use descriptive names for your instances?
   - Create an instance with the name tag: "MyFirstWebServer"

2. **AMI (Amazon Machine Image)**
   - What is an AMI?
   - What is the difference between different AMI types (Amazon Linux, Ubuntu, Windows)?
   - Which AMI should you choose for a basic web server? Why?

3. **Instance Type and Family**
   - What is an instance type?
   - What is an instance family?
   - Explain the difference between:
     - t2.micro vs t3.micro
     - t2.micro vs m5.large
     - General purpose vs Compute optimized families
   - Which instance type should you choose for this homework and why?

4. **Key Pair Details**
   - What is a key pair in AWS?
   - What are the two parts of a key pair?
   - Why do we need key pairs for EC2 instances?
   - How do you create a new key pair?
   - What file format does AWS provide for download?

5. **Security Group Configuration**
   - What is a security group?
   - Configure security group with these rules:
     - Port 22 (SSH) - Source: 0.0.0.0/0
     - Port 80 (HTTP) - Source: 0.0.0.0/0
   - Why is port 22 needed?
   - Why is port 80 needed?
   - Is opening port 22 to 0.0.0.0/0 a security best practice? What would be better?

6. **VPC, Subnet, and Availability Zone**
   - What is a VPC (Virtual Private Cloud)?
   - What is a subnet?
   - What is an Availability Zone?
   - What's the difference between public and private subnets?
   - Which type of subnet should you choose for a web server that needs internet access?

### Task:
Launch an EC2 instance with the following specifications:
- Name: MyFirstWebServer
- AMI: Amazon Linux 2
- Instance Type: t2.micro
- Key Pair: Create a new one called "my-homework-key"
- Security Group: Allow SSH (22) and HTTP (80) from anywhere
- Subnet: Use default public subnet

---

## Part 2: Access and Configure the Instance

### Questions to Answer:

7. **Accessing via AWS Console**
   - How do you connect to your EC2 instance using the AWS Console?
   - What is "EC2 Instance Connect"?
   - What are the prerequisites for using browser-based SSH?

8. **Command Line Basics**
   - What does `sudo -i` command do?
   - Why do we need sudo privileges?
   - What's the difference between `sudo` and `sudo -i`?

9. **System Updates**
   - What does `yum update` command do?
   - Why is it important to update your system?
   - What does the `-y` flag do in yum commands?

10. **Web Server Installation**
    - What is httpd?
    - How do you install httpd on Amazon Linux?
    - What does `systemctl start httpd` do?
    - What does `systemctl status httpd` do?
    - How do you enable httpd to start automatically on boot?

11. **Web Directory and File Editing**
    - What is `/var/www/html` directory used for?
    - What is vim editor?
    - How do you create a new file in vim?
    - How do you enter insert mode in vim?
    - How do you save and exit vim?
    - What are the basic vim commands you need to know?

12. **HTML and Public Access**
    - Create a simple HTML file with your name and a welcome message
    - How do you find your instance's public IP address?
    - How do you test if your web server is working?

### Tasks:

1. **Connect to your instance:**
   - Use AWS Console's "Connect" feature
   - Access your instance via browser-based SSH

2. **System Setup:**
   ```bash
   sudo -i
   yum update -y
   ```

3. **Install and Configure Web Server:**
   ```bash
   yum install httpd -y
   systemctl start httpd
   systemctl status httpd
   systemctl enable httpd
   ```

4. **Create Web Content:**
   ```bash
   cd /var/www/html
   vim index.html
   ```

5. **Sample HTML Content:**
   ```html
   <!DOCTYPE html>
   <html>
   <head>
       <title>My First AWS Web Server</title>
   </head>
   <body>
       <h1>Welcome to My Web Server!</h1>
       <p>Hello! My name is [Your Name]</p>
       <p>This is my first web server running on AWS EC2!</p>
       <p>Instance Details:</p>
       <ul>
           <li>AMI: Amazon Linux 2</li>
           <li>Instance Type: t2.micro</li>
           <li>Web Server: Apache HTTP Server</li>
       </ul>
   </body>
   </html>
   ```

6. **Test Your Web Server:**
   - Find your instance's public IP address
   - Open a web browser and navigate to: `http://YOUR_PUBLIC_IP`
   - Verify your webpage loads correctly

### Vim Editor Quick Reference:
- `i` - Enter insert mode
- `Esc` - Exit insert mode
- `:w` - Save file
- `:q` - Quit vim
- `:wq` - Save and quit
- `:q!` - Quit without saving

### Deliverables:
1. Screenshot of your running EC2 instance in AWS Console
2. Screenshot of your webpage displaying in a browser
3. Answer all the questions above in a separate document
4. Document any challenges you faced and how you solved them

---

## Bonus Questions:
1. How would you make your web server more secure?
2. What happens if you stop and start your instance? Does your public IP change?
3. How would you create a custom AMI from your configured instance?
4. What is the difference between stopping and terminating an instance?

---

**Note:** Remember to terminate your instance after completing the homework to avoid unnecessary charges!
