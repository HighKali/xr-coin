#!/bin/bash
echo "🖥️ Aggiornamento dashboard XR∞"
cd ~/xrcoin
python3 -m http.server 8080 &
xdg-open http://localhost:8080
