# Customize your Zero-TOTP instance 

## API customization
### 


| Field | type | Mandatory | Default | Description |
|-------|-------|-----------|---------|-------------| 
| `api.port` | int | *optional* | `8080` | The port on which the API will listen |
| `api.trusted_proxy` | list | *optional* | `[]` | List of IP addresses or CIDR of your trusted reverseproxy that are in front of Zero-TOTP and will forward requests. This is essential to retrieve the real IP of your client and a misconfiguration can cause security issue. [Read this before anything else](https://esd.io/blog/flask-apps-heroku-real-ip-spoofing.html) |
| `api.jwt_secret` | string | **mandatory** | ` ` | A random 128 alphanumeric char string used to sign JWT tokens. [Safe generation tool](https://tools.stchepinsky.net/token-generator?length=128) |
| `api.private_key_path` | string | **mandatory** | `".secret/private.pem"` |  Absolute path to the API private key used to sign vaults to guarantee their authenticity.  This must be a PEM encoded RSA private key. **If the file does not exist, it will be generated at startup.** |
| `api.public_key_path` | string |**mandatory** |  `".secret/public.pem"` | Absolute path to the API public key used to verify vaults authenticity. This must be a PEM encoded RSA public key. **If the file does not exist, it will be generated at startup.** |
| `api.flask_secret_key` | string | **mandatory** | ` ` |  A random 128 alphanumeric char string used to encrypt flask session.  [Safe generation tool](https://tools.stchepinsky.net/token-generator?length=128)  |
| `api.server_side_encryption_key` | string | **mandatory** | ` ` |  A random 128 alphanumeric char string used to encrypt data stored in the database that is not Encrypted by default by the ZKE flow. **BE CAREFULL WITHOUT THIS KEY SOME OF SAVED DATA WILL BE UNREADABLE. DO NOT LOOSE THIS KEY.** [Safe generation tool](https://tools.stchepinsky.net/token-generator?length=128)  |
|  `api.oauth.client_secret_file_path` | string | *optional* | ` ` |  Configuration of google drive Oauth. See [official Google doc](https://developers.google.com/identity/protocols/oauth2) for more information. |
|  `api.session_token_validity` | int | *optional* | `600` |The access token is used to authenticate the user accross the app. This is the token lifetime validity in seconds. Keeping low value is highly recommended. Default : 10minutes. |
|  `api.refresh_token_validity` | int | *optional* | `86400 ` |The refresh token is used to refresh the session token without asking the user to sign in again. This is the token lifetime validity in seconds. Modification of this value will impact the maximum duration of your user's session. Default : 24h. |
|  `api.health_check.node_check_enabled` | bool | *optional* | `false` |Health check endpoint used to check if the API is running correctly. This enabled the node name check. This check is used to determine which api node is answering API calls. This is useful for load balancing. The API will return the SHA256-HMAC(node_name, node_name_hmac_secret) in the response. You can disable the display of your API node hashed name by setting this field to `false`|
|  `api.health_check.node_name` | string | *optional* | ` ` | If name check enable (see above), the API will return the SHA256-HMAC(node_name, node_name_hmac_secret) in the response. This is useful for load balancing monitoring. |
|  `api.health_check.node_name_hmac_secret` | string | *optional* | ` ` | If name check enable (see above), the API will return the SHA256-HMAC(node_name, node_name_hmac_secret) in the response. This is useful for load balancing monitoring. This value must be an alphanumeric string. |
|  `environment.type` | string |**mandatory** | `"production"` | This value is used to determine the logging level and security features enabling. Possible values are "local", "development" and "production". For security reasons, production instances should run under `"production"` type. |
|  `environment.type` | string |**mandatory** | `"production"` | This value is used to determine the logging level and security features enabling. Possible values are "local", "development" and "production". For security reasons, production instances should run under `"production"` type. |
|  `environment.config_version` | string |**mandatory** | `1.0` | DO NOT modify this value if not prompted to do so.|
|  `environment.domain` | string |**mandatory** | ` ` | Domain used by your instance. This is used to enforce the security of the API. The API must be served over HTTPS. Only include the domain name, without the protocol or path. The domain MUST be the same as the one used in the frontend.|
|  `database.database_uri` | string |**mandatory** | ` ` | The URI of the database to connect to. The URI must be in the format of `"mysql://user:password@host:port/db_name"` |
|  `features.emails.require_email_validation` | bool | *optional* | `false` | Require email validation for new users. If set to true, above settings will have to be filled. |