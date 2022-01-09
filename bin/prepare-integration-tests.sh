#! /usr/bin/env bash

cd ${APP_CODE}

DB_USER="integation_tests_user"
DB_NAME="magento_integration_tests"
DB_PASSWORD=""

mysql --user=root --password='' --host='127.0.0.1' --port=${MYSQL_PORT} <<EOF
DROP DATABASE IF EXISTS ${DB_NAME};
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
DROP USER IF EXISTS ${DB_USER};
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

# TODO replace ports in install-mysql.php.dist
cp dev/tests/integration/etc/install-config-mysql.php.dist dev/tests/integration/etc/install-config-mysql.php
sed -i "s|'db-host' =>.*|'db-host' => '127.0.0.1:${MYSQL_PORT}',|" dev/tests/integration/etc/install-config-mysql.php
sed -i "s|'db-user' =>.*|'db-user' => '${DB_USER}',|" dev/tests/integration/etc/install-config-mysql.php
sed -i "s|'db-password' =>.*|'db-password' => '${DB_PASSWORD}',|" dev/tests/integration/etc/install-config-mysql.php
sed -i "s|'db-name' =>.*|'db-name' => '${DB_NAME}',|" dev/tests/integration/etc/install-config-mysql.php
cp dev/tests/integration/etc/config-global.php.dist dev/tests/integration/etc/config-global.php
# TOODO change phpunit.xml file: memory_limit, TESTS_CLEANUP, RABBITMQ_MANAGEMENT_PORT
# dev/tests/integration/phpunit.xml.dist
bin/magento config:set cms/wysiwyg/enabled disabled
bin/magento config:set admin/security/admin_account_sharing 1
bin/magento config:set admin/security/use_form_key 0
bin/magento cache:clean config full_page


