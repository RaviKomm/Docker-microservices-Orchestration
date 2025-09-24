from flask import Flask, jsonify
import socket, os, time

app = Flask(__name__)

@app.route('/api/health')
def health():
    return jsonify({
        'status': 'healthy',
        'container_id': socket.gethostname(),
        'version': os.getenv('APP_VERSION', '1.0')
    })

@app.route('/api/data')
def data():
    time.sleep(0.1)
    return jsonify({
        'message': 'Response from API',
        'server': socket.gethostname(),
        'timestamp': time.time()
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
