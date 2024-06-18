# Requirements
## 1. The OS 
Zero-TOTP is built to run on a **unix** system. Both MacOS and Linux are supported. More precisely, this project is entirely built to run on a **Debian** system, but Macos and other Linux distributions should work as well. 

Zero-TOTP itself is distributed as a docker image.
## 2. The Packages 
In order to run Zero-TOTP locally you will to install python, angular cli and Make. 
### 2.1. Angular 
Zero-TOTP frontend is built with Angular. To install Angular, you will need to install Node.js and npm. 

!!! note

    If npm is not installed in your system, follow the [official documentation](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm) to install it.

Install angular cli to run the frontend locally : 
```shell 
npm install -g @angular/cli
```
### 2.2. Python 
The API of Zero-TOTP is built with Python. To install Python, follow the [official documentation](https://www.python.org/downloads/).

!!! note

    **Python 3.11 is the only version tested on this project and should be the only one used to run Zero-TOTP.** Any previous or later version of Python 3 may not work.

### 2.3. Make
Make is used to easily install and run the project locally. 

With apt : 
``` shell 
apt-get install build-essential
```
With homebrew : 
```shell
brew install make
```
### 2.4. Docker (recommended)
Zero-TOTP is distributed as a docker image. When running the project locally, a mariadb container is recommended to run the database. 

Moreover, to test the build of the project, docker is required.

To install docker, follow the [official documentation](https://docs.docker.com/get-docker/).