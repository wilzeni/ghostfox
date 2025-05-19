#!/bin/bash

# Script de verificação da VPN
# Realiza ping periódico a um IP conhecido via tun0

VPN_INTERFACE="tun0"
TARGET="1.1.1.1"

echo "[check_vpn.sh] Iniciando verificação da conexão VPN..."

while true; do
    if ip a | grep -q "$VPN_INTERFACE"; then
        if ping -I "$VPN_INTERFACE" -c 1 -W 2 "$TARGET" > /dev/null 2>&1; then
            echo "[$(date '+%Y-%m-%d %H:%M:%S')] [check_vpn.sh] Conexão VPN estável com $TARGET"
        else
            echo "[$(date '+%Y-%m-%d %H:%M:%S')] [check_vpn.sh] VPN ativa, mas sem acesso externo ($TARGET indisponível)"
        fi
    else
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] [check_vpn.sh] Interface VPN ($VPN_INTERFACE) não detectada"
    fi
    sleep 10
done
