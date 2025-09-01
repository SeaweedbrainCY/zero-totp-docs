FROM docker.io/hugomods/hugo:debian AS builder

COPY zero-totp-docs /src 
COPY utilities /utilities

WORKDIR /utilities

RUN chmod +x  generate_latest.sh

RUN ./generate_latest.sh

WORKDIR /src

RUN hugo --minify --gc --cleanDestinationDir --destination /src/public


FROM caddy:alpine 

COPY --from=BUILDER /src/public /usr/share/caddy
COPY ./utilities/Caddyfile /etc/caddy/Caddyfile

EXPOSE 80
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
