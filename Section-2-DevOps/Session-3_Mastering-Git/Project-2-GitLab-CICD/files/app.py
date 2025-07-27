#!/usr/bin/env python3
"""
Simple Flask App for GitLab CI/CD Demo
Basic web application to demonstrate Git workflows and CI/CD concepts
"""

from flask import Flask, jsonify
import os
from datetime import datetime

app = Flask(__name__)

@app.route('/')
def home():
    """Main page"""
    return {
        'message': 'Hello from GitLab CI/CD Demo!',
        'version': '1.0.0',
        'environment': os.getenv('ENVIRONMENT', 'development'),
        'timestamp': datetime.now().isoformat()
    }

@app.route('/health')
def health():
    """Health check endpoint"""
    return jsonify({'status': 'healthy'}), 200

@app.route('/api/info')
def info():
    """App information"""
    return jsonify({
        'app': 'GitLab CI/CD Demo',
        'version': '1.0.0',
        'git_branch': os.getenv('CI_COMMIT_REF_NAME', 'local'),
        'commit': os.getenv('CI_COMMIT_SHA', 'local-commit')[:8]
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
