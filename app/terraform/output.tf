# Terraform IaC for provisioning GCP resources to host the Chuck Norris app.
# ==============================================================
# outputs.tf
# Provides key deployment details for verification and automation.
# ==============================================================

# --- Project & Location ---
output "project_id" {
  description = "GCP project ID used for deployment."
  value       = var.project_id
}

output "region" {
  description = "Region where resources are deployed."
  value       = var.region
}

output "zone" {
  description = "Zone of the Compute Engine instance."
  value       = var.zone
}

# --- Firewall Details ---
output "firewall_name" {
  description = "Name of the firewall rule."
  value       = google_compute_firewall.chuck_firewall.name
}

output "firewall_allowed_ports" {
  description = "Allowed TCP ports in the firewall."
  value       = google_compute_firewall.chuck_firewall.allow[0].ports
}

output "firewall_source_ranges" {
  description = "Source IP ranges allowed by the firewall."
  value       = google_compute_firewall.chuck_firewall.source_ranges
}

# --- VM Instance Info ---
output "instance_name" {
  description = "Name of the Compute Engine VM."
  value       = google_compute_instance.chuck_vm.name
}

output "instance_self_link" {
  description = "Self-link URL of the VM."
  value       = google_compute_instance.chuck_vm.self_link
}

output "instance_external_ip" {
  description = "External (public) IP of the VM."
  value       = google_compute_instance.chuck_vm.network_interface[0].access_config[0].nat_ip
}

output "instance_internal_ip" {
  description = "Internal (private) IP of the VM."
  value       = google_compute_instance.chuck_vm.network_interface[0].network_ip
}

