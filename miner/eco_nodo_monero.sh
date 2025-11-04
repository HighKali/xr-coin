#!/data/data/com.termux/files/usr/bin/bash

echo "🚀 [XR∞] Inizio rituale nodo Monero..."

# 📦 Dipendenze
pkg update -y
pkg install -y wget tar

# 🌐 Scarica Monero CLI (ARMv8)
wget https://downloads.getmonero.org/cli/monero-linux-armv8-v0.18.3.1.tar.bz2

# 📦 Estrai
tar -xvf monero-linux-armv8-v0.18.3.1.tar.bz2
cd monero-linux-armv8-v0.18.3.1

# 🔥 Avvia il nodo
echo "⛏️ Avvio monerod..."
./monerod --non-interactive --detach

echo "✅ Nodo Monero avviato in background"
echo "🌐 Accessibile su porta 18081 (RPC) e 18080 (P2P)"
