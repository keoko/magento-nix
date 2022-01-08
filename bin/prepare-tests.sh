#! /usr/bin/env bash


prepare-tests:
	mysql -u root --password='' --socket=$(MYSQL_SOCKET) -P $(MYSQL_PORT) -e "CREATE DATABASE IF NOT EXISTS magento_integration_tests;"
	mysql -u root --password='' --socket=$(MYSQL_SOCKET) -P $(MYSQL_PORT) -e "CREATE USER 'integration_tests_user'@'%' IDENTIFIED BY '';"
	mysql -u root --password='' --socket=$(MYSQL_SOCKET) -P $(MYSQL_PORT) -e "GRANT ALL PRIVILEGES ON magento_integration_tests.* TO 'integration_tests_user'@'%' WITH GRANT OPTION;"
	mysql -u root --password='' --socket=$(MYSQL_SOCKET) -P $(MYSQL_PORT) -e "FLUSH PRIVILEGES;"
	@# TODO replace ports in install-mysql.php.dist
	cp ${APP_CODE}/dev/tests/integration/etc/install-config-mysql.php.dist ${APP_CODE}/dev/tests/integration/etc/install-config-mysql.php
	cp ${APP_CODE}/dev/tests/integration/etc/config-global.php.dist ${APP_CODE}/dev/tests/integration/etc/config-global.php
	@# TOODO change phpunit.xml file: memory_limit, TESTS_CLEANUP, RABBITMQ_MANAGEMENT_PORT
	@# dev/tests/integration/phpunit.xml.dist
	bin/magento config:set cms/wysiwyg/enabled disabled
	bin/magento cache:clean config full_page
	bin/magento config:set admin/security/admin_account_sharing 1
	bin/magento config:set admin/security/use_form_key 0


