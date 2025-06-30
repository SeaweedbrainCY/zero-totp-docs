---
date: '2025-06-30T00:48:44Z'
draft: true
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



## Setting a reverse proxy

Setting up a reverse proxy is mandatory to expose Zero-TOTP's frontend and API. 

!!! Danger  
    For security reasons the reverse proxy must **overwrites** the `X-Forwarded-For` header with the real remote ip. Be careful to `X-Forwarded-For` that can be spoofed and must not be trusted (cf [Eli's Notes](https://esd.io/blog/flask-apps-heroku-real-ip-spoofing.html)). Zero-TOTP API is not meant to deals a list of forwarded IP. The reverse proxy must keep the right one.