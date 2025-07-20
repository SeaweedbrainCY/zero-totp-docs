---
date: 2025-07-16T14:29:30+00:00

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
    image: ghcr.io/seaweedbraincy/zero-totp-frontend:1.9
    environment:
      USER_UID: 101
      USER_GID: 101
    ports:
      - 4200:80
    volumes:
      - ./frontend/log:/var/log/nginx
    restart: always

  api:
    container_name: api
    image: ghcr.io/seaweedbraincy/zero-totp-api:1.9
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
    image:  mariadb:11
    container_name: database
    ports:
      - "127.0.0.1:3306:3306"
    volumes:
      - ./database/data:/var/lib/mysql
      - ./database/config:/etc/mysql
    restart: always
```

> [!warning]
> Make sure to change the `MYSQL_ROOT_PASSWORD` and `MYSQL_PASSWORD` to a strong password.

## How images tags work 
Official and stable releases of Zero-TOTP are disclosed in [Github releases page](https://github.com/SeaweedbrainCY/zero-totp/releases). 

They always work with the same version of the API and the frontend. Version tag format is `vX.Y.Z` where `X` is the major version, `Y` is the minor version and `Z` is the patch version. 

Each new release is always associated with 3 tags:
- `X.Y.Z`, the last exact stable version of Zero-TOTP.
- `X.Y`, the last stable version of Zero-TOTP. You can safely use this and regularly upgrade to get the last patches, without worrying about breaking changes.
- `latest`, the last stable version of Zero-TOTP. 

> [!note]
> It is highly recommended to use the `X.Y` tag to ensure you are always using the latest stable version of Zero-TOTP without worrying about breaking changes.
>
> Using `latest` tag is not recommended as it may lead to unexpected breaking changes if a new major version is released.
