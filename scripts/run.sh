#!/bin/sh
if [ "$MYSQL_HOST" = "localhost" ] ||  [ "$MYSQL_HOST" = "127.0.0.1" ]; then
	sh /app/install-mysql.sh
fi

envsubst < config.docker.yaml > config.yaml
while :
do
    node index.js
    sleep 2
done
