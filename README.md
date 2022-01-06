# Magento Development Environment with nix

This is a proof of concept to check if it is feasible to build a development environment for Magento2 based on [Nix](https://nixos.org/).

## Why
There are already several projects that allow you to install all the services to develop Magento2 applications. The main two strategies are Docker and valet-plus, and each of them have their pros and cons. My main concern with Docker is performance, and with valet-plus is that it is only available for MacOS. 

## Goals
- fast Magento2 development.
- reproducible development environment.
- compatibility with MacOS, Linux and Windows. It has been tested in MacOS (Monterey), Linux (MX-21), [Windows10 WSL2 (Alpine)](doc/windows10_installation.md).

## Packages installed
All services are configured to use their default ports, but in case you want to change them you can edit [.env](./.env) file.
| package       | version | enabled | ports (default) | links                                                                  |
| ---           |     --: | :-:     |             --- | ---                                                                    |
| php           |  7.4.26 | yes     |            3000 | http://localhost:3000 (store) <br/>http://localhost:3000/admin (admin) |
| composer      |   2.1.4 | yes     |               - | -                                                                      |
| mysql         |  8.0.26 | yes     |            3306 | `mysql --host=127.0.0.1 --port=3306 --user=root --password=''`         |
| redis         |   6.2.6 | yes     |            6379 | `redis-cli`                                                            |
| elasticsearch |  7.16.1 | yes     |            9200 | http://localhost:9200                                                  |
| mailhog       |   1.0.1 | yes     |            8025 | http://localhost:8025                                                  |
| rabbitmq      |   3.9.8 | no      |            5672 | http://localhost:15672 (management UI)                                 |
| varnish       |   6.0.1 | no      |            3001 | http://localhost:3001                                                  |
| XDebug        |   3.1.2 | no      |               - | -                                                                      |

### Prerequisites
- `Nix` package manager. Follow  [Install Nix](https://nixos.org/guides/install-nix.html)

## Install
- Start nix shell. The environment variable `NIXPKGS_ALLOW_UNFREE=1` is required by Nix to install elasticsearch7. Note that first time you run `nix-shell` it will download all the nix packages, so it will take some time. Be patient!
```bash
NIXPKGS_ALLOW_UNFREE=1 nix-shell
```
---
**NOTE**
The only commands you must run as root are the ones below to create the folder `/var/log/nginx`. I've not found out how to avoid it.
```bash
sudo mkdir -p /var/log/nginx;
sudo chown `whoami` /var/log/nginx;
```
---
- Initialize the project. It will mainly create temporary folders, configuration files and the database.
```bash
make init
```
- Start all the services (i.e. nginx, php-fpm, mysql, redis, rabbitmq, elasticsearch). In case you want to also start Varnish, read the Varnish section below.
```bash
make start
```
- In another terminal, open a new nix-shell and install magento code. It will install magento2 CE and sample data by default. If you want to use an existing folder you can skip this step and change APP_PATH variable of `.env` file  to point to the folder with magento2 code.
```bash
NIXPKGS_ALLOW_UNFREE=1 nix-shell
make install
```
- Open a browser with `http://localhost:3000` and hopefully you will see the Luma store. For accessing the Admin panel, open a browser with `http://localhost:3000/admin/' with the following credentials:
```
username: admin
password: 123123q
```

## Run
Once installed, you will only need to start the nix shell and run `make start`.
```bash
NIXPKGS_ALLOW_UNFREE=1 nix-shell
make start
```

## Stop
Just cancel the execution with Ctrl-C in the nix shell where you run `make start`.

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
```bash
varnishlog -n $(pwd)/var/varnish/data/
```

## Next steps
- be able to run MFTF tests
- certificates
