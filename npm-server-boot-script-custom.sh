#!/bin/bash
sudo apt update
sudo apt -y upgrade

sudo timedatectl set-timezone Asia/Seoul

sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo echo '/swapfile swap swap defaults 0 0' | sudo tee -a /etc/fstab

sudo ufw allow 22
sudo ufw allow 80
sudo ufw allow 443
sudo ufw allow 8000
sudo ufw allow 9443
yes | sudo ufw enable
sudo systemctl enable ufw.service
sudo ufw restart
sudo ufw status

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

sudo apt-get -y install docker-compose

sudo mkdir -p /data/npm
sudo docker run -d -p 80:80 -p 443:443 -p 81:81 --name npm --restart=unless-stopped -v /data:/data -v /letsencrypt:/etc/letsencrypt jc21/nginx-proxy-manager:latest

sudo mkdir -p /data/portainer
sudo docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest

sudo docker network create npmnetwork
sudo docker network connect npmnetwork npm
sudo docker network connect npmnetwork portainer

ip="$(curl --silent icanhazip.com)"
echo ""
echo ""
echo "부트 스크립트 실행 완료"
echo ""
echo "- Nginx Proxy Manager"
echo "http://$ip:81"
echo ""
echo "- NPM 기본 로그인은 다음과 같음"
echo "Email: admin@example.com"
echo "Password: changemeplz"
echo ""
echo "- Portainer"
echo "http://$ip:8000"
echo ""
echo "NPM과 다른 컨테이너를 연결 시 npmnetwork 네트워크에 연결 필요함"