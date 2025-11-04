#!/usr/bin/env python3
import datetime
import requests

log = f"[XR∞LOG] {datetime.datetime.now()} - Pool avviato correttamente"
print(log)

# Telegram (opzionale)
# requests.get(f"https://api.telegram.org/bot<TOKEN>/sendMessage?chat_id=<CHAT_ID>&text={log}")

# Matrix (opzionale)
# requests.post("https://matrix.org/_matrix/client/r0/rooms/<ROOM_ID>/send/m.room.message", json={"msgtype":"m.text","body":log})
