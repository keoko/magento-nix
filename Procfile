web: nginx -g 'daemon off;' -p . -c conf/nginx/nginx.conf
php-fpm: ./bin/start-php-fpm.sh
db: mysqld_safe --socket=$(pwd)/var/run/mysql.sock --tmpdir=$(pwd)/var/mysql/tmp --datadir=$(pwd)/var/mysql/data --socket=$(pwd)/var/mysql/mysql.sock
elastic: ES_HOME=$(dirname $(dirname $(which elasticsearch))) ES_PATH_CONF=./conf/elasticsearch/ elasticsearch -p $(pwd)/var/run/elasticsearch.pid
redis: redis-server --dir var/redis/data/
# ENABLE_VARNISH: uncomment the following line to enable varnish
# varnish: varnishd -F -f $(pwd)/conf/varnish/default.vcl  -n $(pwd)/var/varnish/data/
