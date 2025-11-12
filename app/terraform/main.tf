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
# Uses Application Default Credentials (ADC)
# No need for explicit credentials or key files.
provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

# --- Firewall rule (SSH + App Port) ---
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

# --- Compute Engine VM ---
resource "google_compute_instance" "chuck_vm" {
  name         = "chuck-norris-vm"
  machine_type = "e2-micro"
  zone         = var.zone
  tags         = ["chuck-app"]

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

  # Enable OS Login for IAM-based SSH (no key injection)
  metadata = {
    enable-oslogin = "TRUE"
  }

  # Attach a service account for the VM to access GCP APIs securely
  service_account {
    email  = var.service_account_email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}

# --- Outputs ---
output "instance_ip" {
  description = "Public IP of the deployed VM"
  value       = google_compute_instance.chuck_vm.network_interface[0].access_config[0].nat_ip
}

output "ssh_command" {
  description = "Command to SSH into the VM using OS Login"
  value       = "gcloud compute ssh debian@${google_compute_instance.chuck_vm.name} --zone ${var.zone}"
}
