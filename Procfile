web: nginx -g 'daemon off;' -p . -c conf/nginx/nginx.conf
php-fpm: php-fpm --nodaemonize -p . -y conf/php/php-fpm.conf
db: mysqld --socket=$(pwd)/var/run/mysql.sock --tmpdir=$(pwd)/var/mysql/tmp --datadir=./var/mysql/data --socket=$(pwd)/var/mysql/mysql.sock
