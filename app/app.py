from flask import Flask, jsonify
import os
import socket

app = Flask(__name__)

@app.route('/')
def home():
    return f"Hello from {socket.gethostname()} running inside Kubernetes!"

@app.route('/api/info')
def info():
    return jsonify({"app": os.getenv("APP_NAME", "Unknown"), "version": os.getenv("APP_VERSION", "1.0.0")})

@app.route('/api/health')
def health():
    return jsonify({"status": "healthy"})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
