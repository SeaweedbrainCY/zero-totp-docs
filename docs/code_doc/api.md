# API Endpoints 
## API Documentation

The API's endpoints are defined according to the OpenAPI specs. [See the swagger](http://api.zero-totp.com/ui)

## Authorization
We define 4 levels of authorization: 

- `Anyone` : Everyone can query this endpoint, even without any cookie.
- `Unverified user`: A user successfully authenticated with an **user token** but with an email not verified
- `Valid user`: A user successfully authenticated with a verified email.
- `Admin role` : A user with an admin role and a user API token.
- `Admin token`: An user with an admin role, a user API token and **an admin token**.

|Endpoint   | `Anyone`  |`Unverified user`| `Valid user`  |   `Admin role` | `Admin token` |
|---|---|---|---|---|---|
|  /signup |✅| ✅  |✅  | ✅  |  ✅ |
|  /login | ✅| ✅  |✅  | ✅  |  ✅ |
|  /login/specs |  ✅| ✅  |✅  | ✅  |  ✅ |
| /role| ❌ | ✅  | ✅  | ✅  |  ✅ |
| /update/email | ❌ |  ✅ | ✅  | ✅  |  ✅ |
| /email/verify| ❌ |  ✅ | ✅  | ✅  |  ✅ |
| /email/send_verification | ❌ |  ✅ | ✅  | ✅  |  ✅ |
| /zke_encrypted_key | ❌ | ❌ | ✅  | ✅  |  ✅ |
| /encrypted_secret/{uuid} | ❌ | ❌ | ✅  | ✅  |  ✅ |
| /all_secrets | ❌ | ❌ | ✅  | ✅  |  ✅ |
| /update/vault | ❌ | ❌ | ✅  | ✅  |  ✅ |
| /vault/export | ❌ | ❌ | ✅  | ✅  |  ✅ |
| /google-drive/oauth/authorization-flow | ❌ | ❌ | ✅  | ✅  |  ✅ |
| /google-drive/oauth/callback | ❌ | ❌ | ✅  | ✅  |  ✅ |
| /google-drive/option  | ❌ | ❌ | ✅  | ✅  |  ✅ |
| /google-drive/backup| ❌ | ❌ | ✅  | ✅  |  ✅ |
| /google-drive/last-backup/verify | ❌ | ❌ | ✅  | ✅  |  ✅ |
| /account  | ❌ | ❌ | ✅  | ✅  |  ✅ |
| /preferences| ❌ | ❌ | ✅  | ✅  |  ✅ |
| /admin/login | ❌ | ❌ | ❌ |  ✅  |  ✅ |
| /admin/users  | ❌ | ❌ | ❌ | ❌  |  ✅ |
| /admin/account/{account_id_to_delete} | ❌ | ❌ | ❌ | ❌  |⚠️*|

- *⚠️\* Only if this action is explicitly authorized on API startup via command line*
- By default, blocked user are denied to login and by all endpoint not open to anyone