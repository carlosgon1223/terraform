provider "google" {
  credentials = file("~/terraform-key.json")
  project     = "steadfast-helix-422023"
  region      = "us-central1"
}

resource "google_compute_instance" "clients-service-instance" {
  name         = "clients-service"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "default"

    access_config {
    }
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y python3 python3-pip
    pip3 install Flask
    echo "from flask import Flask, jsonify

    app = Flask(__name__)

    @app.route('/clients', methods=['GET'])
    def get_clients():
        clients = [
            {"id": 1, "name": "John Doe"},
            {"id": 2, "name": "Jane Smith"}
        ]
        return jsonify(clients)

    if __name__ == '__main__':
        app.run(host='0.0.0.0', port=5000)" > /home/flask/app.py
    python3 /home/flask/app.py
  EOF
}
