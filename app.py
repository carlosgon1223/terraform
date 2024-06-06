from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/clients', methods=['GET'])
def get_clients():
    clients = [
        {"id": 1, "name": "John Doe"},
        {"id": 2, "name": "Jane Smith"}
    ]
    return jsonify(clients)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
