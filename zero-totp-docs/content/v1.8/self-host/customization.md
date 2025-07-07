---
date: '2025-06-30T00:55:15Z'

title: 'Configuration'
weight: 3
cascade:
  type: docs
---

Beside mandatory fields, it is highly recommended customizing your Zero-TOTP instance to fit your needs and network architecture.

This page will guide you through the customization process and explain how to properly configure Zero-TOTP.

> [!important]
> This page help you to configure your `config.yml` file. The ease the notation, the fields are written as 1 line. But, it is only to describe the yaml file.
>
> For example, `api.port: 8080` means that you have to write the following in your `config.yml` file:
> ```yaml
> api:
>   port: 8080
> ```

## API customization (highly recommended)

This part details how you can control the API behavior and security features.

**All those fields have default values. To use default values, keep the fields commented out.**

- Field : `api.port`
    - Type: `int`
    - Default: `8080`
    - Description: The port on which the API will listen. This is the port exposed inside the docker container.
---
- Field : `api.trusted_proxy`
    - Type: `list`
    - Default: `[]`
    - Description: List of IP addresses or CIDR of your trusted reverse proxy that are in front of Zero-TOTP and will forward requests. This is essential to retrieve the real IP of your client and a misconfiguration can cause security issues. Kindly refer to the [proxy setup instructions](../setup/reverse-proxy/).
--- 
- Field : `api.trusted_proxy_header`
    - Type: `string`
    - Default: `X-Forwarded-For`
    - Description: The header used by your reverse proxy to forward the real IP of the client. This is essential for security and logging purposes.
--- 
- Field : `api.session_token_validity`
    - Type: `int`
    - Default: `600` (10 minutes)
    - Description: The access token is used to authenticate the user across the app. This is the token lifetime validity in seconds. Keeping a low value is highly recommended for security reasons.
---
- Field : `api.refresh_token_validity`
    - Type: `int`
    - Default: `86400` (24 hours)
    - Description: The refresh token is used to refresh the session token without asking the user to sign in again. This is the token lifetime validity in seconds. Modification of this value will impact the maximum duration of your user's session.
---
- Field : `api.health_check.node_check_enabled`
    - Type: `bool`
    - Default: `false`
    - Description: Health check endpoint used to check if the API is running correctly. This enabled the node name check. This check is used to determine which api node is answering API calls. This is useful for load balancing. The API will return the SHA256-HMAC(node_name, node_name_hmac_secret) in the response. You can disable the display of your API node hashed name by setting this field to `false`.
---
- Field : `api.health_check.node_name`
    - Type: `string`
    - Default: ` ` (empty)
    - Description: If name check enabled (see above), the API will return the SHA256-HMAC(node_name, node_name_hmac_secret) in the response. This is useful for load balancing monitoring.
---
- Field : `api.health_check.node_name_hmac_secret`
    - Type: `string`
    - Default: ` ` (empty)
    - Description: If name check enabled (see above), the API will return the SHA256-HMAC(node_name, node_name_hmac_secret) in the response. This is useful for load balancing monitoring. This value must be an alphanumeric string.
---


## Features customization (recommended)
This parts helps you customize the enabled features of Zero-TOTP. Unlike the API customization, keeping the default configuration will not impact the API behavior or its security, but will disable some features. 

Default values are provided to keeo Zero-TOTP as  plug and play as possible. But it is recommended to adapt those values to fit your needs.



### Google Drive automatic backup 
One key feature of Zero-TOTP is the possibility for users to automatically backup their vaults to Google Drive. To enable this feature, you must register you application as a Google Oauth client and give the following information : 



- Field: `features.google_drive_backup.enabled`
    - Type: `bool`
    - Default: `false`
    - Description: Enable Google Drive automatic backup feature. If set to true, below setting will have to be filled.
---
- Field: `features.google_drive_backup.client_secret_file_path`
    - Type: `string`
    - Default: `""`
    - Description: The path to the client secret file used to authenticate with Google Drive. This file must be in JSON format and contain the OAuth credentials. See https://developers.google.com/identity/protocols/oauth2 for more information.

