#!/data/data/com.termux/files/usr/bin/bash

echo "🧹 Chiudo ogni processo minerario attivo…"
pkill node

echo "🛠️ Correggo package.json del pool orbitale…"
POOL_DIR="$HOME/xrcoin/pool"
PKG="$POOL_DIR/package.json"

if grep -q "turtlecoin-crypto" "$PKG"; then
  sed -i '/turtlecoin-crypto/d' "$PKG"
  echo "✅ Dipendenza rotta rimossa da package.json"
else
  echo "ℹ️ Nessuna dipendenza turtlecoin-crypto trovata"
fi

echo "📦 Reinstallo dipendenze valide del pool…"
cd "$POOL_DIR" || exit
npm install

echo "🚀 Avvio WebMiner XR∞ su porta 8180…"
PORT=8180 POOL="pool.supportxmr.com:3333" ADDR="491Hnbre..." node ~/xrcoin/miner/XR-Miner/server.js &

sleep 2

echo "🛠️ Avvio Mining Pool Orbitale su porta 3333…"
node init.js &

sleep 3

echo "🌐 Espongo il pool via localtunnel (subdomain: xrpool)…"
lt --port 3333 --subdomain xrpool --no-browser > ~/xrcoin/pool_tunnel.log &

sleep 5
POOL_URL=$(grep -o 'https://[^ ]*' ~/xrcoin/pool_tunnel.log | head -n 1)

echo "📄 Ricompilo index.html con dashboard e pool orbitale…"
cat > ~/xrcoin/index.html <<EOF
<!DOCTYPE html>
<html lang="it">
<head>
  <meta charset="UTF-8">
  <title>XR∞Miner Dashboard</title>
  <style>
    body { background:#0b0c10; color:#c5c6c7; font-family:monospace; padding:2em; }
    button, select { background:#45a29e; color:#0b0c10; padding:0.5em 1em; border:none; cursor:pointer; margin:0.5em 0; }
    iframe { width:100%; height:400px; border:none; display:none; }
    .section { margin-bottom:2em; }
    code { background:#1f2833; padding:0.2em 0.4em; border-radius:4px; }
    .badge { background:#66fcf1; color:#0b0c10; padding:0.3em 0.6em; border-radius:6px; display:inline-block; margin-top:1em; font-weight:bold; }
  </style>
</head>
<body>
  <h1>⛏️ XR∞Miner Dashboard</h1>
  <p>Mining orbitale in-browser per XMR, ETN, BCN. 0% commissione. 100% payout verso wallet personale.</p>
  <div class="badge">🏅 XR∞ WebMiner Contributor</div>

  <div class="section">
    <h2>🪙 Selettore Moneta</h2>
    <select id="coin">
      <option value="monero">Monero (XMR)</option>
      <option value="electroneum">Electroneum (ETN)</option>
      <option value="bytecoin">Bytecoin (BCN)</option>
    </select>
    <button onclick="startMining()">Avvia Mining</button>
    <iframe id="miner-frame" src=""></iframe>
  </div>

  <div class="section">
    <h2>📊 Monitor API Miner</h2>
    <div id="api-monitor">Caricamento dati minerari…</div>
  </div>

  <div class="section">
    <h2>🌐 Pool Orbitale XR∞</h2>
    <p>Connettiti al nostro pool decentralizzato:</p>
    <ul>
      <li>URL: <code>stratum+tcp://${POOL_URL#https://}</code></li>
      <li>Algoritmo: <code>RandomX</code></li>
      <li>Wallet: <code>491Hnbre...</code></li>
    </ul>
  </div>

  <script>
    function startMining() {
      const coin = document.getElementById("coin").value;
      let port = 8180;
      if (coin === "electroneum") port = 8280;
      if (coin === "bytecoin") port = 8380;
      document.getElementById("miner-frame").src = "http://localhost:" + port;
      document.getElementById("miner-frame").style.display = "block";
    }

    async function loadStats() {
      try {
        const res = await fetch("http://localhost:8180/api/stats");
        const data = await res.json();
        document.getElementById("api-monitor").innerHTML = `
          <p>Hashrate: \${data.hashrate.total} H/s</p>
          <p>Shares: \${data.shares}</p>
          <p>Connessioni: \${data.connections}</p>
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

echo "📦 Committo e pubblico su GitHub…"
cd ~/xrcoin || exit
git add index.html
git commit -m "🌐 Pool orbitale XR∞ corretto e integrato nella homepage"
git push origin main

echo "🌍 Homepage orbitale aggiornata: https://highkali.github.io/xr-coin/"
