web: nginx -c ${NGINX_CONF_FILE} -p ${PWD}
php-fpm: php-fpm --php-ini ${PHP_INI_FILE} --nodaemonize --prefix . --fpm-config ${PHP_FPM_FILE}
db: mysqld_safe --port ${MYSQL_PORT} --socket=${MYSQL_SOCKET} --tmpdir=${MYSQL_TMP} --datadir=${MYSQL_DATA}
elastic: elasticsearch -p ${ES_PID}
redis: redis-server --port ${REDIS_PORT} --dir ${REDIS_DATA}
mail: MailHog
# ENABLE_RABBITMQ: uncomment the following line to enable rabbitmq
# rabbitmq: rabbitmq-server
# ENABLE_VARNISH: uncomment the following line to enable varnish
# varnish: varnishd -F -f ${VARNISH_CONFIG_FILE} -a 127.0.0.1:${VARNISH_PORT} -n ${VARNISH_DATA}
