# Ghostfox v4.9 com suporte a TurboVNC + GPU

# Base Image
FROM debian:11-slim

# Variáveis de Ambiente
ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:2

# Instalação de dependências básicas
RUN apt-get update && apt-get install -y \
    procps \
    xorg \
    fluxbox \
    chromium \
    openvpn \
    supervisor \
    curl \
    wget \
    unzip \
    gnupg \
    ca-certificates \
    x11-xserver-utils \
    xauth \
    libgl1-mesa-dri \
    libgl1-mesa-glx \
    mesa-utils \
    libegl1 \
    libnss3 \
    libasound2 \
    libxss1 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libatk1.0-0 \
    libgtk-3-0 \
    libx11-xcb1 \
    fonts-liberation \
    xdg-utils \
    pulseaudio \
    dbus-x11 \
    net-tools \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Configuração de timezone e locale
RUN apt-get update && apt-get install -y tzdata locales && \
    ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    sed -i 's/# pt_BR.UTF-8 UTF-8/pt_BR.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen && \
    update-locale LANG=pt_BR.UTF-8

# Exporta as variáveis no ambiente
ENV LANG=pt_BR.UTF-8
ENV LANGUAGE=pt_BR:pt
ENV LC_ALL=pt_BR.UTF-8

# Instalação do TurboVNC
RUN wget -qO /tmp/turbovnc.deb https://downloads.sourceforge.net/project/turbovnc/2.2.6/turbovnc_2.2.6_amd64.deb && \
    apt-get install -y /tmp/turbovnc.deb && rm /tmp/turbovnc.deb

# Instalação do VirtualGL
RUN wget -qO /tmp/virtualgl.deb https://downloads.sourceforge.net/project/virtualgl/3.0.2/virtualgl_3.0.2_amd64.deb && \
    apt-get install -y /tmp/virtualgl.deb && rm /tmp/virtualgl.deb

# Diretórios essenciais
RUN mkdir -p /etc/supervisor/conf.d /scripts /vpn /root/logs /root/.vnc

# Definir senha do VNC para root
RUN echo "devsc1" | /opt/TurboVNC/bin/vncpasswd -f > /root/.vnc/passwd && chmod 600 /root/.vnc/passwd

# Copia arquivos locais para o container
COPY supervisord.conf /etc/supervisor/supervisord.conf
COPY scripts/ /scripts/
COPY vpn/ /vpn/

RUN chmod +x /scripts/*.sh

# WORKDIR
WORKDIR /root

# Comando padrão
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
