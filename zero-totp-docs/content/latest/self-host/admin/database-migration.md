---
date: '2025-06-30T00:56:13Z'

title: Migrate your database
linkTitle : 'Database Migration'
weight: 5
cascade:
  type: docs
---

When you are upgrading Zero-TOTP, you may need to migrate your database to the new version. If this is the case, it will be mentioned in the release notes and the API will refuse to start. 

To avoid any data loss, you will have to perform the migration yourself **after having made a backup of your database**.

## How to migrate your database
### 1 - Backup your database
Before performing any migration, it is highly recommended to backup your database. You can follow the [Backup and restore documentation](../database-backup) to backup your database.

### 2 - Run the migration script

Zero-TOTP provides a built-in migration script, directly in the API docker container to help you migrate your database. 

You can run the migration script using the following command:

```bash {filename="Run migration script"}
docker compose exec api /bin/sh -c "./admin-toolbox.sh db-migrate"
```

Follow the instructions to complete the migration. 

> [!note] 
> The API will perform the migration on the database and will update the database schema to the latest version.
> Therefore, the database must be up and running !

### 3 - Restart the API
After the migration is complete, you will need to restart the API to apply the changes. You can do this by running:

```bash {filename="Restart API"}
docker compose restart api
```