# 🦊 Ghostfox v4 – Navegador Isolado com VPN em Container Docker

**Ghostfox** é um container Docker baseado em **Debian 11 slim**, que oferece um ambiente de navegação com **Chromium** isolado e protegido por **VPN**, acessível **exclusivamente via VNC pela rede local**.

---

## 📦 Tecnologias Utilizadas

| Componente        | Tecnologia             |
|------------------|------------------------|
| Sistema base      | Debian 11 slim         |
| Navegador         | Chromium               |
| VPN               | OpenVPN (`.ovpn` + auth) |
| Acesso gráfico    | TurboVNC               |
| Gerenciador X     | Xorg + Fluxbox         |
| Supervisão        | supervisord            |
| Acesso externo    | ❌ Desativado           |
| Acesso local      | ✅ Via VNC na porta 5901 |

---

## 📁 Estrutura de Arquivos

```
ghostfox/
├── Dockerfile
├── docker-compose.yml
├── supervisord.conf
├── scripts/
│   ├── start.sh
│   └── check_vpn.sh
├── vpn/
│   ├── connection.ovpn
│   └── credentials.txt
├── browser-profile/
│   └── ... (perfil Chromium)
└── README.md
```

---

## 🚀 Como Usar

### 1. Clonar ou copiar o repositório

```bash
git clone https://github.com/seuusuario/ghostfox.git
cd ghostfox
```

### 2. Adicionar arquivos da VPN

Coloque seu arquivo `.ovpn` e `credentials.txt` no diretório `vpn/`.

- `connection.ovpn`: arquivo de configuração da VPN
- `credentials.txt`: usuário e senha (duas linhas)

### 3. Build e start do container

```bash
docker compose build
docker compose up -d
```

---

## 📡 Acesso ao Navegador

Use um cliente **VNC** (ex: RealVNC, Remmina, TightVNC Viewer):

- **IP**: IP do host Debian
- **Porta**: `5901`
- **Senha**: (define manualmente no primeiro uso via `vncpasswd` se desejar)

---

## 🔧 Comandos Úteis

```bash
# Parar o container
docker compose down

# Ver logs do supervisor
docker logs -f ghostfox-v4
```

---

## 🛡️ Segurança

- O container **não é exposto à internet**.
- O tráfego do navegador **passa apenas pela VPN**.
- O acesso é permitido **somente via VNC na LAN**.

---

## 📝 Observações

- O Chromium é iniciado com parâmetros otimizados para containers (`--no-sandbox`, `--disable-gpu`, etc.).
- A verificação da VPN roda em loop via `check_vpn.sh` e é logada.
- Recomendado uso em rede protegida ou VLAN específica.