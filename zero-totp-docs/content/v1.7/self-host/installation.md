---
date: 2025-07-09T21:22:19+00:00

title: 'Install Zero-TOTP'
linkTitle: Installation
weight: 1
cascade:
  type: docs
---

Zero-TOTP supports installation via Docker. This guide will help you to set up Zero-TOTP on your server.

## Requirements 
To self-host Zero-TOTP, you need the following components:
- Docker (and docker compose for easier management)

## Installation via docker-compose
Create the following `docker-compose.yml` : 


```yaml {filename="docker-compose.yml"}
services:
  frontend:
    container_name: frontend
    image: ghcr.io/seaweedbraincy/zero-totp-frontend:1.7
    user: "101:101"
    ports:
      - 4200:80
    volumes:
      - ./frontend/log:/var/log/nginx
    restart: always

  api:
    container_name: api
    image: ghcr.io/seaweedbraincy/zero-totp-api:1.7
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
      MYSQL_ROOT_PASSWORD: weak_password ## CHANGE_ME
      MYSQL_DATABASE: zero_totp
      MYSQL_USER: api
      MYSQL_PASSWORD: weak_password ## CHANGE_ME
    image:  mariadb:latest
    container_name: database
    ports:
      - "3306:3306"
    volumes:
      - ./database/data:/var/lib/mysql
      - ./database/config:/etc/mysql
    restart: always
```

> [!warning]
> Make sure to change the `MYSQL_ROOT_PASSWORD` and `MYSQL_PASSWORD` to a strong password.
