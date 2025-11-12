# Terraform IaC for provisioning GCP resources to host the Chuck Norris app.
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

# --- Google Provider ---
# Terraform provider configuration
provider "google" {
  project = "terraform-gcp-378718"
  region  = "us-central1"
  zone    = "us-central1-a"
}

# --- Firewall rule (SSH + App Port) ---
# Terraform resource block
resource "google_compute_firewall" "chuck_firewall" {
  name    = "allow-chuck-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22", "5001"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["chuck-app"]
}

# --- Free-Tier Eligible Compute Engine VM ---
# Terraform resource block
resource "google_compute_instance" "chuck_vm" {
  name         = "chuck-norris-vm"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  tags = ["chuck-app"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      size  = 10
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata = {
    ssh-keys = "debian:${file("${path.module}/chuck_key.pub")}"
  }
}

# --- Outputs for reference ---
output "instance_ip" {
  description = "Public IP of the deployed VM"
  value       = google_compute_instance.chuck_vm.network_interface[0].access_config[0].nat_ip
}

output "ssh_command" {
  description = "SSH command to access the VM"
  value       = "ssh -i ${path.module}/chuck_key debian@${google_compute_instance.chuck_vm.network_interface[0].access_config[0].nat_ip}"
}
