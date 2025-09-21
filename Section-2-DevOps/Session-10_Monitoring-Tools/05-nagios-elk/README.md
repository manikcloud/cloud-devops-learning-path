# 🔍 Nagios + ELK Stack Integration

Complete monitoring solution combining Nagios for infrastructure monitoring and ELK stack for log analysis.

## 🚀 Quick Start

```bash
# Start all services
docker-compose up -d

# Generate test traffic
./generate-traffic.sh
```

## 📊 Access Points

| Service | URL | Credentials |
|---------|-----|-------------|
| **Nagios** | http://localhost:8080 | admin/nagios |
| **Kibana** | http://localhost:5601 | - |
| **Nginx** | http://localhost:8081 | - |
| **Apache** | http://localhost:8082 | - |
| **Elasticsearch** | http://localhost:9200 | - |

## 🎯 What This Does

1. **Nagios** monitors nginx and apache containers
2. **ELK Stack** collects and visualizes web server logs
3. **Shared volumes** allow logstash to read logs
4. **Real-time dashboards** in Kibana

## 📈 Testing Steps

### 1. Generate Web Traffic
```bash
# Basic traffic
for i in {1..20}; do 
  curl http://localhost:8081
  curl http://localhost:8082
done

# Different request types
curl http://localhost:8081/
curl http://localhost:8081/404
curl http://localhost:8082/info
```

### 2. View in Kibana
1. Open http://localhost:5601
2. Go to **Management** → **Index Patterns**
3. Create pattern: `web-logs-*`
4. Go to **Discover** to see logs

### 3. Check Nagios Monitoring
1. Open http://localhost:8080
2. Login: admin/nagios
3. View **Services** for nginx/apache status

## 🔧 Troubleshooting

```bash
# Check container status
docker-compose ps

# View logs
docker-compose logs elasticsearch
docker-compose logs logstash
docker-compose logs kibana

# Check Elasticsearch health
curl http://localhost:9200/_cluster/health

# View indices
curl http://localhost:9200/_cat/indices?v
```

## 🛑 Stop Services

```bash
docker-compose down
```

## 📁 Architecture

```
┌─────────────┐    ┌─────────────┐
│   Nagios    │    │   Kibana    │
│  (Monitor)  │    │ (Visualize) │
└─────────────┘    └─────────────┘
       │                   │
       │            ┌─────────────┐
       │            │ Elasticsearch│
       │            │   (Store)   │
       │            └─────────────┘
       │                   │
┌─────────────┐    ┌─────────────┐
│nginx/apache │────│  Logstash   │
│ (Generate)  │    │ (Process)   │
└─────────────┘    └─────────────┘
```

Perfect for learning both infrastructure monitoring and log analysis!
