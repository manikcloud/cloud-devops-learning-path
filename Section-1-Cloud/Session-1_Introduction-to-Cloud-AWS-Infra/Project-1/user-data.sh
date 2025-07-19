#!/bin/bash

# Update the system
yum update -y

# Install Nginx
amazon-linux-extras install nginx1 -y

# Start and enable Nginx
systemctl start nginx
systemctl enable nginx

# Create backup of default nginx config
cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.backup

# Create our custom website
cat > /var/www/html/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Cloud Journey - Varun Kumar</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            min-height: 100vh;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 50px 20px;
            text-align: center;
        }
        .header {
            margin-bottom: 50px;
        }
        .header h1 {
            font-size: 3em;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        .header p {
            font-size: 1.2em;
            opacity: 0.9;
        }
        .content {
            background: rgba(255,255,255,0.1);
            padding: 30px;
            border-radius: 15px;
            backdrop-filter: blur(10px);
            margin-bottom: 30px;
        }
        .skills {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }
        .skill-card {
            background: rgba(255,255,255,0.2);
            padding: 20px;
            border-radius: 10px;
            transition: transform 0.3s ease;
        }
        .skill-card:hover {
            transform: translateY(-5px);
        }
        .footer {
            margin-top: 50px;
            opacity: 0.8;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🚀 Welcome to My Cloud Journey</h1>
            <p>Hosted on AWS EC2 with Nginx</p>
        </div>
        
        <div class="content">
            <h2>About This Project</h2>
            <p>This website is running on Amazon EC2 instance with Nginx web server, deployed using automated User Data script. This demonstrates Infrastructure as Code principles and cloud automation.</p>
            
            <div class="skills">
                <div class="skill-card">
                    <h3>☁️ AWS EC2</h3>
                    <p>Elastic Compute Cloud for scalable computing</p>
                </div>
                <div class="skill-card">
                    <h3>🌐 Nginx</h3>
                    <p>High-performance web server and reverse proxy</p>
                </div>
                <div class="skill-card">
                    <h3>🔧 User Data</h3>
                    <p>Automated instance configuration on launch</p>
                </div>
                <div class="skill-card">
                    <h3>🔒 Security Groups</h3>
                    <p>Virtual firewall for EC2 instances</p>
                </div>
            </div>
        </div>
        
        <div class="content">
            <h2>Technical Details</h2>
            <p><strong>Instance Type:</strong> t2.micro (Free Tier)</p>
            <p><strong>Operating System:</strong> Amazon Linux 2</p>
            <p><strong>Web Server:</strong> Nginx</p>
            <p><strong>Deployment Method:</strong> EC2 User Data</p>
            <p><strong>Security:</strong> HTTP/HTTPS enabled via Security Groups</p>
        </div>
        
        <div class="footer">
            <p>🎓 Cloud & DevOps Training Project</p>
            <p>Created by <strong>Varun Kumar</strong></p>
            <p>Powered by Amazon Web Services</p>
        </div>
    </div>
</body>
</html>
EOF

# Set proper permissions
chown nginx:nginx /var/www/html/index.html
chmod 644 /var/www/html/index.html

# Configure Nginx to serve from /var/www/html
cat > /etc/nginx/conf.d/default.conf << 'EOF'
server {
    listen 80;
    server_name _;
    root /var/www/html;
    index index.html index.htm;

    location / {
        try_files $uri $uri/ =404;
    }

    # Security headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-XSS-Protection "1; mode=block" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header Referrer-Policy "no-referrer-when-downgrade" always;
    add_header Content-Security-Policy "default-src 'self' http: https: data: blob: 'unsafe-inline'" always;
}
EOF

# Test nginx configuration
nginx -t

# Restart Nginx to apply changes
systemctl restart nginx

# Create a simple status page
cat > /var/www/html/status.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Server Status</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; background: #f4f4f4; }
        .status { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .success { color: #28a745; }
        .info { color: #17a2b8; }
    </style>
</head>
<body>
    <div class="status">
        <h1 class="success">✅ Server Status: Online</h1>
        <p class="info">Nginx is running successfully!</p>
        <p><strong>Server Time:</strong> $(date)</p>
        <p><strong>Uptime:</strong> $(uptime)</p>
        <p><a href="/">← Back to Main Site</a></p>
    </div>
</body>
</html>
EOF

# Log the completion
echo "$(date): Web server setup completed successfully" >> /var/log/user-data.log
