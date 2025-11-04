#!/data/data/com.termux/files/usr/bin/bash
WALLET="491Hnbre8XP1Lyji5P53JyK5QVSrhj4ZPfABotRjPjRL4yeVVa8p7pMRRe9zzMDYh8PZhcmeoMBREUkLwM6H96CKBdL47XX"
POOL="pool.supportxmr.com:3333"
PORT=8180
DOMAIN="localhost"
STATUS_FILE="$HOME/.eco_miner_status"
function start_miner() {
  cd ~/CryptoNoter
  cat > config.json <<EOC
{
  "poolHost": "${POOL%%:*}",
  "poolPort": ${POOL##*:},
  "pool": "$POOL",
  "walletAddress": "$WALLET",
  "addr": "$WALLET",
  "coin": "monero",
  "threads": 4,
  "ssl": false,
  "lport": $PORT,
  "domain": "$DOMAIN"
}
EOC
  node server.js &
  echo "on" > "$STATUS_FILE"
}
function stop_miner() {
  pkill -f "node server.js"
  echo "off" > "$STATUS_FILE"
}
function status_miner() {
  [ -f "$STATUS_FILE" ] && echo "🧭 Stato miner: $(cat "$STATUS_FILE")" || echo "🧭 Stato miner: sconosciuto"
}
case "$1" in
  start) start_miner ;;
  stop) stop_miner ;;
  status) status_miner ;;
  *) echo "Uso: $0 {start|stop|status}" ;;
esac
