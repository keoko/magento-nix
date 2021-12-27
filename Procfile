web: nginx -g 'daemon off;' -p . -c conf/nginx/nginx.conf
php-fpm: php-fpm --nodaemonize -p . -y conf/php/php-fpm.conf
db: mysqld --defaults-file=conf/mysql/my.cnf
