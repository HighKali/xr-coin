#!/data/data/com.termux/files/usr/bin/bash

echo "🚀 Avvio WebMiner XR∞ su porta 8180…"

PORT=8180
POOL="pool.supportxmr.com:3333"
ADDR="491Hnbre..."

cd ~/xrcoin/miner/XR-Miner
node server.js --port $PORT --pool $POOL --address $ADDR
