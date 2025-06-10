---
title: Installation
---

# Zero-TOTP installation
Zero-TOTP supports installation via Docker. This guide will help you to set up Zero-TOTP on your server.
## Requirements 
- Docker 

## Installation via docker 
### Docker compose (recommended)
Create the following `docker-compose.yml` : 
```yaml title="docker-compose.yml" linenums="1"
services:
  frontend:
    container_name: frontend
    image: ghcr.io/seaweedbraincy/zero-totp-frontend:1.6.3
    user: "101:101"
    ports:
      - 4200:80
    volumes:
      - ./frontend/log:/var/log/nginx
    restart: always

  api:
    container_name: api
    image: ghcr.io/seaweedbraincy/zero-totp-api:1.6.3
    environment:
      USER_UID: 1001
      USER_GID: 1001
    ports:
      - 8080:8080
    volumes:
      - ./api/secret:/api/secret
      - ./api/logs:/api/logs
      - ./api/config:/api/config
    restart: always


  database:
    environment:
      MYSQL_ROOT_PASSWORD: ## CHANGE_ME
      MYSQL_DATABASE: zero_totp
      MYSQL_USER: api
      MYSQL_PASSWORD: ## CHANGE_ME
    image:  mariadb:latest
    container_name: database
    ports:
      - "3306:3306"
    volumes:
      - ./database/data:/var/lib/mysql
      - ./database/config:/etc/mysql
    restart: always
```


### Docker run
Run the following commands to start the 3 Zero-TOTP components (frontend, api, database) : 
```bash
# Frontend
docker run --name frontend -u 101:101 -p 4200:80 -v ./frontend/log:/var/log/nginx --restart always ghcr.io/seaweedbraincy/zero-totp-frontend:1.6.3

# API
docker run --name api -p 8080:8080 -v ./api/secret:/api/secret -e USER_UID=1001 -e USER_GID=1001 -v ./api/log:/api/logs -v ./api/config:/api/config --restart always ghcr.io/seaweedbraincy/zero-totp-api:1.6.3 

# Database
docker run -e MYSQL_ROOT_PASSWORD=CHANGE_ME -e MYSQL_DATABASE=zero_totp -e MYSQL_USER=api -e MYSQL_PASSWORD=CHANGE_ME --name database -p 3306:3306 -v ./database/data:/var/lib/mysql -v ./database/config:/etc/mysql --restart always mariadb:latest
```

## Setting a reverse proxy

Setting up a reverse proxy is mandatory to expose Zero-TOTP's frontend and API. 

!!! Danger  
    For security reasons the reverse proxy must **overwrites** the `X-Forwarded-For` header with the real remote ip. Be careful to `X-Forwarded-For` that can be spoofed and must not be trusted (cf [Eli's Notes](https://esd.io/blog/flask-apps-heroku-real-ip-spoofing.html)). Zero-TOTP API is not meant to deals a list of forwarded IP. The reverse proxy must keep the right one.