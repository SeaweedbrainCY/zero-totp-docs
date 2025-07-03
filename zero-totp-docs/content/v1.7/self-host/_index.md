---
date: '2025-06-30T00:42:57Z'

title: 'Self-hosting Zero-TOTP'
cascade:
  type: docs
---
Zero-TOTP is one of the most secure and easy way to store TOTP codes. For a maximum security, you can easily self-host Zero-TOTP yourself and control 100% of your data, installation, configuration and updates.

This guide will help you to install and configure Zero-TOTP on your server. 

The self-hosting is designed to implement as much as default security features as possible. However, configuration is the key to a secure and reliable Zero-TOTP instance. 

Before starting, make sure to be confortable with the following concepts:
- Docker and docker-compose
- Reverse proxy (Nginx, Traefik, Caddy, etc.)
- Basic Linux commands
- Yaml syntax

> [!tip]
> If you have any question or doubt, you can ask for help in the [Zero-TOTP Discord server](https://discord.gg/77JrdbxNZD) or in the [Zero-TOTP GitHub discussions](https://github.com/SeaweedbrainCY/zero-totp/discussions) 


{{< cards >}}
  {{< card link="./installation" title="Installation" icon="download" tag="mandatory" >}}
  {{< card link="./setup" title="Setup" icon="cog" tag="mandatory" >}}
  {{< card link="./customization" title="Customization" icon="adjustments" tag="recommended" >}}
{{< /cards >}}
