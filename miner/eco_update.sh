#!/data/data/com.termux/files/usr/bin/bash
# 🔁 Script orbitale per aggiornare XR∞ Miner

echo "🧹 Pulizia e aggiornamento in corso…"

cd ~/CryptoNoter || exit
pkill -f "node server.js"
rm -rf node_modules
npm install

echo "📦 Aggiorno GitHub…"
git add .
git commit -m "🔁 Portale orbitale XR∞ aggiornato con modulo scientifico BOINC"
git push origin main

echo "🚀 Riavvio miner orbitale…"
node server.js &

echo "✅ Nodo XR∞ aggiornato e attivo su http://localhost:8180"
