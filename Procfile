web: nginx -g 'daemon off;' -p . -c conf/nginx/nginx.conf
php-fpm: php-fpm --php-ini conf/php/php.ini --nodaemonize --prefix . --fpm-config conf/php/php-fpm.conf
db: mysqld_safe --socket=$(pwd)/var/run/mysql.sock --tmpdir=$(pwd)/var/mysql/tmp --datadir=$(pwd)/var/mysql/data --socket=$(pwd)/var/mysql/mysql.sock
elastic: ES_HOME=$(dirname $(dirname $(which elasticsearch))) ES_PATH_CONF=./conf/elasticsearch/ elasticsearch -p $(pwd)/var/run/elasticsearch.pid
redis: redis-server --dir var/redis/data/
rabbitmq: RABBITMQ_CONFIG_FILE=$(pwd)/conf/rabbitmq/rabbitmq.conf RABBITMQ_MNESIA_BASE=$(pwd)/var/rabbitmq/data/ RABBITMQ_LOG_BASE=$(pwd)/var/log/ RABBITMQ_ENABLED_PLUGINS_FILE=$(pwd)/var/rabbitmq/enabled_plugins rabbitmq-server
# ENABLE_VARNISH: uncomment the following line to enable varnish
# varnish: varnishd -F -f $(pwd)/conf/varnish/default.vcl  -n $(pwd)/var/varnish/data/
