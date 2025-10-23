#!/bin/bash
# ==========================================================
# Script Name: prometheus-install.sh
# Description: Install and configure Prometheus on Ubuntu
# Author: Moamen Nasser
# ==========================================================

set -e

PROM_VERSION="2.47.1"

echo "🔹 Creating Prometheus system user..."
sudo useradd --system --no-create-home --shell /bin/false prometheus

echo "🔹 Downloading Prometheus v$PROM_VERSION..."
wget https://github.com/prometheus/prometheus/releases/download/v${PROM_VERSION}/prometheus-${PROM_VERSION}.linux-amd64.tar.gz
tar -xvf prometheus-${PROM_VERSION}.linux-amd64.tar.gz

echo "🔹 Moving binaries and configuration files..."
sudo mv prometheus-${PROM_VERSION}.linux-amd64/prometheus /usr/local/bin/
sudo mv prometheus-${PROM_VERSION}.linux-amd64/promtool /usr/local/bin/
sudo mkdir -p /etc/prometheus /data
sudo mv prometheus-${PROM_VERSION}.linux-amd64/consoles /etc/prometheus/
sudo mv prometheus-${PROM_VERSION}.linux-amd64/console_libraries /etc/prometheus/
sudo mv prometheus-${PROM_VERSION}.linux-amd64/prometheus.yml /etc/prometheus/

sudo chown -R prometheus:prometheus /etc/prometheus /data

echo "🔹 Creating Prometheus systemd service..."
cat <<EOF | sudo tee /etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus --config.file=/etc/prometheus/prometheus.yml --storage.tsdb.path=/data --web.listen-address=0.0.0.0:9090
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl start prometheus

echo "✅ Prometheus is running at: http://<server-ip>:9090"

