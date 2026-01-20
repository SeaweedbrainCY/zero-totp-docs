---
date: 2025-07-09T21:22:19+00:00

title: 'Configuration of your Zero-TOTP instance'
linkTitle: Configuration
weight: 3
cascade:
  **Type:** docs
---

Beside mandatory fields, it is highly recommended configuring your Zero-TOTP instance to fit your needs and network architecture.

This page will guide you through the Configuration process and explain how to properly configure Zero-TOTP.

> [!important]
> This page help you to configure your `config.yml` file. The ease the notation, the fields are written as 1 line. But, it is only to describe the yaml file.
>
> For example, `api.port: 8080` means that you have to write the following in your `config.yml` file:
> ```yaml
> api:
>   port: 8080
> ```



## API Configuration 
This part will help you tweak the API configuration and behavior. Default values are provided for most of possible configuration to keep the API working and secure by default. Thus, it is highly recommended that you take a look and adjust the security settings to your needs. 

- **Field:** `api.port`
    - **Type:** `int`
    - **Mandatory:** No
    - **Default value:** `8080`
    - **Description:** The port the API listens to. **Attention:** To expose a different API port, please change it in your docker configuration. This settings only change the port the API is listening to, inside the docker container.
---
- **Field:** `api.trusted_proxy`
    - **Type:** `List of IPs`
    - **Mandatory:** No
    - **Default value:** `""`
    - **Description:** List of trusted IPs of the revproxy(s) that are in front of the API. Those revproxy must set a 100% trustable `X-Forwarded-For` header. Please refer to the documentation of your revproxy to correctly pass the client IP in the `X-Forwarded-For` header. If you are using Cloudflare see [this guide](https://developers.cloudflare.com/support/troubleshooting/restoring-visitor-ips/restoring-original-visitor-ips/).
---

- **Field:** `api.session_token_validity`
    - **Type:** `int (seconds)`
    - **Mandatory:** No
    - **Default value:** `600` (10 min)
    - **Description:** Validity duration of access tokens used to authenticate users. Recommended range is between **300 seconds (5 minutes)** and **900 seconds (15 minutes)**.

---

- **Field:** `api.refresh_token_validity`
    - **Type:** `int (seconds)`
    - **Mandatory:** No
    - **Default value:** `86400` (1 day)
    - **Description:** Validity duration of refresh tokens used to issue new access tokens. Recommended range is between **1 day** and **7 days**. If a user doesn't use Zero-TOTP within this period the user will have to re-authenticate.

---

- **Field:** `api.session_validity`
    - **Type:** `int (seconds)`
    - **Mandatory:** No
    - **Default value:** `604800` (7days)
    - **Description:** Maximum lifetime of a user session. Once expired, the user must reauthenticate even if refresh tokens are still valid. This defines how long a session can be valid without having it the user to re-authenticate themselves. 

---

- **Field:** `api.health_check.node_check_enabled`
    - **Type:** `boolean`
    - **Mandatory:** No
    - **Default value:** `false`
    - **Description:** Enables the node identity check endpoint. Useful in load-balanced environments to identify which API node is responding.

---

- **Field:** `api.health_check.node_name`
    - **Type:** `string`
    - **Mandatory:** Conditional
    - **Default value:** `""`
    - **Description:** Logical name of the API node. Used only if `node_check_enabled` is set to `true`.

---

- **Field:** `api.health_check.node_name_hmac_secret`
    - **Type:** `string`
    - **Mandatory:** Conditional
    - **Default value:** `""`
    - **Description:** Secret used to compute the HMAC of the node name. Required if `node_check_enabled` is enabled.




## Features Configuration 
This parts helps you configure the enabled features of Zero-TOTP. Unlike the API configuration, keeping the default configuration will not impact the API behavior or its security, but will disable some features. 

Default values are provided to keep Zero-TOTP as  plug and play as possible. But it is recommended to adapt those values to fit your needs.


### IP geolocation 
Zero-TOTP uses IP geolocation in emails sent to user (if enabled). You can disable it (default) or enable it. If you want to enable it you'll have to get and provide the Maxmind City database. [How to](https://dev.maxmind.com/geoip/geolite2-free-geolocation-data?lang=en)

- **Field:** `features.ip_geolocation.enabled`
    - **Type:** `boolean`
    - **Mandatory:** No
    - **Default value:** `false`
    - **Description:** Enables IP geolocation to enrich login notification emails with location information.

---

- **Field:** `features.ip_geolocation.geoip_database_path`
    - **Type:** `string`
    - **Mandatory:** Conditional
    - **Default value:** None
    - **Description:** Path to the MaxMind GeoLite2 MMDB file used for IP lookups.

### Google Drive automatic backup 

> [!note]
> Before being able to configure Google Drive automatic backup, you must first register your application as a Google Oauth client. See the [How to configure Google Drive automatic backup](../admin/google_drive_backup/) for more information.

One key feature of Zero-TOTP is the possibility for users to automatically backup their vaults to Google Drive. To enable this feature, you must register you application as a Google Oauth client and give the following information : 



- **Field:** `features.google_drive_backup.enabled`
    - **Type:** `bool`
    - **Default value:** `false`
    - **Description:** Enable Google Drive automatic backup feature. If set to true, below setting will have to be filled.
---
- **Field:** `features.google_drive_backup.client_secret_file_path`
    - **Type:** `string`
    - **Default value:** `""`
    - **Description:** The path to the client secret file used to authenticate with Google Drive. This file must be in JSON format and contain the OAuth credentials. See the [How to configure Google Drive automatic backup](../admin/google_drive_backup/) for more information.

### Automatic backup configuration

For now, only Google Drive automatic backup is supported. But the below configuration is used for every backup provider. The main goal is to define the **default** backup frequency and the minimum number of backups to keep. Users will be able to override those settings in their profile.


- **Field:** `features.default_backup_configuration.backup_minimum_count`
    - **Type:** `int`
    - **Default value:** `20`
    - **Description:** Minimum number of backups Zero-TOTP will ever keep in user's Google Drive. *Default : no matter what, Zero-TOTP will always keep at least the 20 last backups in user's Google Drive.*
---
- **Field:** `features.default_backup_configuration.max_age_in_days`
    - **Type:** `int`
    - **Default value:** `30`
    - **Description:** Backups minimum age. If backups are older than this parameter, in days, and if the above parameter is also matched, backups will be deleted. *Default : 30 days*



### Emails
The email feature is used to send emails to users. The main purpose is to send verification emails to your users when signing up, but also for password reset. **STARTTLS is required.**

If you disable emails, users will not be prompted to validate their email. 

- Field : `features.emails.require_email_validation`
    - **Type:** `bool`
    - **Default value:** `false`
    - **Description:** Require email validation for new users. If set to true, below settings will have to be filled.
---
- Field : `features.emails.email_sender_address`
    - **Type:** `string`
    - **Default value:** `""`
    - **Description:** Sender email address. Can be `example@domain.com` or `Example <example@domain.com>`. 
--- 
- Field : `features.emails.email_smtp_port`
    - **Type:** `int`
    - **Default value:** `""`
    - **Description:** SMTP port to use. STARTTLS will be used.
---
- Field : `features.emails.email_smtp_username`
    - **Type:** `string`
    - **Default value:** `""`
    - **Description:** Username used to authenticate to SMTP server. STARTTLS will be used.
---
- Field : `features.emails.email_smtp_password`
    - **Type:** `string`
    - **Default value:** `""`
    - **Description:** Password used to authenticate to SMTP server. STARTTLS will be used.
---

### Rate limiting

Zero-TOTP has a built-in rate limiting feature to prevent abuse of the API and more specifically protect the login endpoint and email verification endpoint. This feature is enabled by default. 

- **Field:** `features.rate_limiting.login_attempts_limit_per_ip`
    - **Type:** `int`
    - **Default value:** `10`
    - **Description:** Max consecutive failed login per IP within **1h**. *Default : max 10 failed login per 1h per IP* 
---
- **Field:** `features.rate_limiting.login_ban_time`
    - **Type:** `int`
    - **Default value:** `15`
    - **Description:** If the previous condition is matched, this value defines to ban time, per IP, in minutes, from login. ***Default value:** 15min*
---
- **Field:** `features.rate_limiting.send_email_attempts_limit_per_user`
    - **Type:** `int`
    - **Default value:** `5`
    - **Description:** Max consecutive verification email sent to a user within 1 hour. *Default : max 5 consecutive verification email sent per hour per user.*
---
- **Field:** `features.rate_limiting.send_email_ban_time`
    - **Type:** `int`
    - **Default value:** `60`
    - **Description:** If the previous condition is matched, this value defines to ban time, per user, in minutes, from requesting a new verification email. ***Default value:** 60min*



### Sentry 
Zero-TOTP has a built-in Sentry integration to report errors and exceptions. This feature is disabled by default. 

- Field : `features.sentry.dsn`
    - **Type:** `string`
    - **Default value:** `""`
    - **Description:** Sentry DSN URL.  For more information, see the [Sentry documentation](https://docs.sentry.io/platforms/python/flask/). 