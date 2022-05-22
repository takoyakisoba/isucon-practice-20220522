.PHONY: *

gogo: stop-services build truncate-logs start-services

stop-services:
	sudo systemctl stop nginx
	sudo systemctl stop isubata.golang
	sudo systemctl stop mysql

build:
	cd webapp/go && PATH=$(PATH):~/local/go/bin make

truncate-logs:
	sudo truncate --size 0 /var/log/nginx/access.log
	sudo truncate --size 0 /var/log/nginx/error.log
	sudo truncate --size 0 /var/log/mysql/mysql-slow.log && sudo chmod 666 /var/log/mysql/mysql-slow.log
	sudo truncate --size 0 /var/log/mysql/error.log

start-services:
	sudo systemctl start mysql
	sudo systemctl start isubata.golang
	sudo systemctl start nginx

bench:
	cd ~/isubata/bench && ./bin/bench -remotes localhost
