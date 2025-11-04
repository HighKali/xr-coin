#!/bin/bash
echo "🚀 Avvio XR∞Pool su Ubuntu WSL…"
cd ~/xrcoin/pool
sudo service redis-server start
npm install --legacy-peer-deps --no-optional
node init.js &
sleep 2
xdg-open ~/xrcoin/index.html
