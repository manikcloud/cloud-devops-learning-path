# Simple Nagios Monitoring Setup

## Quick Start
```bash
git clone <your-repo-url>
cd nagios-simple
docker-compose up -d
```

## Access
- **Nagios Web UI**: http://localhost:8080/nagios
- **Login**: admin / nagios123

## What's Monitored
- ✅ Nginx container (ping, HTTP)
- ✅ Apache container (ping, HTTP)
- ✅ Host system (ping, disk, load)

## Commands
```bash
# Start all services
docker-compose up -d

# View logs
docker-compose logs nagios

# Stop all services
docker-compose down

# Restart Nagios only
docker-compose restart nagios
```

## Architecture
```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   Nagios    │───▶│   Nginx     │    │   Apache    │
│  (Monitor)  │    │ (Port 8081) │    │ (Port 8082) │
└─────────────┘    └─────────────┘    └─────────────┘
```
