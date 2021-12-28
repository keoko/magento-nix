
.PHONY: init-folders
init-folders:
	mkdir -p var/{log,run,elasticsearch/data,mysql/{data,tmp},redis/data}

.PHONY: init-db
init-db:
	rm -rf var/mysql/data/* var/mysql/tmp/*
	mysqld --initialize-insecure --console --socket=$$(pwd)/var/run/mysql.sock --tmpdir=$$(pwd)/var/mysql/tmp --datadir=./var/mysql/data --socket=$$(pwd)/var/mysql/mysql.sock
	mysqld --socket=$$(pwd)/var/run/mysql.sock --tmpdir=$$(pwd)/var/mysql/tmp --datadir=./var/mysql/data --socket=$$(pwd)/var/mysql/mysql.sock
	mysql -u root --password='' -P 3306 -e "CREATE DATABASE IF NOT EXISTS magento"

.PHONY: init
init: init-db init-folders

.PHONY: install
install:
	./install.sh

.PHONY: clean
clean:
	rm -rf magento2ce

.PHONY: start
start:
	overmind start

.PHONY: killall
killall:
	echo "killing php-fpm processes ..."
	kill -9 `ps -ef | grep php-fpm | grep -v grep | awk '{print $$2}'`
	echo "killing nginx processes ..."
	killall nginx
	echo "killing mysql processes ..."
	killall mysqld
	echo "done"

.PHONY: restart
restart: killall start

