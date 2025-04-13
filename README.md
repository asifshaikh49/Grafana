# Log Monitoring with NGINX, Promtail, Loki & Grafana

## 📄 Prepared by
**Asifahmed Hussain Shaikh**  


---

## 🚀 Overview

This project demonstrates how to set up a centralized log monitoring and visualization system using:

- **NGINX** (Web server)
- **Promtail** (Log shipper)
- **Loki** (Log aggregator)
- **Grafana** (Dashboard)

All components are installed and configured on an **AWS EC2 instance** using **Docker** wherever applicable.

---

## 🧱 Architecture Workflow

1. Launch EC2 instance on AWS
2. Install and configure NGINX
3. Open Port 80 in EC2 security group
4. Install Grafana (access on port 3000)
5. Install Docker
6. Run Loki and Promtail in Docker
7. Set up dashboards in Grafana to view logs from NGINX

---

## ⚙️ Step-by-Step Setup

### 1. Launch EC2 Instance
Use Ubuntu or any Linux-based AMI.

### 2. Connect via SSH
```bash
ssh -i "your-key.pem" ubuntu@your-ec2-public-ip


### 3. Install & Start NGINX
```bash
sudo apt update
sudo apt install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
```

### 4. Allow Port 80 in AWS Security Group
- Go to EC2 > Security Groups > Inbound Rules > Add Rule
- Type: HTTP, Port: 80, Source: 0.0.0.0/0

### 5. Access NGINX in Browser
```
http://<your-ec2-public-ip>
```

---

## 📊 Install Grafana
```bash
sudo apt install -y apt-transport-https software-properties-common
sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
sudo apt update
sudo apt install grafana
sudo systemctl start grafana-server
sudo systemctl enable grafana-server
```

Access Grafana at:  
```
http://<your-ec2-public-ip>:3000  
Username: admin | Password: admin
```

---

## 🐳 Install Docker
```bash
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
```

---

## 📦 Loki Setup (via Docker)
```bash
wget https://raw.githubusercontent.com/grafana/loki/main/cmd/loki/loki-local-config.yaml

docker run -d --name=loki   -p 3100:3100   -v $(pwd)/loki-local-config.yaml:/etc/loki/local-config.yaml   grafana/loki:2.9.0   -config.file=/etc/loki/local-config.yaml
```

---

## 📦 Promtail Setup (via Docker)
```bash
wget https://raw.githubusercontent.com/grafana/loki/main/clients/cmd/promtail/promtail-docker-config.yaml

docker run -d --name=promtail   -v /var/log:/var/log   -v $(pwd)/promtail-docker-config.yaml:/etc/promtail/config.yaml   grafana/promtail:2.9.0   -config.file=/etc/promtail/config.yaml
```

---

## 📈 Grafana Dashboard Setup

1. Open Grafana (`http://<EC2_IP>:3000`)
2. Add **Loki** as a data source
3. Go to **Explore**
4. Run query:
   ```logql
   {job="nginx"}
   ```
5. Create dashboard panels to visualize logs

---

## 🔍 Sample Log Output
```json
{ "filename": "/var/log/nginx/access.log", "job": "nginx", "service_name": "nginx" }
```

```
103.195.83.125 - - [08/Apr/2025:14:20:26 +0000] "GET /app HTTP/1.1" 404 196 "-" "Mozilla/5.0 ..."
```

---

## ✅ Conclusion

We successfully configured a real-time log monitoring stack using:

- **NGINX** to generate logs
- **Promtail** to ship logs
- **Loki** to store logs
- **Grafana** to visualize logs

This setup can be scaled for production use and provides great observability into server activity.

---

