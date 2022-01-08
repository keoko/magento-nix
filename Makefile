include .env
export $(shell sed 's/=.*//' .env)

.PHONY: init
init: init-folders init-conf-files init-db

.PHONY: start
start:
	hivemind

.PHONY: stop
stop: killall

.PHONY: killall
killall:
	@# for the meaning of ||: see https://stackoverflow.com/questions/11871921/suppress-and-ignore-output-for-makefile
	pkill php-fpm ||:
	pkill nginx ||:
	pkill redis-server ||:
	pkill mysqld_safe ||:
	pkill elasticsearch ||:
	pkill varnishd ||:
	pkill rabbitmq-server ||:
	pkill epmd ||:

.PHONY: install
install: clean install-rabbitmq-plugins install-db
	./install.sh

.PHONY: clean
clean:
	redis-cli flushall

.PHONY: restart
restart: stop start

.PHONY: init-folders
init-folders:
	mkdir -p $(LOG_PATH)
	mkdir -p $(RUN_PATH)
	mkdir -p $(MYSQL_DATA)
	mkdir -p $(MYSQL_TMP)
	mkdir -p $(ES_DATA)
	mkdir -p $(REDIS_DATA)
	mkdir -p $(RABBITMQ_DATA)
	mkdir -p $(VARNISH_DATA)
	mkdir -p $(PHP_DATA)
	mkdir -p $(NGINX_DATA)

.PHONY: init-conf-files
init-conf-files:
	envsubst '$$NGINX_PORT $$APP_CODE $$NGINX_DATA $$NGINX_CONF_PATH $$LOG_PATH $$RUN_PATH' < conf/nginx/nginx.conf.template > conf/nginx/nginx.conf
	envsubst '$$LOG_PATH $$RUN_PATH $$PHP_SESSION_PATH $$PHP_DATA' < conf/php/php.ini.template > conf/php/php.ini
	envsubst '$$LOG_PATH $$ES_DATA' < conf/elasticsearch/elasticsearch.yml.template > conf/elasticsearch/elasticsearch.yml
	envsubst '$$LOG_PATH' < conf/elasticsearch/jvm.options.template > conf/elasticsearch/jvm.options

.PHONY: init-db
init-db:
	rm -rf $(MYSQL_TMP)/* $(MYSQL_DATA)/*
	mysqld --initialize-insecure --console --port=${MYSQL_PORT} --socket=$(MYSQL_SOCKET) --tmpdir=$(MYSQL_TMP) --datadir=$(MYSQL_DATA)

.PHONY: install-rabbitmq-plugins
install-rabbitmq-plugins:
	rabbitmq-plugins enable rabbitmq_management

.PHONY: install-db
install-db:
	mysql --user=root --password='' --host='127.0.0.1' --port=$(MYSQL_PORT) -e "CREATE DATABASE IF NOT EXISTS magento"

.PHONY: start-selenium
start-selenium:
	java -jar $$(dirname $$(dirname $$(which selenium-server)))/share/lib/selenium-server-standalone-3.141.59/selenium-server-standalone-3.141.59.jar

.PHONY: prepare-mftf-tests
prepare-mftf-tests:
	./bin/prepare-mftf-tests.sh

.PHONY: run-mftf
run-mftf:
	cd ${APP_CODE} && ./vendor/bin/mftf run:test ${MFTF_TEST}

.PHONY: seek-and-destroy
seek-and-destroy:
	rm -rf $(LOG_PATH)
	rm -rf $(RUN_PATH)
	rm -rf $(MYSQL_DATA)
	rm -rf $(MYSQL_TMP)
	rm -rf $(ES_DATA)
	rm -rf $(REDIS_DATA)
	rm -rf $(RABBITMQ_DATA)
	rm -rf $(VARNISH_DATA)
	rm -rf $(PHP_DATA)
	rm -rf $(NGINX_DATA)
	rm -rf ${APP_CODE}/var/*
	rm -rf ${APP_CODE}/generated/code/*
