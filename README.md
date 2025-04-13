# 🛠️ Log Monitoring with NGINX, Promtail, Loki & Grafana

This project demonstrates the setup of a centralized log monitoring and visualization system using NGINX, Promtail, Loki, and Grafana — all running on an AWS EC2 instance.

> 📅 Prepared by: **Asifahmed Hussain Shaikh**  
> 📍 Date: April 08, 2025

---

## 🔁 Workflow Overview

1. Launch EC2 instance on AWS  
2. Install and configure NGINX to generate access logs  
3. Install Docker to containerize Loki and Promtail  
4. Install Grafana for visualization  
5. Connect Promtail → Loki → Grafana for real-time log monitoring  
6. Create dashboard and visualize live logs from NGINX  

---

## ⚙️ Step-by-Step Setup

### 1️⃣ Launch EC2 Instance (Ubuntu)

- Use AWS Management Console to create a new EC2 instance.  
- Open port **80 (HTTP)** and **3000 (Grafana)** in the security group.

### 2️⃣ Connect to EC2 via SSH

```bash
ssh -i <your-key>.pem ubuntu@<your-ec2-public-ip>

### 🌐 Step 3: Install and Start NGINX

NGINX is used to generate access logs which we will monitor.

```bash
# Update package list
sudo apt update

# Install NGINX
sudo apt install nginx -y

# Enable NGINX to start on boot
sudo systemctl enable nginx

# Start NGINX service
sudo systemctl start nginx


