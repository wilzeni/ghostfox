# Ghostfox v4.9

Ghostfox é um container Docker que oferece um ambiente seguro para navegação web via navegador Chromium, utilizando VPN e acesso remoto por VNC.

Esta versão é um **refinamento da v4.0**, com melhorias voltadas para robustez, estabilidade e replicabilidade sem conhecimento técnico por parte do usuário final.

---

## 🆕 Novidades da versão 4.9

- 🔁 **Migração do Xvnc para TurboVNC + GPU**, para uma melhor performance e mais recursos
- 🧩 **Extensão ghost-stealth**, Esconde sinais de automação do navegador e Spoof do Navigator
- 🚫 Bloqueio de vazamento de ip via WebRTC
- 🌍 Mudança no locale e timezone para ptbr
- 🖥️ Ajuste da resolução e dpi

---

## 📦 Estrutura do Projeto

```plaintext
ghostfox-v4.9/
├── docker-compose.yml
├── Dockerfile
├── supervisord.conf
├── README.md
├── scripts/
│   ├── check_vpn.sh
│   └── start.sh
├── vpn/
│   ├── connection.ovpn
│   └── credentials.txt
├── extensions/
|    ├── ghost-stealth/
|         ├── background.js
|         ├── content.js
|         └── manifest.json
```

---

## 🚀 Instalação e Execução

1. **Clone ou extraia o projeto**

```bash
git clone https://github.com/seuprojeto/ghostfox-v4.9.git
cd ghostfox-v4.9
```

2. **Adicione os arquivos de VPN**

- Coloque o seu `.ovpn` dentro da pasta `vpn/` como `connection.ovpn`
- Crie o arquivo `credentials.txt` contendo:
```
usuarioVPN
senhaVPN
```

3. **(Opcional) Ajuste a faixa de rede local**

No arquivo `scripts/start.sh`, altere a linha:
```bash
LOCAL_NETWORK="192.168.0.0/24"
```
> Substitua pela faixa da VLAN que usará para acessar o container (ex: `192.168.1.0/24` ou `10.0.0.0/24`)

4. **Build e execução**

```bash
docker compose build
docker compose up -d
```

5. **Acesso via VNC**

- IP: `localhost`
- Porta: `5901`
- Senha: `ghostfox`
- Protocolo: VNC Authentication (sem TLS)

---

## 🛠️ Requisitos

- Docker 20+
- docker-compose 1.27+
- Suporte a `/dev/net/tun` no host
- Permissões de `CAP_NET_ADMIN` ativadas no container
- VPN limitada somente para o Brasil

---

## 📌 Considerações Técnicas

- **A extensão Ghost Stealth** é responsável por camuflar características do navegador e do sistema operacional que são frequentemente exploradas por técnicas de fingerprinting (coleta de impressões digitais do navegador) e deteção de automação/bots, intercepta e modifica APIs JavaScript usadas para coletar informações do ambiente do usuário. Ele age como uma camada de camuflagem, tornando o navegador mais parecido com o de um humano real.
- **WebRTC (IP Leaking Protection):** O WebRTC permite comunicação em tempo real entre navegadores, mas também pode expor o endereço IP real do dispositivo, mesmo quando conectado via VPN ou proxy. A extensão protege contra técnicas de WebRTC IP leak, que sites usam para verificar se você está usando proxy/VPN, ou para identificar múltiplos usuários por trás da mesma rede.
- **Locale e Timezone:** Muitos sites usam o fuso horário (timezone) e as configurações regionais (locale, como idioma, formatos de data/hora e moeda) como parte do fingerprint do navegador. Ao definir o sistema e o navegador para usarem pt-BR e fuso horário de São Paulo, o ambiente se torna coerente com um usuário real brasileiro, reduzindo significativamente a probabilidade de bloqueios ou desafios (CAPTCHAs, bloqueios de sessão, etc).
- A adição automática da rota via gateway Docker evita que a VPN corte o acesso VNC.
- O `start.sh` agora inclui lógica para detectar o gateway e aplicar a rota dinamicamente.

---

## 📄 Licença

MIT - Desenvolvido com foco em automação e privacidade
