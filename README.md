# Magento Development Environment with nix
## Acthung
First time you run `nix-shell` it will download all the nix packages, so it will take some time. Be patient!
## Nginx
```
nginx -p . -c nginx.conf
```
## php-fpm
```
php-fpm -p . -y php-fpm.conf
```
## mysql
```
mysqld --defaults-file=my.cnf
```
### start
```
NIXPKGS_ALLOW_UNFREE=1 nix-shell
```
The environment variable `NIXPKGS_ALLOW_UNFREE=1` is required by Nix to install elasticsearch7.
