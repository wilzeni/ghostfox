#!/bin/bash
echo "[start.sh] Aguardando servidor X (:1)..."
until xdpyinfo -display :1 >/dev/null 2>&1; do
    sleep 1
done

echo "[start.sh] Servidor X disponível. Iniciando Chromium..."

chromium \
    --no-sandbox \
    --disable-gpu \
    --disable-software-rasterizer \
    --disable-dev-shm-usage \
    --disable-extensions \
    --start-maximized \
    --password-store=basic \
    --user-data-dir=/home/ghostfox/.config/chromium \
    "https://duckduckgo.com" &

tail -f /dev/null
