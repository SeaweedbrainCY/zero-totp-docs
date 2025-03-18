# Setup your Zero-TOTP instance
You'll have to set up your Zero-TOTP instance to make it work. Some of the following steps are mandatory, others are optional and can be used to customize your instance.

## Setup Zero-TOTP API
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

| Field | Mandatory | Default | Description |
|-------|-----------|---------|-------------| 
| `api.port` | *optional* | `8080` | The port on which the API will listen |