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

