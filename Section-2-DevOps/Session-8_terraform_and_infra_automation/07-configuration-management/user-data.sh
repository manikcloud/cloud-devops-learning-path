#!/bin/bash
yum update -y
yum install -y httpd

systemctl start httpd
systemctl enable httpd

cat > /var/www/html/index.html << EOF
<!DOCTYPE html>
<html>
<head>
    <title>${project_name}</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .header { color: #623CE4; }
        .info { background: #f0f0f0; padding: 20px; border-radius: 5px; }
    </style>
</head>
<body>
    <h1 class="header">🚀 ${project_name}</h1>
    <div class="info">
        <h3>Server Information</h3>
        <p><strong>Environment:</strong> ${environment}</p>
        <p><strong>Instance ID:</strong> $(curl -s http://169.254.169.254/latest/meta-data/instance-id)</p>
        <p><strong>Availability Zone:</strong> $(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)</p>
        <p><strong>Instance Type:</strong> $(curl -s http://169.254.169.254/latest/meta-data/instance-type)</p>
    </div>
    <p><em>This server was created with Terraform using variables and templates!</em></p>
</body>
</html>
EOF
