---
date: 2025-07-02T18:09:59-04:00

title: 'Setup your reverse proxy'
linkTitle: 1 -  Revproxy setup
weight: 3
cascade:
  type: docs
---


A reverse proxy is mandatory to serve Zero-TOTP. **The API is not designed to be served directly over the internet.** You can use any reverse proxy you want, the following examples uses Nginx and Caddy, but any reverse proxy will work as long as it can serve the frontend and API over HTTPS and handle `X-Forwarded-*` headers (see below).

### General considerations

No matter which reverse proxy you choose, the following considerations must be taken into account:

**Routing and domain considerations :**
- The frontend and the API must be served on the same domain.
- Routes must be configured to serve the frontend at `/` and the API at `/api/`. 

**Security considerations :**
- The frontend and API over HTTPS. This is mandatory to enabled the security features of Zero-TOTP.
- For security reasons the reverse proxy must overwrites the X-Forwarded-For header with the real remote ip. 

> [!warning]
> Be careful to X-Forwarded-For that can be spoofed and must not be trusted. Zero-TOTP API is not meant to deal with a list of forwarded IP. The reverse proxy must keep the right one. Please refer to the documentation of your reverse proxy to see how to configure it properly.
>
> A special guide for revproxy behind Cloudflare is available below.

> [!important]
> A bad configuration of the reverse proxy can lead to serious security issues. If you are not sure how to configure your reverse proxy, please use the provided examples, refer to the documentation of your reverse proxy or ask for help in the [Zero-TOTP Discord server](https://discord.gg/77JrdbxNZD).


### Caddy example 
We are considering the API/frontend are running on the same server and the docker compose is configured to expose the API on port `8080` and the frontend on port `4200`. Adapt the IP and port to your setup.

Here is an example of a caddyfile that can be used to serve Zero-TOTP :

```caddyfile {filename="Caddyfile"}
https://zero-totp.example.com {

    // Serve the API
    reverse_proxy /api/* 127.0.0.1:8080 {
      header_up X-Forwarded-For {client_ip}
    }

    reverse_proxy 127.0.0.1:4200 
}
```
This is a basic configuration, make sure to adapt it to your needs. You can find more information on the [Caddy documentation](https://caddyserver.com/docs/).


### Nginx example
Here is an example of an Nginx configuration that can be used to serve Zero-TOTP. This configuration assumes the API is running on port `8080` and the frontend on port `4200`. Adapt the IP and port to your setup.

```nginx {filename="nginx.conf"}
server {
    listen 80;
    server_name zero-totp.example.com;

    # Redirect HTTP to HTTPS
    return 301 https://$host$request_uri;
}
server {
    listen 443 ssl;
    server_name zero-totp.example.com;

    # SSL configuration
    ssl_certificate /path/to/your/certificate.crt;
    ssl_certificate_key /path/to/your/private.key;

    # Serve the API
    location /api/ {
        proxy_pass http://127.0.1:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $remote_addr;
    }

    # Serve the frontend
    location / {
        proxy_pass http://127.0.1:4200;
    }
}
```
This is a basic configuration, make sure to adapt it to your needs. You can find more information on the [Nginx documentation](https://nginx.org/en/docs/). Note that nginx does not handle TLS termination by itself, you will need to use a tool like [Certbot](https://certbot.eff.org/) to obtain and renew your SSL certificates.

### Reverse proxy behind Cloudflare
Cloudflare adds the `X-Forwarded-For` header if it does not exist, and if it does exist it will just append another IP to it. This means a client can forge their remote IP address with the most widely accepted remote IP header out of the box. 

To prevent this, 2 solution are available: 
- Do NOT use the `X-Forwarded-For` header, but use the `CF-Connecting-IP` header instead. This is the recommended solution. (See the [Cloudflare documentation](https://developers.cloudflare.com/fundamentals/reference/http-headers/#cf-connecting-ip) for more information).
- Follow this guide from [Authelia's team](https://www.authelia.com/integration/proxies/forwarded-headers/) to configure cloudflare to safely handle the `X-Forwarded-For` header. 