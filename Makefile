
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
	OVERMIND_DAEMONIZE=1 overmind start

.PHONY: stop
stop:
	overmind kill ||:
	@# kill all services as overmind may leave services running, see https://stackoverflow.com/questions/11871921/suppress-and-ignore-output-for-makefile
	@# for the meaning of ||: see https://stackoverflow.com/questions/11871921/suppress-and-ignore-output-for-makefile
	pkill php-fpm ||:
	pkill nginx ||:
	pkill redis-server ||:
	pkill mysqld_safe ||:
	pkill elasticsearch ||:

.PHONY: restart
restart: stop start

