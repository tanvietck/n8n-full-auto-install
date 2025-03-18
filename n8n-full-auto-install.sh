#!/bin/bash

echo "==========================="
echo "🚀 Script cài đặt N8N Full Auto (Docker + Nginx + SSL)"
echo "==========================="

# 1. Cập nhật và cài Docker + Docker Compose
echo "👉 Cài đặt Docker & Docker Compose..."
apt update -y
apt install -y docker.io docker-compose

systemctl start docker
systemctl enable docker

# 2. Tạo thư mục n8n và docker-compose file
mkdir -p /home/admindocker/n8n
cd /home/admindocker/n8n

read -p "Nhập mật khẩu admin cho n8n: " N8N_PASSWORD

cat > docker-compose.yml <<EOF
version: "3.8"
services:
  n8n:
    image: n8nio/n8n:latest
    restart: always
    ports:
      - "5678:5678"
    environment:
      - TZ=Asia/Ho_Chi_Minh
      - N8N_BASIC_AUTH_ACTIVE=true
      - N8N_BASIC_AUTH_USER=admin
      - N8N_BASIC_AUTH_PASSWORD=$N8N_PASSWORD
    volumes:
      - ./n8n_data:/home/node/.n8n
EOF

echo "👉 Khởi động n8n container..."
docker-compose up -d

# 3. Cài đặt nginx & certbot
echo "👉 Cài đặt Nginx & Certbot..."
apt install -y nginx snapd
snap install core
snap refresh core
snap install --classic certbot
ln -s /snap/bin/certbot /usr/bin/certbot

# 4. Nhập domain cho reverse proxy
read -p "Nhập domain (ví dụ: n8n.yourdomain.com): " DOMAIN

# 5. Tạo file cấu hình nginx
cat > /etc/nginx/conf.d/n8n.conf <<EOF
server {
    listen 80;
    server_name $DOMAIN;

    location / {
        proxy_pass http://localhost:5678;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
EOF

echo "👉 Reload nginx để áp dụng cấu hình..."
nginx -t && systemctl reload nginx

# 6. Tự xin chứng chỉ SSL với Certbot
echo "👉 Đang xin chứng chỉ SSL cho domain $DOMAIN ..."
certbot --nginx -d $DOMAIN --non-interactive --agree-tos -m admin@$DOMAIN

# 7. In ra kết quả
echo "============================================"
echo "🎉 Hoàn tất cài đặt N8N Full Auto!"
echo "👉 Truy cập: https://$DOMAIN"
echo "👤 Username: admin"
echo "🔒 Password: $N8N_PASSWORD"
echo "============================================"
