---
date: 2025-07-20T14:38:28Z

title: 'Customization of your Zero-TOTP instance'
linkTitle: Customization
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


## Features customization (recommended)
This parts helps you customize the enabled features of Zero-TOTP. Unlike the API customization, keeping the default configuration will not impact the API behavior or its security, but will disable some features. 

Default values are provided to keeo Zero-TOTP as  plug and play as possible. But it is recommended to adapt those values to fit your needs.



### Google Drive automatic backup 

> [!note]
> Before being able to configure Google Drive automatic backup, you must first register your application as a Google Oauth client. See the [How to configure Google Drive automatic backup](../admin/google_drive_backup/) for more information.

One key feature of Zero-TOTP is the possibility for users to automatically backup their vaults to Google Drive. To enable this feature, you must register you application as a Google Oauth client and give the following information : 



- Field: `features.google_drive_backup.enabled`
    - Type: `bool`
    - Default: `false`
    - Description: Enable Google Drive automatic backup feature. If set to true, below setting will have to be filled.
---
- Field: `features.google_drive_backup.client_secret_file_path`
    - Type: `string`
    - Default: `""`
    - Description: The path to the client secret file used to authenticate with Google Drive. This file must be in JSON format and contain the OAuth credentials. See the [How to configure Google Drive automatic backup](../admin/google_drive_backup/) for more information.

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