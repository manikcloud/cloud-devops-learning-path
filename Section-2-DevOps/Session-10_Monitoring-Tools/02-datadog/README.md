# 📈 Simple Application Monitoring

## Datadog Alternative (Free)
Since Datadog requires paid account, we'll use Prometheus + Grafana:

```bash
# Quick setup
cd ../04-complete-stack
./start.sh
```

## Monitor Your App
```python
# app.py - Simple Flask app with metrics
from flask import Flask
from prometheus_client import Counter, generate_latest

app = Flask(__name__)
request_count = Counter('requests_total', 'Total requests')

@app.route('/')
def hello():
    request_count.inc()
    return 'Hello World!'

@app.route('/metrics')
def metrics():
    return generate_latest()

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
```

## Docker Setup
```dockerfile
FROM python:3.9-slim
COPY app.py .
RUN pip install flask prometheus_client
CMD ["python", "app.py"]
```

## Key Metrics
- Request count
- Response time
- Error rate
- System resources
