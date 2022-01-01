include .env
export $(shell sed 's/=.*//' .env)

.PHONY: init
init: init-folders init-db

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

.PHONY: install
install: install-rabbitmq-plugins install-db
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

.PHONY: init-db
init-db:
	rm -rf $(MYSQL_TMP)/* $(MYSQL_DATA)/*
	mysqld --initialize-insecure --console --socket=$(MYSQL_SOCKET) --tmpdir=$(MYSQL_TMP) --datadir=$(MYSQL_DATA)

.PHONY: install-rabbitmq-plugins
install-rabbitmq-plugins:
	rabbitmq-plugins enable rabbitmq_management

.PHONY: install-db
install-db:
	mysql -u root --password='' -P $(MYSQL_PORT) -e "CREATE DATABASE IF NOT EXISTS magento"
