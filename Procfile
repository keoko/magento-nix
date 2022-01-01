web: nginx -g 'daemon off;' -p . -c ${NGINX_CONF_FILE}
php-fpm: php-fpm --php-ini ${PHP_INI_FILE} --nodaemonize --prefix . --fpm-config ${PHP_FPM_FILE}
db: mysqld_safe --socket=${MYSQL_SOCKET} --tmpdir=${MYSQL_TMP} --datadir=${MYSQL_DATA}
elastic: elasticsearch -p ${ES_PID}
redis: redis-server --dir ${REDIS_DATA}
rabbitmq: rabbitmq-server
# ENABLE_VARNISH: uncomment the following line to enable varnish
# varnish: varnishd -F -f ${VARNISH_CONFIG_FILE}  -n ${VARNISH_DATA}
