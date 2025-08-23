#!/bin/bash
yum update -y
yum install -y httpd

systemctl start httpd
systemctl enable httpd

# Create the full-stack application
cat > /var/www/html/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Terraform Full-Stack App</title>
    <link rel="stylesheet" href="https://${s3_bucket}.s3.us-west-2.amazonaws.com/styles.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🚀 Terraform Full-Stack Application</h1>
            <p>Complete infrastructure with ALB + S3 + EC2</p>
        </div>
        
        <div class="grid">
            <div class="card">
                <h3>✅ Infrastructure Components</h3>
                <ul>
                    <li class="success">Application Load Balancer</li>
                    <li class="success">S3 Bucket for Static Assets</li>
                    <li class="success">EC2 Instance</li>
                    <li class="success">Security Groups</li>
                    <li class="success">Target Groups</li>
                </ul>
            </div>
            
            <div class="card">
                <h3>📊 Server Information</h3>
                <p><strong>Instance ID:</strong> <span id="instance-id">Loading...</span></p>
                <p><strong>Availability Zone:</strong> <span id="az">Loading...</span></p>
                <p><strong>Instance Type:</strong> <span id="instance-type">Loading...</span></p>
                <p><strong>S3 Bucket:</strong> ${s3_bucket}</p>
            </div>
            
            <div class="card">
                <h3>🎯 What You've Mastered</h3>
                <ul>
                    <li>Infrastructure as Code</li>
                    <li>Resource Dependencies</li>
                    <li>Load Balancer Configuration</li>
                    <li>S3 Integration</li>
                    <li>Security Group Management</li>
                </ul>
            </div>
            
            <div class="card">
                <h3>🏆 Congratulations!</h3>
                <p>You've successfully completed the 90-minute Terraform course!</p>
                <p><strong>Skills Acquired:</strong></p>
                <ul>
                    <li>Terraform fundamentals</li>
                    <li>AWS resource management</li>
                    <li>Infrastructure automation</li>
                    <li>Best practices</li>
                </ul>
            </div>
        </div>
        
        <div style="text-align: center; margin-top: 30px; padding: 20px; background: rgba(255,255,255,0.2); border-radius: 10px;">
            <h3>🎓 Course Complete!</h3>
            <p>You're now ready to build production infrastructure with Terraform!</p>
            <p><em>CSS loaded from S3 | Served through ALB | Running on EC2</em></p>
        </div>
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
