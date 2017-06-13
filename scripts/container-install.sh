#!/bin/sh

set -e

apk update
apk add build-base python git nodejs nodejs-npm curl gettext ffmpeg
npm install npm@latest -g

git clone $FROM_REPOSITORY /app

cd /app
cp -f /scripts/config.docker.yaml /app
cp -f /scripts/install-mysql.sh /app
cp -f /scripts/run.sh /app
cp -f /scripts/package.json /app

npm install
npm run build-server
