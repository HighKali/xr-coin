#!/data/data/com.termux/files/usr/bin/bash
# 🌌 XR∞ Script Totale — Configura, integra, aggiorna e riavvia

echo "🔧 Correggo config.json…"
cat > ~/CryptoNoter/config.json <<EOF
{
  "coin": "monero",
  "walletAddress": "491Hnbre8XP1Lyji5P53JyK5QVSrhj4ZPfABotRjPjRL4yeVVa8p7pMRRe9zzMDYh8PZhcmeoMBREUkLwM6H96CKBdL47XX",
  "poolHost": "pool.supportxmr.com",
  "poolPort": 3333,
  "lport": 8180
}
EOF

echo "🌐 Ricompilo index.html con modulo BOINC…"
cat > ~/CryptoNoter/public/index.html <<'EOF'
<!DOCTYPE html>
<html lang="it">
<head>
  <meta charset="UTF-8">
  <title>XR∞ Nodo Orbitale</title>
  <style>
    body { background:#0b0c10; color:#c5c6c7; font-family:monospace; padding:2em; }
    button, select { background:#45a29e; color:#0b0c10; padding:0.5em 1em; border:none; cursor:pointer; margin:0.5em 0; }
    iframe { width:100%; height:400px; border:none; display:none; }
    .section { margin-bottom:2em; }
    code { background:#1f2833; padding:0.2em 0.4em; border-radius:4px; }
  </style>
</head>
<body>
  <h1>⛏️ XR∞ Nodo Orbitale</h1>
  <p>Benvenuto nel portale minerario decentralizzato XR∞. Ogni hash è un battito, ogni nodo una stella. Qui puoi minare Monero, esplorare la rete Cryptonote e contribuire alla scienza con BOINC.</p>

  <div class="section">
    <h2>🪙 Selettore di Moneta</h2>
    <select id="coin">
      <option value="monero">Monero (XMR)</option>
      <option value="electroneum">Electroneum (ETN)</option>
      <option value="bytecoin">Bytecoin (BCN)</option>
    </select>
    <button onclick="startMining()">Avvia Mining Orbitale</button>
    <iframe id="miner-frame" src=""></iframe>
  </div>

  <div class="section">
    <h2>🌕 Dashboard Monero</h2>
    <button onclick="window.open('https://supportxmr.com/#/dashboard?address=491Hnbre8XP1Lyji5P53JyK5QVSrhj4ZPfABotRjPjRL4yeVVa8p7pMRRe9zzMDYh8PZhcmeoMBREUkLwM6H96CKBdL47XX')">
      🌕 Il mio nodo Monero
    </button>
  </div>

  <div class="section">
    <h2>🪐 Dashboard Cryptonote</h2>
    <button onclick="window.open('http://pool.cryptonoter.com:1111')">
      🪐 Pool Cryptonote
    </button>
  </div>

  <div class="section">
    <h2>🔬 Modulo Scientifico XR∞ — Contribuisci con BOINC</h2>
    <p>Trasforma il tuo nodo in un laboratorio orbitale. Con BOINC puoi contribuire a progetti scientifici reali: astrofisica, biomedicina, clima e matematica distribuita.</p>
    <button onclick="window.open('https://scienceunited.org')">
      🌐 Unisciti a Science United
    </button>
    <p><strong>Istruzioni rapide:</strong></p>
    <ul>
      <li>Installa BOINC: <code>pkg install boinc</code> (Termux) o <code>sudo apt install boinc-client</code> (Linux)</li>
      <li>Avvia il client: <code>boinc</code> o <code>boincmgr</code></li>
      <li>Collega il tuo account Science United</li>
      <li>Seleziona i progetti scientifici da supportare</li>
    </ul>
    <p><strong>Chiave orbitale XR∞:</strong> <code>XR∞-BOINC-NODE-491</code></p>
  </div>

  <div class="section">
    <h2>📊 Monitor Miner API</h2>
    <div id="api-monitor">Caricamento dati...</div>
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

echo "📦 Aggiorno GitHub…"
cd ~/CryptoNoter || exit
git add .
git commit -m "🌌 XR∞ Portale orbitale aggiornato con modulo scientifico BOINC e config.json corretto"
git push origin main

echo "🚀 Riavvio miner orbitale…"
pkill -f "node server.js"
node server.js &

echo "✅ Nodo XR∞ attivo su http://localhost:8180 con modulo scientifico integrato"
