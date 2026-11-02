from flask import Flask, jsonify
import psycopg2
import time

app = Flask(__name__)

@app.route('/')
def home():
    return jsonify(message="App is running"), 200

@app.route('/health')
def health():
    """Check if app and database are healthy"""
    try:
        conn = psycopg2.connect(
            dbname="testdb",
            user="testuser",
            password="testpass",
            host="db",
            connect_timeout=3
        )
        conn.close()
        return jsonify(status="OK"), 200
    except Exception as e:
        return jsonify(status="DB DOWN", error=str(e)), 500

@app.route('/slow')
def slow():
    """Intentionally slow endpoint to test latency alerts"""
    time.sleep(5)
    return jsonify(message="That was slow"), 200

@app.route('/error')
def error():
    """Intentionally return error to test 5xx alerts"""
    return jsonify(error="Simulated app error"), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=False)
