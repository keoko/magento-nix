#! /bin/bash

git clone git@github.com:magento-commerce/magento2ce.git --single-branch --branch 2.4-develop --depth 1

cd magento2ce
git clone git@github.com:magento-commerce/magento2ee.git --single-branch --branch 2.4-develop --depth 1
git clone git@github.com:magento-commerce/magento2-sample-data.git --single-branch --branch 2.4-develop --depth 1

php magento2ee/dev/tools/build-ee.php --ce-source . --ee-source magento2ee
php magento2ee/dev/tools/build-ee.php --ce-source . --ee-source magento2-sample-data

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
   --db-host=127.0.0.1:3306 \
   --db-user=root \
   --db-password=root

# setup redis caches
# bin/magento setup:config:set -n --page-cache=redis --page-cache-redis-server=redis --cache-backend-redis-db=3
bin/magento setup:config:set -n --session-save=redis --session-save-redis-host=127.0.0.1 --cache-backend-redis-db=0
bin/magento setup:config:set -n --cache-backend=redis --cache-backend-redis-server=127.0.0.1 --cache-backend-redis-db=1

# setup rabbitmq
bin/magento setup:config:set -n --amqp-host=127.0.0.1 --amqp-user=guest --amqp-password=guest

# setup varnish
# ENABLE_VARNISH: uncomment the following line to enable varnish
# bin/magento config:set --scope=default --scope-code=0 system/full_page_cache/caching_application 2
