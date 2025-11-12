# Terraform IaC for provisioning GCP resources to host the Chuck Norris app.
# Google Cloud Project ID
# Terraform variable declaration
variable "project_id" {
  description = "The GCP project ID where resources will be created"
  type        = string
  default     = "chuck-norris-app-01" # Replace with your actual GCP project ID
}

# Region — must be free-tier eligible
# Terraform variable declaration
variable "region" {
  description = "GCP region for deployment (must be Free Tier eligible)"
  type        = string
  default     = "us-central1"
}

# Zone inside that region
# Terraform variable declaration
variable "zone" {
  description = "Specific zone for the VM"
  type        = string
  default     = "us-central1-a"
}

# SSH username for GCE VM (Debian image)
# Terraform variable declaration
variable "ssh_user" {
  description = "Username for SSH access (auto-created by Terraform)"
  type        = string
  default     = "debian"
}

# Local path to your SSH public key
# Terraform variable declaration
variable "public_key_path" {
  description = "Path to your SSH public key that Terraform injects into the VM"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

# Path to your downloaded GCP Service Account key JSON
# Terraform variable declaration
variable "credentials_file" {
  description = "Path to GCP Service Account JSON used by Terraform to authenticate"
  type        = string
  default     = "~/gcp-keys/terraform-key.json"
}