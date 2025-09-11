# 🔍 Simple Nagios Setup

## Quick Start
```bash
# Start Nagios
docker run -d -p 8080:80 --name nagios jasonrivers/nagios

# Access: http://localhost:8080/nagios
# Login: nagiosadmin/nagios
```

## Basic Configuration
```bash
# Check host status
define host {
    use                     linux-server
    host_name               localhost
    alias                   Local Server
    address                 127.0.0.1
}

# Check service
define service {
    use                     generic-service
    host_name               localhost
    service_description     HTTP
    check_command           check_http
}
```

## Common Checks
- HTTP service: `check_http`
- SSH service: `check_ssh`
- Disk space: `check_disk`
- Load average: `check_load`
