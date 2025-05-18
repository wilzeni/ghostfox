#!/bin/bash

echo "[check_vpn.sh] Iniciando verificação da conexão VPN..."

VPN_INTERFACE="tun0"
TARGET="1.1.1.1"

while true; do
    if ip a | grep -q "$VPN_INTERFACE"; then
        if ping -I $VPN_INTERFACE -c 1 -W 2 $TARGET > /dev/null 2>&1; then
            echo "[check_vpn.sh] VPN ativa e funcional"
        else
            echo "[check_vpn.sh] VPN ativa, mas sem acesso externo ($TARGET indisponível)"
        fi
    else
        echo "[check_vpn.sh] Interface VPN ($VPN_INTERFACE) não detectada"
    fi
    sleep 10
done
