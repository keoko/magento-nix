# Magento Development Environment with nix

This is a proof of concept to check if it is feasible to build a development environment for Magento2 based on Nix.

## Why
There are already several projects that allow you to install all the services to develop Magento2 applications. The main two strategies are Docker and valet-plus, and each of them have their pros and cons. My main concern with Docker is performance, and with valet-plus is that it is only available for MacOS. 

## Goals
- fast Magento2 development.
- reproducible development environment.
- compatibility with MacOS and Linux. Maybe Windows depending on the status of Nix on Windows.

### Prerequisites
- `Nix` package manager. Follow  [Install Nix](https://nixos.org/guides/install-nix.html)

## Run
- Start nix shell. The environment variable `NIXPKGS_ALLOW_UNFREE=1` is required by Nix to install elasticsearch7. Note that first time you run `nix-shell` it will download all the nix packages, so it will take some time. Be patient!
```
NIXPKGS_ALLOW_UNFREE=1 nix-shell
```
- Initialize the project. It will mainly create temporary folders, configuration files and the database.
```
make init
```
- Start all the services (i.e. nginx, php-fpm, mysql, redis, rabbitmq, elasticsearch). In case you want to also start Varnish, read the Varnish section below.
```
make start
```
- In another terminal, open a new nix-shell and install magento code. It will install magento2 CE and sample data by default. If you want to use an existing folder you can skip this step and change APP_PATH variable of `.env` file  to point to the folder with magento2 code.
```
NIXPKGS_ALLOW_UNFREE=1 nix-shell
make install
```
- Open a browser with `http://localhost:3000` and hopefully you will see the Luma store. For accessing the Admin panel, open a browser with `http://localhost:3000/admin/' with the following credentials:
```
username: admin
password: 123123q
```

## Alternatives
- [valet-plus](https://github.com/weprovide/valet-plus)
- [docker-magento](https://github.com/markshust/docker-magento)

## Notes
### RabbitMQ (Optional for Magento2)
You can access RabbitMQ's management UI through `http://localhost:15672` with credentials:
```
username: guest
password: guest
```
### Varnish (Optional for Magento2)
Varnish is disabled by default, as this project is aimed for Magento development. In case you want to enable it, look for the word ENABLE_VARNISH and follow the instructions appended after it.

In order to debug Varnish issues, you could use `varnishlog` with the following command:
```
varnishlog -n $(pwd)/var/varnish/data/
```
