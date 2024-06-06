provider "google" {
  credentials = var.google_credentials
  project     = "steadfast-helix-422023"
  region      = "us-central1"
}

variable "google_credentials" {
  description = "Google Cloud credentials in JSON format"
  type        = string
}

resource "google_compute_instance" "clients-service-instance" {
  name         = "clients-service-instance"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }
}

