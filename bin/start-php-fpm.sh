#!/usr/bin/env bash
# This script starts php-fpm so they can be terminated when overmind stops all defined services.
# The strategy is catching the GSGINT signal to explicitly kill all php-fpm processes.
# Other people have reported same issue with similar applications (i.e. foreman) https://stackoverflow.com/questions/11871921/suppress-and-ignore-output-for-makefile
trap 'kill_em_all' SIGINT

kill_em_all() {
   echo "force killing all php-fpm processes"
   pkill php-fpm
}

php-fpm --nodaemonize --prefix . --fpm-config conf/php/php-fpm.conf &
wait -n
