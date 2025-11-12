# Terraform variable definitions for Chuck Norris app deployment on GCP

# Google Cloud project configuration
variable "project_id" {
  description = "The Google Cloud project ID where resources will be created."
  type        = string
}

variable "region" {
  description = "The GCP region where resources will be deployed."
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The GCP zone for the Compute Engine VM."
  type        = string
  default     = "us-central1-a"
}

# Service account attached to the VM for secure API access
variable "service_account_email" {
  description = "Service account email attached to the VM to access GCP services."
  type        = string
}

# Optional: SSH username (used only for OS Login)
variable "ssh_user" {
  description = "OS Login user for SSH access (default: debian)."
  type        = string
  default     = "debian"
}
