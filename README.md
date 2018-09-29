# cytube-docker

Docker image for CyTube

*This repository is currently very alpha and a work in progress*

This image uses an Alpine image as a base along with an integrated MariaDB instance, to create a dockerfile/image that could be used for both development purposes and production deployments. This image results in a running instance of Cytube built from mainline git. Various parts of the config.yaml template have been replaced with environment variables, to allow deployment to be easily adjusted for production. The following environment variables are set in the dockerfile:

```
MYSQL_HOST=localhost
MYSQL_PORT=3306
MYSQL_DATABASE=cytube3
MYSQL_USER=cytube3
MYSQL_PASSWORD=UltraSecretPass
MYSQL_ROOT_PASSWORD=UltraSecretRootPass
HTTP_PORT=8080
HTTP=true
HTTPS_PORT=8443
HTTPS=false
IO=true
IO_PORT=1337
IO_DOMAIN=http://localhost
ROOT_DOMAIN=localhost
USE_MINIFY=false
COOKIE_SECRET=change-me
SYNC_CRTKEY=null
SYNC_CRT=null
SYNC_CRTCA=null
SYNC_TITLE=Sync
SYNC_DESCRIPTION="Free, open source synchtube"
YOUTUBE_KEY=null
CHANNEL_STORAGE=file
VIMEO_WORKAROUND=false
TWITCH_ID=null
MIXER_ID=null
```

If you will be using the local mysql instance and are using it for production, you will want to specify a bind mount to ensure that your user and channel information is retained across deployments. The Alpine-based MariaDB image is a drop-in replacement for the official MariaDB image, so you can reference their page for further documentation:

https://hub.docker.com/_/mariadb/

Eventually this will be updated with the option to not install and run MariaDB, which will be the most ideal for those using this for production with a remote sql server.

Build:

```
docker build -t cytube-docker .
```

Deploy Examples:

```
docker run --name cytube-dev -ti -p 8080:8080 -p 1337:1337 -d cytube-docker
```

```
docker run --name cytube-live -ti \
	-p 443:8443 -p 1337:1337 \
	-v /home/user/mysqlstore:/var/lib/mysql \
	-v /home/user/certs:/home/cytube/certs \
	-e MYSQL_PASSWORD=SecretPass \
	-e MYSQL_ROOT_PASSWORD=RootPass \
	-e HTTP=false \
	-e HTTPS=true \
	-e IO_DOMAIN=https://site.com \
	-e ROOT_DOMAIN=site.com \
	-e COOKIE_SECRET=me-change \
	-e SYNC_CRTKEY=/home/cytube/certs/crt.key \
	-e SYNC_CRT=/home/cytube/certs/crt.crt \
	-e SYNC_CRTCA=/home/cytube/certs/ca.crt \
	-e SYNC_TITLE=Dync \
	-e YOUTUBE_KEY=SecretYoutubeKey \
	-e TWITCH_ID=SecretTwitchKey \
	-e MIXER_ID=SecretMixerKey \
	-d cytube-docker
```
