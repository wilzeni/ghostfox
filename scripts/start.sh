#!/bin/bash
export DISPLAY=:2

# Detecta o gateway da rede Docker (interface eth0)
DOCKER_GATEWAY=$(ip route | awk '/default/ && /eth0/ {print $3}')
LOCAL_NETWORK="192.168.0.0/24"

# Adiciona a rota local para manter VNC funcional com VPN ativa
echo "[start.sh] Adicionando rota local para $LOCAL_NETWORK via $DOCKER_GATEWAY"
ip route add "$LOCAL_NETWORK" via "$DOCKER_GATEWAY" || echo "[start.sh] Rota já existente ou falha ignorável"

# Espera o X server ficar disponível
echo "[start.sh] Aguardando servidor X (:2)..."
until xdpyinfo -display :2 >/dev/null 2>&1; do
    sleep 1
done

echo "[start.sh] Servidor X disponível. Iniciando Chromium com suporte a GPU via VirtualGL..."

# Executa Chromium com aceleração gráfica e extensões anti-fingerprint
vglrun -display :2 chromium \
    --no-sandbox \
    --start-maximized \
    --force-webrtc-ip-handling-policy=disable_non_proxied_udp \
    --load-extension=/root/extensions/ghost-stealth \
    --password-store=basic \
    --user-data-dir=/root/.config/chromium \
    "https://google.com.br" \ 
    > /root/logs/chromium.out 2>&1 &

# Garante que senha VNC esteja configurada
if [ ! -f /root/.vnc/passwd ]; then
    echo "[start.sh] Senha VNC não encontrada. Criando senha padrão..."
    echo "ghostfox" | /opt/TurboVNC/bin/vncpasswd -f > /root/.vnc/passwd
    chmod 600 /root/.vnc/passwd
fi

# Impede que o script morra e encerre o supervisor
tail -f /dev/null &
TAIL_PID=$!
