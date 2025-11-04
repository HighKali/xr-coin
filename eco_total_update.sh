#!/data/data/com.termux/files/usr/bin/bash
echo "🔧 Correggo config.json…"
cat > ~/xrcoin/miner/config.json <<EOF
{ ... } # (usa il contenuto sopra)
EOF

echo "🧹 Libero porta 8180 se occupata…"
PID=$(lsof -t -i:8180)
if [ -n "$PID" ]; then kill -9 $PID; fi

echo "🚀 Riavvio miner orbitale…"
cd ~/xrcoin/miner
PORT=8180 POOL="pool.supportxmr.com:3333" ADDR="491Hnbre..." node server.js &
