# 🔍 Nagios + ELK Stack Integration

## Quick Start

```bash
# Start Nagios + ELK stack
./start-with-elk.sh

# Or manually
docker-compose -f docker-compose-with-elk.yml up -d
```

## Access Points

- **Nagios**: http://localhost:8080 (admin/nagios)
- **Kibana**: http://localhost:5601
- **Nginx**: http://localhost:8081
- **Apache**: http://localhost:8082

## What This Does

1. **Nagios** monitors nginx and apache containers
2. **ELK Stack** collects and visualizes their logs
3. **Shared volumes** allow logstash to read web server logs
4. **Kibana** displays logs in real-time dashboards

## Generate Traffic & Logs

```bash
# Generate web traffic
for i in {1..20}; do
  curl http://localhost:8081
  curl http://localhost:8082
  sleep 1
done
```

## View Logs in Kibana

1. Open http://localhost:5601
2. Go to "Discover"
3. Create index pattern: `web-logs-*`
4. View real-time logs from nginx and apache

## Stop Services

```bash
docker-compose -f docker-compose-with-elk.yml down
```
