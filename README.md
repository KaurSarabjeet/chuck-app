# Chuck Norris Jokes App

A simple project that deploys a **Chuck Norris joke web application** on **Google Cloud**, using **Terraform**, **Ansible**, **Docker**, and **Flask**. The app fetches random jokes from the public API and displays them in a simple web page.

---

## Overview

This project demonstrates a complete deployment workflow:

1. **Infrastructure provisioning** on Google Cloud using Terraform.
2. **VM configuration and application deployment** using Ansible.
3. **Containerized Python Flask application** using Docker.

---

## Infrastructure (Terraform)

Terraform provisions the virtual machine and firewall rules on **Google Cloud Compute Engine**.

### Key Files

* **main.tf** – Creates a Debian VM and firewall rules.
* **variables.tf** – Contains configurable values like project, region, zone, and machine type.
* **outputs.tf** – Displays useful information such as external and internal IP addresses.

### Commands

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

After applying, note the **external IP** of the VM for Ansible.

---

## Provisioning & Deployment (Ansible)

Ansible installs necessary packages on the VM and deploys the Docker container running the Flask app.

### Key Files

* **inventory.ini** – Stores the VM IP address.
* **playbook.yml** – Installs Docker, copies application files, builds the Docker image, and runs the container.

### Run Ansible

```bash
cd ansible
ansible-playbook -i inventory.ini playbook.yml
```

This will:

* Install Docker
* Copy the application files
* Build and run the Docker container

The application becomes available on port **5001**.

---

## Web Application (Flask + Docker)

The Flask application is located in the `app/` directory.

### Key Components

* **main.py** – Backend Flask logic fetching jokes from the API.
* **templates/index.html** – Frontend UI for displaying jokes.
* **static/styles.css** – Styling for the interface.
* **Dockerfile** – Builds the Flask application image.

### Run Locally

```bash
cd app
docker build -t chuck-app .
docker run -p 5001:5001 chuck-app
```

Visit:

```
http://localhost:5001
```

---

## Deployment Workflow Summary

1. **Build infrastructure** using Terraform:

   ```bash
   terraform apply
   ```
2. **Deploy the application** using Ansible:

   ```bash
   ansible-playbook -i ansible/inventory.ini ansible/playbook.yml
   ```
3. **Access the application**:

```
http://<EXTERNAL_IP>:5001
```

---

## Best Practices

* Use a **GCP service account** for Terraform authentication.
* Avoid committing secrets, SSH keys, or Terraform state files.
* Keep Terraform variables in `terraform.tfvars`.
* Split playbooks in the future for better maintainability if needed.

---

## Technology Stack

| Layer            | Technology                  |
| ---------------- | --------------------------- |
| Cloud            | Google Cloud Compute Engine |
| IaC              | Terraform                   |
| Configuration    | Ansible                     |
| Backend          | Python Flask                |
| Containerization | Docker                      |
| Frontend         | HTML + CSS                  |

---

## Future Enhancements

* Add CI/CD (GitHub Actions or Cloud Build).
* Improve application logging and monitoring.
* Add separate provision and deployment playbooks.

---

## References

* [https://api.chucknorris.io/](https://api.chucknorris.io/)
* [https://developer.hashicorp.com/terraform](https://developer.hashicorp.com/terraform)
* [https://docs.ansible.com/](https://docs.ansible.com/)
* [https://flask.palletsprojects.com/](https://flask.palletsprojects.com/)
