---

# Chuck Norris Web App – Take-Home Project

A simple and complete project that deploys a **Chuck Norris joke web application** on **Google Cloud**, using **Terraform**, **Ansible**, **Docker**, and **Flask**.
The app fetches random jokes from [https://api.chucknorris.io/](https://api.chucknorris.io/) and display them.

---

## Overview

This project demonstrates an end-to-end deployment workflow:

1. **Infrastructure provisioning** on Google Cloud with Terraform.
2. **VM configuration and deployment** using Ansible.
3. **Containerized web application** built with Docker and Flask.

Each layer is modular, reusable, and follows best practices for infrastructure automation.

---

## Infrastructure (Terraform)

Terraform handles all infrastructure creation on **Google Cloud Platform (GCP)**.

* **main.tf** – Creates a Compute Engine VM (Debian 12) and a firewall rule for ports `22` (SSH) and `5001` (app).
* **variables.tf** – Defines variables such as project ID, region, and zone.
* **outputs.tf** – Prints VM details (external/internal IPs, firewall info, summary).
* **provider.tf** – Specifies the Google provider and required Terraform version.

**Commands:**

```bash
terraform init
terraform plan
terraform apply
```

After applying, note the **external IP** to use in Ansible or your browser.

---

## Provisioning (Ansible)

Once the VM is created, Ansible installs and configures everything automatically.

* **provision.yml** – Installs Docker and nginx, updates packages, and grants the default Debian user Docker access.
* **deploy.yml** – Copies app files, builds the Docker image, runs the container, and configures nginx as a reverse proxy.

**Run:**

```bash
ansible-playbook -i inventory.ini provision.yml
ansible-playbook -i inventory.ini deploy.yml
```

---

## Web Application (Flask + Docker)

The Flask app lives in the `app/` directory.

* **app.py** – Flask server fetching jokes from the public API and rendering them as HTML.
* **index.html** – Displays the joke text in the center of the page with a clean layout.
* **styles.css** – Adds a dark theme and yellow joke text for contrast.
* **Dockerfile** – Builds a lightweight Python 3 Alpine image with project dependencies.

**Run locally:**

```bash
docker build -t chuck-app .
docker run -p 5001:5001 chuck-app
```

Visit: `http://localhost:5001`

---

## Deployment Workflow

1. **Provision infrastructure**

   ```bash
   terraform apply
   ```
2. **Configure and deploy**

   ```bash
   ansible-playbook -i inventory.ini provision.yml
   ansible-playbook -i inventory.ini deploy.yml
   ```
3. **Access the app**

   ```
   http://<EXTERNAL_IP>:80
   ```

   or directly:

   ```
   http://<EXTERNAL_IP>:5001
   ```

---

## Best Practices

* Use a **GCP Service Account** for Terraform authentication instead of `gcloud auth login`.
* Never commit secrets, `.tfstate` files, or private keys.
* Keep infrastructure flexible using variables and modules.
* Add `/health` endpoints and blue-green deployment strategies for production-grade availability.

---

## Technology Stack

| Layer                    | Technology                                       |
| ------------------------ | ------------------------------------------------ |
| Cloud                    | Google Cloud Platform (Compute Engine, Firewall) |
| Infrastructure as Code   | Terraform                                        |
| Configuration Management | Ansible                                          |
| Backend                  | Flask (Python)                                   |
| Containerization         | Docker (Alpine Linux)                            |
| Frontend                 | HTML + CSS                                       |

---

## References

* [Chuck Norris API](https://api.chucknorris.io/)
* [Terraform Documentation](https://developer.hashicorp.com/terraform)
* [Ansible Documentation](https://docs.ansible.com/)
* [Flask Framework](https://flask.palletsprojects.com/)

---
