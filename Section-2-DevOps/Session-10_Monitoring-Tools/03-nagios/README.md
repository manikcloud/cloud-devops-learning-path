# 🔍 Simple Nagios Monitoring

Learn basic monitoring with Nagios - just ping and HTTP checks!

## 🚀 Quick Start
```bash
git clone https://github.com/manikcloud/cloud-devops-learning-path.git
cd cloud-devops-learning-path/Section-2-DevOps/Session-10_Monitoring-Tools/03-nagios
./start.sh
```

## 🌐 Access
- **Nagios**: http://localhost:8080/nagios
- **Login**: `admin` / `nagios123`
- **Nginx**: http://localhost:8081
- **Apache**: http://localhost:8082

## 📊 What's Monitored
- ✅ **Ping** - Can we reach the containers?
- ✅ **HTTP** - Are web services responding?
- ✅ **Real-time** - Live status updates

## 🛠️ Commands
```bash
./start.sh              # Start monitoring
docker-compose logs -f  # View logs
docker-compose down     # Stop all
```

## 🧪 Test It
```bash
# Break nginx - watch Nagios detect it
docker-compose stop nginx-target

# Fix nginx - watch it recover
docker-compose start nginx-target
```

## 🏗️ Simple Architecture
```
Nagios ──ping──▶ Nginx Container
       ──http──▶ Apache Container
```

**That's it!** No complex setup, just basic monitoring to learn the concepts.

---
*Run `./start.sh` and start monitoring!* 🚀
