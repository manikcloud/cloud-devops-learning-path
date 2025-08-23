#!/bin/bash
yum update -y
yum install -y httpd

systemctl start httpd
systemctl enable httpd

# Create a simple website
cat > /var/www/html/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Terraform Web Stack</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .container {
            background: rgba(255,255,255,0.1);
            padding: 30px;
            border-radius: 15px;
            backdrop-filter: blur(10px);
        }
        h1 { color: #fff; text-align: center; }
        .info-box {
            background: rgba(255,255,255,0.2);
            padding: 15px;
            border-radius: 10px;
            margin: 20px 0;
        }
        .success { color: #4CAF50; font-weight: bold; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🎉 Terraform Web Stack Success!</h1>
        
        <div class="info-box">
            <h3>✅ What's Working:</h3>
            <ul>
                <li class="success">EC2 Instance Created</li>
                <li class="success">Security Group Configured</li>
                <li class="success">SSH Key Pair Set Up</li>
                <li class="success">Web Server Running</li>
                <li class="success">You're Viewing This Page!</li>
            </ul>
        </div>
        
        <div class="info-box">
            <h3>📊 Server Info:</h3>
            <p><strong>Instance ID:</strong> <span id="instance-id">Loading...</span></p>
            <p><strong>Availability Zone:</strong> <span id="az">Loading...</span></p>
            <p><strong>Instance Type:</strong> <span id="instance-type">Loading...</span></p>
        </div>
        
        <div class="info-box">
            <h3>🚀 Next Steps:</h3>
            <ul>
                <li>Try SSH: <code>ssh -i your-key.pem ec2-user@[PUBLIC-IP]</code></li>
                <li>Modify the website in <code>/var/www/html/index.html</code></li>
                <li>Add more resources to your Terraform configuration</li>
            </ul>
        </div>
        
        <p style="text-align: center; margin-top: 30px;">
            <em>🏗️ Built with Terraform | 🎯 Final Project 1</em>
        </p>
    </div>

    <script>
        // Fetch instance metadata
        fetch('http://169.254.169.254/latest/meta-data/instance-id')
            .then(response => response.text())
            .then(data => document.getElementById('instance-id').textContent = data)
            .catch(() => document.getElementById('instance-id').textContent = 'Not available');
            
        fetch('http://169.254.169.254/latest/meta-data/placement/availability-zone')
            .then(response => response.text())
            .then(data => document.getElementById('az').textContent = data)
            .catch(() => document.getElementById('az').textContent = 'Not available');
            
        fetch('http://169.254.169.254/latest/meta-data/instance-type')
            .then(response => response.text())
            .then(data => document.getElementById('instance-type').textContent = data)
            .catch(() => document.getElementById('instance-type').textContent = 'Not available');
    </script>
</body>
</html>
EOF
