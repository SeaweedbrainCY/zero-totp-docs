---
title: Customization
---


# Customize your Zero-TOTP instance 

Beside mandatory fields, it is highly recommended customizing your Zero-TOTP instance to fit your needs and network architecture.

These customizations are done via the `config.yml` file. This file is mounted in the API container and is used to configure the API. You can find the default config file [here](https://raw.githubusercontent.com/SeaweedbrainCY/zero-totp/refs/heads/main/api/config/config-example.yml).

## API customization (highly recommended)

Controls API behavior and security.

| Field | type | Mandatory | Default | Description |
|-------|-------|-----------|---------|-------------| 
| `api.port` | int | *optional* | `8080` | The port on which the API will listen |
| `api.trusted_proxy` | list | *optional* | `[]` | List of IP addresses or CIDR of your trusted reverseproxy that are in front of Zero-TOTP and will forward requests. This is essential to retrieve the real IP of your client and a misconfiguration can cause security issue. [Read this before anything else](https://esd.io/blog/flask-apps-heroku-real-ip-spoofing.html) |
| `api.trusted_proxy_header` | string | *optional* | `X-Forwarded-For` | The header used by your reverse proxy to forward the real IP of the client. |
|  `api.oauth.client_secret_file_path` | string | *optional* | ` ` |  Configuration of google drive Oauth. See [official Google doc](https://developers.google.com/identity/protocols/oauth2) for more information. |
|  `api.session_token_validity` | int | *optional* | `600` |The access token is used to authenticate the user accross the app. This is the token lifetime validity in seconds. Keeping low value is highly recommended. Default : 10minutes. |
|  `api.refresh_token_validity` | int | *optional* | `86400 ` |The refresh token is used to refresh the session token without asking the user to sign in again. This is the token lifetime validity in seconds. Modification of this value will impact the maximum duration of your user's session. Default : 24h. |
|  `api.health_check.node_check_enabled` | bool | *optional* | `false` |Health check endpoint used to check if the API is running correctly. This enabled the node name check. This check is used to determine which api node is answering API calls. This is useful for load balancing. The API will return the SHA256-HMAC(node_name, node_name_hmac_secret) in the response. You can disable the display of your API node hashed name by setting this field to `false`|
|  `api.health_check.node_name` | string | *optional* | ` ` | If name check enable (see above), the API will return the SHA256-HMAC(node_name, node_name_hmac_secret) in the response. This is useful for load balancing monitoring. |
|  `api.health_check.node_name_hmac_secret` | string | *optional* | ` ` | If name check enable (see above), the API will return the SHA256-HMAC(node_name, node_name_hmac_secret) in the response. This is useful for load balancing monitoring. This value must be an alphanumeric string. |

## Features customization

Controls features enabling and behavior.

### Emails

The email feature is used to send emails to users. This feature is used for email validation and password reset. **STARTTLS is required.**


| Field | type | Mandatory | Default | Description |
|-------|-------|-----------|---------|-------------| 
|  `features.emails.require_email_validation` | bool | *optional* | `false` | Require email validation for new users. If set to true, below settings will have to be filled. |
|  `features.emails.email_sender_address` | bool | Madantory if `require_email_validation` | `""` | Sender email address. Can be `example@domain.com` or `Example <example@domain.com>` |
|  `features.emails.email_smtp_port` | bool | Madantory if `require_email_validation` | `""` | SMTP port to use. STARTTLS will be used. |
|  `features.emails.email_smtp_username` | bool | Madantory if `require_email_validation` | `""` | Username used to authenticate to SMTP server. STARTTLS will be used. |
|  `features.emails.email_smtp_password` | bool | Madantory if `require_email_validation` | `""` | Username used to authenticate to SMTP server. STARTTLS will be used. |


### Rate limiting

Zero-TOTP has integrated rate limiting to prevent brute force attacks. Both login and email validation can be protected. This is enabled by default, but you can disable it.

| Field | type | Mandatory | Default | Description |
|-------|-------|-----------|---------|-------------| 
|  `features.rate_limiting.login_attempts_limit_per_ip` | int | *optional* | `10` | Max consecutive failed login per IP within **1h**. *Default : max 10 failed login per 1h per IP*  |
|  `features.rate_limiting.login_ban_time` | int | *optional* | `15` | If the previous condition is matched, this value defines to ban time, per IP, in minutes, from login. *Default: 15min* |
|  `features.rate_limiting.send_email_attempts_limit_per_user` | int | *optional* | `5` | Max consecutive verification email sent to a user within 1 hour. *Default : max 5 consecutive verification email sent per hour per user.* |
|  `features.rate_limiting.` | int | *optional* | `60` | If the previous condition is matched, this value defines to ban time, per user, in minutes, from requesting a new verification email. *Default: 60min* |

### Sentry

Sentry is used to track errors and exceptions in the API. This feature is disabled by default. You can enable it by setting the `sentry.dsn` field. For more information, see the [Sentry documentation](https://docs.sentry.io/platforms/python/flask/).


| Field | type | Mandatory | Default | Description |
|-------|-------|-----------|---------|-------------| 
|  `features.sentry.dsn` | string | *optional* | `""` | Sentry DSN URL.  For more information, see the [Sentry documentation](https://docs.sentry.io/platforms/python/flask/). |


### Google Drive automatic backup default values

Define the default values for the automatic backup feature. This feature is used to automatically backup the user's vault to Google Drive, when opted in. You can control the default values Zero-TOTP will configure for your users. Users can always change those values individually in their settings.

| Field | type | Mandatory | Default | Description |
|-------|-------|-----------|---------|-------------|
|  `features.default_backup_configuration.backup_minimum_count` | int | *optional* | `20` | Minimum number of backups Zero-TOTP will ever keep in user's google drive. *Default : no matter what, Zero-TOTP will always keep at least the 20 last backups in user's google drive.* |
|  `features.default_backup_configuration.max_age_in_days` | int | *optional* | `30` | Backups minimum age. If backups are older than this parameter, in days, and if the above parameter is also matched, backups will be deleted. *Default : 30 days* |
