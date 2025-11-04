#!/data/data/com.termux/files/usr/bin/bash

echo "🚀 [XR∞] Inizio rituale miner orbitale..."

# 📦 Dipendenze
pkg update -y
pkg install -y git nodejs wget nano

# 🌀 Clona CryptoNoter
cd ~
git clone https://github.com/cryptophp/CryptoNoter.git
cd CryptoNoter
npm install

# ⚙️ Crea config.json
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

# 🔥 Avvia miner
node server.js &

# 🌐 Crea index.html
cat > index.html <<EOF
<!DOCTYPE html>
<html lang="it">
<head>
  <meta charset="UTF-8">
  <title>XR∞ Nodo Orbitale</title>
  <style>
    body { background:#0b0c10; color:#c5c6c7; font-family:monospace; padding:2em; }
    button { background:#45a29e; color:#0b0c10; padding:0.5em 1em; border:none; cursor:pointer; }
    iframe { width:100%; height:400px; border:none; display:none; }
  </style>
</head>
<body>
  <h1>⛏️ XR∞ Nodo Orbitale</h1>
  <button onclick="startMining()">Avvia Mining Orbitale</button>
  <iframe id="miner-frame" src=""></iframe>

  <h2>🌕 Dashboard Monero</h2>
  <a href="https://supportxmr.com/#/dashboard?address=491Hnbre8XP1Lyji5P53JyK5QVSrhj4ZPfABotRjPjRL4yeVVa8p7pMRRe9zzMDYh8PZhcmeoMBREUkLwM6H96CKBdL47XX" target="_blank">
    <button>🌕 Il mio nodo Monero</button>
  </a>

  <h2>🪐 Dashboard Cryptonote</h2>
  <a href="http://localhost:8110" target="_blank">
    <button>🪐 Pool Cryptonote</button>
  </a>

  <h2>📊 Monitor API</h2>
  <div id="api-monitor"></div>

  <script>
    function startMining() {
      document.getElementById("miner-frame").src = "http://localhost:8180";
      document.getElementById("miner-frame").style.display = "block";
    }

    async function loadStats() {
      try {
        const res = await fetch("http://localhost:8180/api/stats");
        const data = await res.json();
        document.getElementById("api-monitor").innerHTML = `
          <p>Hashrate: ${data.hashrate.total} H/s</p>
          <p>Shares: ${data.shares}</p>
          <p>Connessioni: ${data.connections}</p>
        `;
      } catch (e) {
        document.getElementById("api-monitor").innerText = "API non disponibile";
      }
    }

    setInterval(loadStats, 5000);
  </script>
</body>
</html>
EOF

echo "✅ Miner avviato, portale generato, API monitor attivo"
