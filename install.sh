#! /usr/bin/env bash

git clone https://github.com/magento/magento2.git --single-branch --branch 2.4-develop --depth 1

cd magento2

# remove env.php file as it may exist from a previous installation
rm app/etc/env.php

composer install
bin/magento setup:install \
   --cleanup-database \
   --backend-frontname=admin \
   --admin-lastname=Admin \
   --admin-firstname=Admin \
   --admin-email=magento@mailinator.com \
   --admin-user=admin \
   --admin-password=123123q \
   --db-name=magento \
   --db-host=127.0.0.1:${MYSQL_PORT} \
   --db-user=root

# setup redis caches
# bin/magento setup:config:set -n --page-cache=redis --page-cache-redis-server=redis --cache-backend-redis-db=3
bin/magento setup:config:set -n --session-save=redis --session-save-redis-host=127.0.0.1 --cache-backend-redis-db=0
bin/magento setup:config:set -n --cache-backend=redis --cache-backend-redis-server=127.0.0.1 --cache-backend-redis-db=1

# setup rabbitmq
bin/magento setup:config:set -n --amqp-host=127.0.0.1 --amqp-port=${RABBITMQ_NODE_PORT} --amqp-user=guest --amqp-password=guest

# setup varnish
# ENABLE_VARNISH: uncomment the following line to enable varnish
# bin/magento config:set --scope=default --scope-code=0 system/full_page_cache/caching_application 2

# flush the cache
bin/magento cache:flush
