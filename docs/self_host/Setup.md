# Setup
## Setting a reverse proxy

Setting up a reverse proxy is mandatory to expose Zero-TOTP's frontend and API. 

!!! Danger  
    For security reasons the reverse proxy must **overwrites** the `X-Forwarded-For` header with the real remote ip. Be careful to `X-Forwarded-For` that can be spoofed and must not be trusted (cf [Eli's Notes](https://esd.io/blog/flask-apps-heroku-real-ip-spoofing.html)). Zero-TOTP API is not meant to deals a list of forwarded IP. The reverse proxy must keep the right one.