
---
date: '2025-06-30T00:54:51Z'

title: 'Setup the Zero-TOTP database'
linkTitle: 3 - Database Setup
weight: 5
cascade:
  type: docs
---

This is the final mandatory step to set up your Zero-TOTP instance. Zero-TOTP uses a MariaDB database, included in the docker-compose file. To mantain the security and integrity of your data, all the administration is delegated to the server owner. Make sure to make regular backups of your database and to secure it properly.


Before being able to start Zero-TOTP, you will need to set up your database. 

## Initial database migration

For now, your database is empty and not initialized. You will need to run the initial database migration to create the necessary tables and data. A built-in administration script is provided to help you with this task.

You will be able to manage crucial database operations from the API. To set up you database please : 

{{% steps %}}

###  Start your database

`docker compose up -d database`

### Make sure the database is running and ready

`docker compose logs database -f --tail 100`

###  Start your API 
`docker compose up -d api`

###  Make sure the API is asking for a migration
`docker compose logs api -f --tail 100`

You should see the following message 

```
api  | ERROR [alembic.util.messaging] Target database is not up to date.
api  | FAILED: Target database is not up to date.
api  | ❌  Your database is not up to date. Follow Zero-TOTP's documentation to update it.
api  | 📚 https://docs.zero-totp.com/latest/self-host/admin/database-migration/
api  | 🕛 Docker will wait for your action to continue
```

This is expected, as the database is not yet initialized. 

However, the API should not be crashing or throwing errors not related to database migration. If it does, please check the logs for any issues, it may be related to your configuration file or the database connection.

###  Run the initial database migration

`docker compose exec api /bin/sh -c "./admin-toolbox.sh db-migrate"`

###  Restart the API

`docker compose restart api`

The API should now be healthy and ready to use. You can check the logs to make sure everything is working properly.

{{% /steps %}}

All done ? 

**You are now all set up ! 🎉🎉**

**You can just start your server `docker compose up -d` and enjoy**. Make sure to visit the [customization page](/self-host/customization/) to see all the features you can configure.