---
title: Database backup
---

# Zero-TOTP database backup and restore
Backing up your database is important to prevent data loss. You can use the `mariadb-dump` utility to backup your database.

## Backup your database

!!! Info  
    If you are not using environment variables in docker, make sure to update `"$MYSQL_DATABASE"` and `"$MYSQL_ROOT_PASSWORD"`.

=== "docker compose"

    ```bash title="Database backup command"
    docker compose exec database /bin/bash -c 'mariadb-dump --databases $MYSQL_DATABASE --user=root    --password=$MYSQL_ROOT_PASSWORD  > /var/lib/mysql/db_backup_$(date +%Y%m%d_%H%M%S).sql'
    ```

=== "docker run"

    ```bash title="Database backup command"
    docker exec database /bin/sh -c 'mariadb-dump --databases $MYSQL_DATABASE --user=root    --password=$MYSQL_ROOT_PASSWORD  > /var/lib/mysql/db_backup_$(date +%Y%m%d_%H%M%S).sql'
    ```

**:warning: Backup location :** 

- The backup file will be named db_backup_\*.log 
- The backup file will be saved in the `/var/lib/mysql` directory of the database container which is a mounted volume in your host. Check the mount point in your `docker-compose.yml` file or the `docker run` command to find the backup file. 

**It is highly recommended to copy the backups files into an external filesystem and very they are not empty !**


## Restore a database backup 

Make sure to mount the backup file into the database container before running the restore command. You can use the `/var/lib/mysql` mounted volume to copy the backup file into the container. The default path for the mounted volume is `$pwd/database/config/`.

!!! Info
    If you are not using environment variables in docker, make sure to update `"$MYSQL_DATABASE"` and `"$MYSQL_ROOT_PASSWORD"`.

=== "docker compose"

    ```bash title="Database restore command" 
    docker compose exec database /bin/sh -c 'mariadb --user=root --password=$MYSQL_ROOT_PASSWORD < $PATH_TO_SQL_FILE_IN_DOCKER_CONTAINER.sql'
    ```

=== "docker run"

    ```bash title="Database restore command"
    docker exec database /bin/sh -c 'mariadb --user=root --password=$MYSQL_ROOT_PASSWORD < $PATH_TO_SQL_FILE_IN_DOCKER_CONTAINER.sql'
    ```