from flask import Flask
from prometheus_client import Counter, Histogram, generate_latest
import time
import random

app = Flask(__name__)

# Metrics
REQUEST_COUNT = Counter('requests_total', 'Total requests', ['method', 'endpoint'])
REQUEST_LATENCY = Histogram('request_duration_seconds', 'Request latency')

@app.route('/')
def hello():
    REQUEST_COUNT.labels(method='GET', endpoint='/').inc()
    with REQUEST_LATENCY.time():
        time.sleep(random.uniform(0.1, 0.5))  # Simulate work
        return 'Hello World! Visit /metrics for Prometheus metrics'

@app.route('/api/users')
def users():
    REQUEST_COUNT.labels(method='GET', endpoint='/api/users').inc()
    with REQUEST_LATENCY.time():
        time.sleep(random.uniform(0.2, 0.8))
        return {'users': ['alice', 'bob', 'charlie']}

@app.route('/metrics')
def metrics():
    return generate_latest()

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
