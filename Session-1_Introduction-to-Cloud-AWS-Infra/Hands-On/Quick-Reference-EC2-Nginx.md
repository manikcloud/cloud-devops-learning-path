# Quick Reference: EC2 + Nginx Website Deployment

## 🚀 Quick Launch Checklist

### Pre-Launch
- [ ] AWS account ready
- [ ] Region selected
- [ ] Key pair created/available

### EC2 Configuration
- [ ] **Name:** WebServer-Nginx-Project
- [ ] **AMI:** Amazon Linux 2
- [ ] **Instance Type:** t2.micro
- [ ] **Key Pair:** Selected/Created
- [ ] **Security Group:** HTTP (80), SSH (22), HTTPS (443)
- [ ] **User Data:** Script pasted
- [ ] **Storage:** 8GB gp2

### Post-Launch
- [ ] Instance status: Running
- [ ] Status checks: 2/2 passed
- [ ] Public IP assigned
- [ ] Website accessible via HTTP

## 🔧 Essential Commands

### SSH Connection
```bash
chmod 400 your-keypair.pem
ssh -i your-keypair.pem ec2-user@YOUR_PUBLIC_IP
```

### Nginx Commands
```bash
sudo systemctl status nginx    # Check status
sudo systemctl start nginx     # Start service
sudo systemctl stop nginx      # Stop service
sudo systemctl restart nginx   # Restart service
sudo nginx -t                  # Test configuration
```

### File Locations
- **Website files:** `/var/www/html/`
- **Nginx config:** `/etc/nginx/`
- **Logs:** `/var/log/nginx/`
- **User data logs:** `/var/log/cloud-init-output.log`

## 🌐 Access URLs
- **Main website:** `http://YOUR_PUBLIC_IP`
- **Status page:** `http://YOUR_PUBLIC_IP/status.html`

## 🛠️ Troubleshooting Quick Fixes

### Website not loading?
```bash
# Check if nginx is running
sudo systemctl status nginx

# Check security group allows port 80
# Check public IP is assigned
# Wait 2-3 minutes for user data completion
```

### SSH not working?
```bash
# Check security group allows port 22
# Verify key file permissions: chmod 400 keypair.pem
# Ensure using correct username: ec2-user
```

## 💰 Cost Alert
- **Free Tier:** 750 hours t2.micro per month
- **Always terminate** instances when done
- **Monitor usage** in billing dashboard

## 🧹 Quick Cleanup
1. EC2 → Instances → Select → Terminate
2. Security Groups → Delete custom SG
3. Key Pairs → Delete if not needed

---
*Quick Reference for Session 1 Hands-On Project*
