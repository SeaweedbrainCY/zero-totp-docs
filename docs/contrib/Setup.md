# Setup
In order to run Zero-TOTP locally, you will have to run 3 different instances : 

- The frontend 
- The API
- The database
## 1. Clone the code
If your are not an official contributor of the project, you will have to fork the repository, create your own branch and make a pull request. 


To setup your code, you can follow the github documentation about [contributing to a project](https://docs.github.com/en/get-started/exploring-projects-on-github/contributing-to-a-project)


Once setup, you can start installing dependencies and running the project.
## 2. Install and run the frontend
At the root of the project, you will find the `Makefile` the you can use to install and run the project.

To install the frontend dependencies, run : 
```bash
make install_frontend
```

To run the frontend, run : 
```bash
make run_frontend
```

The frontend will be available at `http://localhost:4200`

## 3. Install and run the database
The database is a mariadb instance. You can run it with docker, this is the recommended way.

Create the directory `database-stack` at the root of the project. It will be ignored by git.
```bash
mkdir database-stack
```

Then you can use the following `docker-compose.yml` file to run the database : 
```yaml linenums="1" title="docker-compose.yml"
version: '3'
services:
  db:
    image: mariadb
    environment:
      MYSQL_ROOT_PASSWORD: <root_password> #(1)
      MYSQL_DATABASE: zero_totp #(2)
      MYSQL_USER: <mysql_user> #(3)
      MYSQL_PASSWORD: <mysql_user_password> #(4)
    volumes:
      - ./data:/var/lib/mysql
    ports:
      - "127.0.0.1:3306:3306"
```

1. :pencil: Change this value
2. :warning: If you change this value, report it in your api config file
3. :pencil: Change this value
4. :pencil: Change this value

## 4. Install, configure and the run the API 
### 4.1 Installation 

At the root of the project, you will find the `Makefile` the you can use to install and run the project.

To install the api dependencies, run : 
```bash
make install_frontend
```
### 4.2 Configuration
The API configuration is defined in the file `api/config/config.yml`. You need to **create** and **modify** the default config file in order to properly run the API.

You can find the default configuration file in `api/config/config-example.yml` or at [https://raw.githubusercontent.com/SeaweedbrainCY/zero-totp/dev/api/config/config-example.yml](https://raw.githubusercontent.com/SeaweedbrainCY/zero-totp/dev/api/config/config-example.yml).