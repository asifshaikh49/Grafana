ls
sudo apt-get install -y apt-transport-https software-properties-common wget
sudo mkdir -p /etc/apt/keyrings/
wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
apt-get update
apt-get install grafana
systemctl enable grafana-server
systemctl start grafana-server
systemctl status grafana-server
apt-get update
apt-get install docker.io
systemctl enable docker
systemctl start docker
docker ps
mkdir grafana-config
cd grafana-config/
wget https://raw.githubusercontent.com/grafana/loki/v3.4.1/cmd/loki/loki-local-config.yaml -O loki-config.yaml
docker run --name loki -d -v $(pwd):/mnt/config -p 3100:3100 grafana/loki:3.4.1 -config.file=/mnt/config/loki-config.yaml
docker ps
wget https://raw.githubusercontent.com/grafana/loki/v3.4.1/clients/cmd/promtail/promtail-docker-config.yaml -O promtail-config.yaml
docker run --name promtail -d   -v $(pwd):/mnt/config   -v /var/log:/var/log   --link loki   grafana/promtail:3.4.1   -config.file=/mnt/config/promtail-config.yaml
docker ps
apt-get update
apt-get install nginx -y
systemctl start nginx
systemctl enable nginx
curl http://localhost
ls
vim promtail-config.yaml 
promtail -config.file=/etc/promtail-config.yaml
docker ps
docker restart ab38fb0ee747
sudo systemctl status nginx
sudo ss -tuln | grep :80
docker stop promtail
docker rm promtail
docker run --name promtail -d   -v $(pwd):/mnt/config   -v /var/log:/var/log   --link loki   grafana/promtail:3.4.1   -config.file=/mnt/config/promtail-config.yaml
ls -l /var/log/nginx/
ls
vim promtail-config.yaml 
docker rm -f promtail
docker run --name promtail -d   -v $(pwd):/mnt/config   -v /var/log:/var/log   --link loki   grafana/promtail:3.4.1   -config.file=/mnt/config/promtail-config.yaml
