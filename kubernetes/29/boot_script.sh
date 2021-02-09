#!/bin/bash

echo "<token>" > /root/worker.token

wget https://github.com/k0sproject/k0s/releases/download/v0.9.1/k0s-v0.9.1-amd64  -O /usr/local/bin/k0s 
chmod +x /usr/local/bin/k0s
k0s install --role worker
sed -i 's/REPLACEME/\/root\/worker\.token/g' /etc/systemd/system/k0s.service
systemctl daemon-reload
systemctl enable k0s
systemctl start k0s
