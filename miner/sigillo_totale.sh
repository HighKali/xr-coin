#!/data/data/com.termux/files/usr/bin/bash

echo "🚀 [XR∞] Inizio sigillo orbitale completo..."

# 📦 Dipendenze
pkg update -y
pkg install -y git nodejs wget unzip nano

# 🌀 Clona CryptoNoter
cd ~
git clone https://github.com/cryptophp/CryptoNoter.git
cd CryptoNoter

# 🧬 Crea config.json
cat > config.json <<EOF
{
  "poolHost": "pool.supportxmr.com",
  "poolPort": 3333,
  "pool": "pool.supportxmr.com:3333",
  "walletAddress": "491Hnbre8XP1Lyji5P53JyK5QVSrhj4ZPfABotRjPjRL4yeVVa8p7pMRRe9zzMDYh8PZhcmeoMBREUkLwM6H96CKBdL47XX",
  "addr": "491Hnbre8XP1Lyji5P53JyK5QVSrhj4ZPfABotRjPjRL4yeVVa8p7pMRRe9zzMDYh8PZhcmeoMBREUkLwM6H96CKBdL47XX",
  "coin": "monero",
  "threads": 4,
  "ssl": false,
  "lport": 8180,
  "domain": "localhost"
}
EOF

# 🔧 Crea eco_miner_bot.sh
cat > eco_miner_bot.sh <<'EOF'
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
EOF
chmod +x eco_miner_bot.sh

# 🌐 Crea index.html
cat > index.html <<EOF
<!DOCTYPE html>
<html lang="it">
<head>
  <meta charset="UTF-8">
  <title>XR∞ Nodo Orbitale</title>
</head>
<body style="background:#0b0c10;color:#c5c6c7;font-family:monospace">
  <h1>⛏️ XR∞ Nodo Orbitale</h1>
  <button onclick="startMining()">Avvia Mining Orbitale</button>
  <iframe id="miner-frame" src="" width="100%" height="400" style="border:none;display:none;"></iframe>
  <script>
    function startMining() {
      document.getElementById("miner-frame").src = "http://localhost:8180";
      document.getElementById("miner-frame").style.display = "block";
    }
  </script>
</body>
</html>
EOF

# 📜 Crea README.md
cat > README.md <<EOF
# ⛏️ XR∞ Miner — Nodo Orbitale Decentralizzato

Benvenuto nel nodo orbitale XR∞ — un miner decentralizzato Monero (XMR) integrato nel portale XR∞ come battito computazionale etico e partecipativo.

## 🚀 Visione
Ogni hash è un battito. Ogni visitatore contribuisce al tessuto computazionale XR∞.

## 🧱 Installazione
\`\`\`bash
chmod +x eco_miner_bot.sh
./eco_miner_bot.sh start
\`\`\`

## 🌐 Portale
Apri \`index.html\` e clicca “Avvia Mining Orbitale”

## 🔖 Badge Orbitale
Incluso come \`eco_miner_badge.svg\`

## 📡 Tunnel (opzionale)
Usa ngrok per rendere pubblico il miner

## 🧬 Crediti
- Miner: CryptoNoter
- Architettura: XR∞ Industrial Constellation
EOF

# 🌀 Inizializza Git e collega al tuo repository
git init
git branch -M main
git remote add origin https://github.com/HighKali/XR-Miner.git
git add .
git commit -m "🌌 Sigillo orbitale XR∞ completo"
git push -u origin main

echo "✅ Sigillo completato e pubblicato su GitHub"
