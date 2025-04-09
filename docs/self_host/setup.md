---
title: Setup
---

# Setup your Zero-TOTP instance
You'll have to set up your Zero-TOTP instance to make it work. Some of the following steps are mandatory, others are optional and can be used to customize your instance.


##  Setup Zero-TOTP API
Zero-TOTP is configured via a yaml config file that must be mounted in the container. You can follow the volume mounting of the installation or use your own. In anyway, the config file should be located and named : `/app/config.yml` in the API container.

You can download the default config file :
```bash
curl -o config.yml https://raw.githubusercontent.com/SeaweedbrainCY/zero-totp/refs/heads/main/api/config/config-example.yml
```
or copy the content of the [default config file](https://raw.githubusercontent.com/SeaweedbrainCY/zero-totp/refs/heads/main/api/config/config-example.yml) and paste it in a file named `config.yml`.

!!! Warning  
    Several fields are mandatory in the config file. You must fill them to make Zero-TOTP work. If fields are missing, the API will fail to start.

#### Configuration fields
Here are the list of fields you can configure in the config file. Make sure to fill the mandatory fields : 
!!! Warning  
    Fields marked *optional* must be **commented** if not used. Keeping optional fields in the config file without value will cause the API to fail to start.

!!! Note  
    Only mandatory fields are listed here. For customization and understand other settings, see the [customization page](customization.md).

| Field | type | Mandatory | Default | Description |
|-------|-------|-----------|---------|-------------| 
| `api.jwt_secret` | string | **mandatory** | ` ` | A random 128 alphanumeric char string used to sign JWT tokens. [Safe generation tool](https://tools.stchepinsky.net/token-generator?length=128) |
| `api.private_key_path` | string | **mandatory** | `".secret/private.pem"` |  Absolute path to the API private key used to sign vaults to guarantee their authenticity.  This must be a PEM encoded RSA private key. **If the file does not exist, it will be generated at startup.** |
| `api.public_key_path` | string |**mandatory** |  `".secret/public.pem"` | Absolute path to the API public key used to verify vaults authenticity. This must be a PEM encoded RSA public key. **If the file does not exist, it will be generated at startup.** |
| `api.flask_secret_key` | string | **mandatory** | ` ` |  A random 128 alphanumeric char string used to encrypt flask session.  [Safe generation tool](https://tools.stchepinsky.net/token-generator?length=128)  |
| `api.server_side_encryption_key` | string | **mandatory** | ` ` |  A random 128 alphanumeric char string used to encrypt data stored in the database that is not Encrypted by default by the ZKE flow. **BE CAREFULL WITHOUT THIS KEY SOME OF SAVED DATA WILL BE UNREADABLE. DO NOT LOOSE THIS KEY.** [Safe generation tool](https://tools.stchepinsky.net/token-generator?length=128)  |
|  `environment.type` | string |**mandatory** | `"production"` | This value is used to determine the logging level and security features enabling. Possible values are "local", "development" and "production". For security reasons, production instances should run under `"production"` type. |
|  `environment.config_version` | string |**mandatory** | `1.0` | DO NOT modify this value if not prompted to do so.|
|  `environment.domain` | string |**mandatory** | ` ` | Domain used by your instance. This is used to enforce the security of the API. The API must be served over HTTPS. Only include the domain name, without the protocol or path. The domain MUST be the same as the one used in the frontend.|
|  `database.database_uri` | string |**mandatory** | ` ` | The URI of the database to connect to. The URI must be in the format of `"mysql://user:password@host:port/db_name"` |

With all those fields filled, you can now start your Zero-TOTP API. Don't forget to check the [customization page](customization.md) to see all the fields you can configure. 

##  Setup Zero-TOTP database

You will be able to manage crucial database operations from the API. To set up you database please : 

<div class="annotate" markdown>

- Start your database (1)
- Start your API (2)
- Make sure you API started correctly (3)

</div>

1. :fontawesome-solid-terminal: `docker compose up database -d` 
2. :fontawesome-solid-terminal: `docker compose up api -d` 
3. :fontawesome-solid-terminal: `docker compose logs api -f --tail 100` 


### Database initialization

Zero-TOTP api has a built-in administration script that will help you manage several critical operations. You will have to use this script to initialize your database and perform **database migration** when needed (for instance when upgrading Zero-TOTP).

To use the administration script you will have to run the following command : 

=== "docker compose"

    ``` bash
    docker compose exec api /bin/sh -c "./admin-toolbox.sh db-migrate"
    ```

=== "docker run"

    ``` bash
    docker exec -it api /bin/sh -c "./admin-toolbox.sh db-migrate"
    ```

**You are now all set up ! 🎉🎉**

**You can just start your server `docker compose up -d` and enjoy**. Make sure to visit the [customization page](customization.md) to see all the features you can configure.