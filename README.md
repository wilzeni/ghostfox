# Ghostfox v4.3

Ghostfox é um ambiente containerizado para navegação web segura através de VPN, com interface gráfica acessível via VNC. A versão 4.3 introduz melhorias de conectividade, simplificação de permissões e ajustes na arquitetura interna para maior estabilidade.

## 🆕 Novidades da Versão 4.3

- 🧩 **TurboVNC com interface aberta:** agora configurado com `-interface 0.0.0.0` via supervisord, permitindo conexões externas com maior compatibilidade.
- 👤 **Execução como root:** não é mais criado um usuário `ghostfox`; todo o sistema do container roda sob o usuário root para evitar conflitos de permissões e facilitar integrações.
- 🔒 **VPN com permissão para tun:** o container garante a criação da interface `tun0`, garantindo o roteamento de rede via VPN.
- 🔁 **Padrão de configuração mantido:** arquivos `connection.ovpn` e `credentials.txt` continuam sendo o método principal de configuração da conexão VPN, facilitando compatibilidade com versões anteriores.

---

## 📦 Estrutura do Projeto

```plaintext
ghostfox-v4.3/
├── docker-compose.yml
├── Dockerfile
├── scripts/
│   ├── start_vnc.sh
│   ├── start_vpn.sh
│   └── check_vpn.sh
├── vpn/
│   ├── connection.ovpn
│   └── credentials.txt
├── supervisord.conf
└── README.md
```

---

## 🚀 Instruções Rápidas

1. **Clonar o projeto**
```bash
git clone https://github.com/seuusuario/ghostfox-v4.3.git
cd ghostfox-v4.3
```

2. **Adicionar arquivos da VPN**
- Copie seu arquivo `.ovpn` para `vpn/connection.ovpn`
- Copie suas credenciais para `vpn/credentials.txt` no formato:
  ```
  usuarioVPN
  senhaVPN
  ```

3. **Buildar a imagem**
```bash
docker compose build
```

4. **Subir o container**
```bash
docker compose up -d
```

5. **Conectar via VNC**
- IP: `localhost`
- Porta: `5901`
- Senha padrão: `ghostfox` *(alterável no script ou no Dockerfile)*

---

## ⚙️ Requisitos

- Docker 20+
- docker-compose 1.27+
- Sistema com suporte a `/dev/net/tun` e permissões para `CAP_NET_ADMIN`

---

## 📌 Notas Técnicas

- A execução como root evita problemas com permissões ao acessar dispositivos e iniciar serviços como VNC ou VPN.
- O TurboVNC escutando em `0.0.0.0` melhora a compatibilidade com redes externas, sem a necessidade de configuração extra de NAT local.
- A pasta `browser-profile` não está mais fixada por padrão, mas pode ser montada manualmente se desejar persistência de sessão.

---

## 📄 Licença

MIT - Feito com dedicação por [Seu Nome/GitHub]