### Automatic backup configuration

For now, only Google Drive automatic backup is supported. But the below configuration is used for every backup provider. The main goal is to define the **default** backup frequency and the minimum number of backups to keep. Users will be able to override those settings in their profile.


- Field: `features.default_backup_configuration.backup_minimum_count`
    - Type: `int`
    - Default: `20`
    - Description: Minimum number of backups Zero-TOTP will ever keep in user's Google Drive. *Default : no matter what, Zero-TOTP will always keep at least the 20 last backups in user's Google Drive.*
---
- Field: `features.default_backup_configuration.max_age_in_days`
    - Type: `int`
    - Default: `30`
    - Description: Backups minimum age. If backups are older than this parameter, in days, and if the above parameter is also matched, backups will be deleted. *Default : 30 days*



  | Field | type | Mandatory | Default | Description |
|-------|-------|-----------|---------|-------------|
|  `features.default_backup_configuration.backup_minimum_count` | int | *optional* | `20` | Minimum number of backups Zero-TOTP will ever keep in user's google drive. *Default : no matter what, Zero-TOTP will always keep at least the 20 last backups in user's google drive.* |
|  `features.default_backup_configuration.max_age_in_days` | int | *optional* | `30` | Backups minimum age. If backups are older than this parameter, in days, and if the above parameter is also matched, backups will be deleted. *Default : 30 days* |


### Emails
The email feature is used to send emails to users. The main purpose is to send verification emails to your users when signing up, but also for password reset. **STARTTLS is required.**

If you disable emails, users will not be prompted to validate their email. 

- Field : `features.emails.require_email_validation`
    - Type: `bool`
    - Default: `false`
    - Description: Require email validation for new users. If set to true, below settings will have to be filled.
---
- Field : `features.emails.email_sender_address`
    - Type: `string`
    - Default: `""`
    - Description: Sender email address. Can be `example@domain.com` or `Example <example@domain.com>`. 
--- 
- Field : `features.emails.email_smtp_port`
    - Type: `int`
    - Default: `""`
    - Description: SMTP port to use. STARTTLS will be used.
---
- Field : `features.emails.email_smtp_username`
    - Type: `string`
    - Default: `""`
    - Description: Username used to authenticate to SMTP server. STARTTLS will be used.
---
- Field : `features.emails.email_smtp_password`
    - Type: `string`
    - Default: `""`
    - Description: Password used to authenticate to SMTP server. STARTTLS will be used.
---

### Rate limiting

Zero-TOTP has a built-in rate limiting feature to prevent abuse of the API and more specifically protect the login endpoint and email verification endpoint. This feature is enabled by default. 

- Field: `features.rate_limiting.login_attempts_limit_per_ip`
    - Type: `int`
    - Default: `10`
    - Description: Max consecutive failed login per IP within **1h**. *Default : max 10 failed login per 1h per IP* 
---
- Field: `features.rate_limiting.login_ban_time`
    - Type: `int`
    - Default: `15`
    - Description: If the previous condition is matched, this value defines to ban time, per IP, in minutes, from login. *Default: 15min*
---
- Field: `features.rate_limiting.send_email_attempts_limit_per_user`
    - Type: `int`
    - Default: `5`
    - Description: Max consecutive verification email sent to a user within 1 hour. *Default : max 5 consecutive verification email sent per hour per user.*
---
- Field: `features.rate_limiting.send_email_ban_time`
    - Type: `int`
    - Default: `60`
    - Description: If the previous condition is matched, this value defines to ban time, per user, in minutes, from requesting a new verification email. *Default: 60min*



### Sentry 
Zero-TOTP has a built-in Sentry integration to report errors and exceptions. This feature is disabled by default. 

- Field : `features.sentry.dsn`
    - Type: `string`
    - Default: `""`
    - Description: Sentry DSN URL.  For more information, see the [Sentry documentation](https://docs.sentry.io/platforms/python/flask/). 