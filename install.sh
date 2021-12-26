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
#   --elasticsearch-host=elastic

