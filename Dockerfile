FROM debian:11-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1

RUN apt-get update && apt-get install -y \
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
    libgl1-mesa-dri \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libatk1.0-0 \
    libgtk-3-0 \
    libasound2 \
    libnss3 \
    libxss1 \
    libxtst6 \
    libx11-xcb1 \
    fonts-liberation \
    xdg-utils \
    pulseaudio \
    dbus-x11 \
    net-tools \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN wget -qO /tmp/turbovnc.deb https://sourceforge.net/projects/turbovnc/files/latest/download && \
    apt-get install -y /tmp/turbovnc.deb && \
    rm /tmp/turbovnc.deb

RUN useradd -m ghostfox
RUN mkdir -p /etc/supervisor/conf.d /scripts /vpn
COPY supervisord.conf /etc/supervisor/supervisord.conf
COPY scripts/ /scripts/
COPY vpn/ /vpn/
COPY browser-profile/ /home/ghostfox/.config/chromium/Default/
RUN chown -R ghostfox:ghostfox /home/ghostfox

USER ghostfox
WORKDIR /home/ghostfox

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
