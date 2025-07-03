---
date: '2025-06-30T00:54:51Z'

title: 'Setup the Zero-TOTP API'
linkTitle: 2 - API Setup 
weight: 4
cascade:
  type: docs
---



Zero-TOTP is configured via a yaml config file that must be mounted in the container. You can follow the volume mounting of the installation or use your own. In anyway, the config file should be located and named : `/app/config.yml` in the API container.


You can download the default config file :
```Bash
curl -o config.yml https://raw.githubusercontent.com/SeaweedbrainCY/zero-totp/refs/heads/main/api/config/config-example.yml
```
or copy the content of the [default config file](https://raw.githubusercontent.com/SeaweedbrainCY/zero-totp/refs/heads/main/api/config/config-example.yml) and paste it in a file named `config.yml`.

> [!note]
>  Several fields are mandatory in the config file. You must fill them to make Zero-TOTP work. If fields are missing, the API will fail to start.

## Mandatory configuration fields
Here are the list of mandatory fields you need to fill in the config file.  : 


> [!tip]
> Only mandatory fields are listed here. For customization and understand other settings, see the [customization page](customization.md).

- Field : `api.jwt_secret`
    - Type: `string`
    - Default: ` ` (empty)
    - Description: A random 128 alphanumeric char string used to sign JWT tokens. [Safe generation tool](https://tools.stchepinsky.net/token-generator?length=128)
--- 
- Field : `api.private_key_path`
    - Type: `string`
    - Default: `".secret/private.pem"`
    - Description: Absolute path to the API private key used to sign vaults to guarantee their authenticity. This must be a PEM encoded RSA private key. **If the file does not exist, it will be generated at startup.**
--- 
- Field : `api.public_key_path`
    - Type: `string`
    - Default: `".secret/public.pem"`
    - Description: Absolute path to the API public key used to verify vaults authenticity. This must be a PEM encoded RSA public key. **If the file does not exist, it will be generated at startup.**
---
- Field : `api.flask_secret_key`
    - Type: `string`
    - Default: ` ` (empty)
    - Description: A random 128 alphanumeric char string used to encrypt flask session. [Safe generation tool](https://tools.stchepinsky.net/token-generator?length=128)
---
- Field : `api.server_side_encryption_key`
    - Type: `string`
    - Default: ` ` (empty)
    - Description: A random 128 alphanumeric char string used to encrypt data stored in the database that is not Encrypted by default by the ZKE flow. **BE CAREFULL WITHOUT THIS KEY SOME OF SAVED DATA WILL BE UNREADABLE. DO NOT LOOSE THIS KEY.** [Safe generation tool](https://tools.stchepinsky.net/token-generator?length=128)
---
- Field : `environment.type`
    - Type: `string`
    - Default: `"production"`
    - Description: This value is used to determine the logging level and security features enabling. Possible values are "local", "development" and "production". For security reasons, production instances should run under `"production"` type.
---
- Field : `environment.config_version`
    - Type: `string`
    - Default: `1.0`
    - Description: DO NOT modify this value if not prompted to do so.
---
- Field : `environment.domain`
    - Type: `string`
    - Default: ` ` (empty)
    - Description: Domain used by your instance. This is used to enforce the security of the API. The API must be served over HTTPS. Only include the domain name, without the protocol or path. The domain MUST be the same as the one used in the frontend.
---
- Field : `database.database_uri`
    - Type: `string`
    - Default: ` ` (empty)
    - Description: The URI of the database to connect to. The URI must be in the format of `"mysql://user:password@host:port/db_name"`

