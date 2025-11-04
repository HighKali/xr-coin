#!/bin/bash

echo "🛠️ XR∞ TERMINATOR PUBBLICATORE — AVVIO COMPLETO"

# Configura Git (solo la prima volta)
git config --global user.name "highkali"
git config --global user.email "xdsn.miner@gmail.com"

# Rigenera index.html con dashboard e WebMiner
echo "🌐 Ricompilo index.html con interfaccia orbitale…"
cat <<EOF > ~/xrcoin/index.html
<!DOCTYPE html>
<html lang="it">
<head>
  <meta charset="UTF-8">
  <title>XR∞Miner Dashboard</title>
  <style>
    body { background: #111; color: #0f0; font-family: monospace; text-align: center; }
    a { color: #0ff; text-decoration: none; }
    button { padding: 10px; margin: 10px; background: #222; color: #0f0; border: 1px solid #0f0; }
  </style>
</head>
<body>
  <h1>🚀 XR∞Miner Dashboard</h1>
  <p>Mining orbitale interamente per XMR, ETH, BCN, QR connection. 100% payout verso wallet personale.</p>

  <button onclick="window.location.href='http://localhost:7777'">🌐 Avvio WebMiner</button>
  <button onclick="alert('Selettore Moneta non ancora implementato')">💱 Selettore Moneta</button>

  <h2>📡 Monitor API Miner</h2>
  <p id="api">Caricamento dati real-time...</p>

  <h2>🌌 Pool Orbitale XR∞</h2>
  <p>Estremamente al neutro poi decentralizzato.</p>

  <p><a href="https://github.com/HighKali/xr-coin">📦 Codice sorgente su GitHub</a></p>
  <p><em>Ultimo aggiornamento: $(date)</em></p>

  <script>
    setInterval(() => {
      document.getElementById("api").innerText = "Miner attivo su localhost:7777";
    }, 3000);
  </script>
</body>
</html>
EOF

# Commit e push su GitHub
echo "📤 Commit e push su GitHub…"
cd ~/xrcoin
git add index.html
git commit -m "🌐 Homepage orbitale XR∞ aggiornata con WebMiner"
git push origin main

# Avvia server locale
echo "🖥️ Avvio server locale su http://localhost:8080"
python3 -m http.server 8080 &

# Apri nel browser (solo su WSL/Linux)
if command -v xdg-open &> /dev/null; then
  xdg-open http://localhost:8080
fi

echo "✅ Pubblicazione completata. Homepage XR∞ aggiornata e visibile."
