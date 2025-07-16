---
date: '2025-07-14T20:16:59Z'
title: 'Endpoints Access Control'
linkTitle: "Endpoints ACL"
description: 'Documentation for Zero-TOTP Endpoints Access Control'
draft: false
---

## Authentication
Zero-TOTP ACLs are designed to control access to various API endpoints. The API uses a token-based authentication system. This token is named `access_token` and is provided through cookies after a successful login.

### Access token

The `access_token` is an uuid, stored server-side in the database, associated with a unique user account and generally valid for few minutes only. This token is used to authenticate requests to the API. 

### Refresh token

Alongside the `access_token`, the API also uses a `refresh_token`. The `refresh_token` is also an uuid, stored server-side in the database, associated with a unique user account and generally valid for a longer period (e.g., 24 hours). This token is associated to a unique `access_token`. 

The `refresh_token` should never be used in general requests to the API, but only to call the refresh endpoint. 

The `refresh_token` is sent to the user through cookies after a successful login.

### Refresh token flow 

The refresh token flow allows users to obtain a new access token without needing to re-authenticate. This is particularly useful for maintaining user sessions without requiring frequent logins and to keep the `access_token` validity as short as possible for security reasons.

When the user's `access_token` expires, the client must follow the following flow : 
1. PUT `/api/v1/auth/refresh` with the expired `access_token` and `refresh_token` in the request cookies. 
2. The API verifies 
    * The `refresh_token` is not expired. 
    * The `refresh_token` is not revoked. 
    * The `refresh_token` and `access_token` are associated with the same user account.
    * The `refresh_token` is associated with the given `access_token`.
3. If all checks pass the API:
    1. Generates a new `access_token` and `refresh_token`.
    2. Revokes the old `access_token` and `refresh_token` to prevent reuse.
    3. Returns the new `access_token` and `refresh_token` in the response cookies. **The new refresh token will have the SAME expiry as the previous one.**



The authentication process involves the following steps:
1. **User Login**: The user sends a login request with their credentials (username and hashed password).
2. **Token Generation**: Upon successful authentication, the server generates a unique token (UUID) and returns it to the user

## Authorization 
### Authorization handlers
The authorization is performed at 2 levels: 
- On the request arrival following the defined OpenAPI specs using the session checker defined in the [`api/CryptoClasses/session_verification.py:verify_session`](https://github.com/SeaweedbrainCY/zero-totp/blob/main/api/CryptoClasses/session_verification.py) function.
- On the request processing through the wrappers defined in [`api/Utils/security_wrapper.py`](https://github.com/SeaweedbrainCY/zero-totp/blob/main/api/Utils/security_wrapper.py)

### ACLs per endpoint

Zero-TOTP API defines 3 levels of authorization:
- `Anyone` : Anyone, everyone, even without any cookie.
- `Unverified user`: A user successfully authenticated with an **user token** but with an email not verified
- `Valid user`: A user successfully authenticated with a verified email.

|Endpoint   | `Anyone`  |`Unverified user`| `Valid user`  |  
|---|---|---|---|
| `/signup` |✅| ✅  |✅  | 
| `/login ` | ✅| ✅  |✅  | 
| `/login/specs` |  ✅| ✅  |✅  | 
| `/role` | ❌ | ✅  | ✅  | 
| `/update/email` | ❌ |  ✅ | ✅  | 
| `/email/verify` | ❌ |  ✅ | ✅  | 
| `/email/send_verification` | ❌ |  ✅ | ✅  | 
| `/zke_encrypted_key` | ❌ | ❌ | ✅  | 
| `/encrypted_secret/{uuid}` | ❌ | ❌ | ✅  | 
| `/all_secrets` | ❌ | ❌ | ✅  | 
| `/update/vault` | ❌ | ❌ | ✅  | 
| `/vault/export` | ❌ | ❌ | ✅  | 
| `/google-drive/oauth/authorization-flow` | ❌ | ❌ | ✅  | 
| `/google-drive/oauth/callback` | ❌ | ❌ | ✅  | 
| `/google-drive/option` | ❌ | ❌ | ✅  | 
| `/google-drive/backup` | ❌ | ❌ | ✅  | 
| `/google-drive/last-backup/verify` | ❌ | ❌ | ✅  | 
| `/account` | ❌ | ❌ | ✅  | 
| `/preferences` | ❌ | ❌ | ✅  | 

