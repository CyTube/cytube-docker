#!/bin/sh

set -e

mysqld_safe &

npm install npm@latest -g

adduser -S cytube

mkdir -p /home/cytube/certs
git clone -b 3.0 https://github.com/calzoneman/sync /home/cytube/app
cd /home/cytube/app
git checkout $GIT_COMMIT
sed -i 's/67c7c69a/ffdbce8/' package.json
cp -f /scripts/config.docker.yaml /home/cytube/app
chown -R cytube: /home/cytube

su-exec cytube npm install

envsubst < config.docker.yaml > config.yaml
while :
do
    node index.js
    sleep 2
done