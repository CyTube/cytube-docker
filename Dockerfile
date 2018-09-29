FROM alpine:3.8

ENV MYSQL_HOST=localhost \
	MYSQL_PORT=3306 \
	MYSQL_DATABASE=cytube3 \
	MYSQL_USER=cytube3 \
	MYSQL_PASSWORD=UltraSecretPass \
	MYSQL_ROOT_PASSWORD=UltraSecretRootPass \
	HTTP_PORT=8080 \
	HTTP=true \
	HTTPS_PORT=8443	\
	HTTPS=false \
	IO=true \
	IO_PORT=1337 \
	IO_DOMAIN=http://localhost \
	ROOT_DOMAIN=localhost \
	USE_MINIFY=false \
	COOKIE_SECRET=change-me \
	SYNC_CRTKEY=null \
	SYNC_CRT=null \
	SYNC_CRTCA=null \
	SYNC_TITLE=Sync \
	SYNC_DESCRIPTION="Free, open source synchtube" \
	YOUTUBE_KEY=null \
	CHANNEL_STORAGE=file \
	VIMEO_WORKAROUND=false \
	TWITCH_ID=null \
	MIXER_ID=null \
	LC_ALL=en_US.UTF-8

RUN mkdir /docker-entrypoint-initdb.d && \
	apk update && \
	apk -U upgrade && \
	apk add --no-cache mariadb mariadb-client && \
	apk add --no-cache tzdata && \
	apk add --no-cache build-base \
	python \
	git \
	nodejs \
	nodejs-npm \
	curl \
	gettext \
	ffmpeg \
	su-exec && \
	# clean up
	rm -rf /var/cache/apk/*

RUN sed -Ei 's/^(bind-address|log)/#&/' /etc/mysql/my.cnf && \
	# don't reverse lookup hostnames, they are usually another container
	sed -i '/^\[mysqld]$/a skip-host-cache\nskip-name-resolve' /etc/mysql/my.cnf && \
	# always run as user mysql
	sed -i '/^\[mysqld]$/a user=mysql' /etc/mysql/my.cnf && \
	# allow custom configurations
	echo -e '\n!includedir /etc/mysql/conf.d/' >> /etc/mysql/my.cnf && \
	mkdir -p /etc/mysql/conf.d/

VOLUME /var/lib/mysql

ADD scripts /scripts

RUN chmod +x /scripts/docker-entrypoint.sh

RUN chmod +x /scripts/run.sh

WORKDIR /home/cytube/app

ENTRYPOINT ["/scripts/docker-entrypoint.sh"]

EXPOSE ${MYSQL_PORT} ${HTTP_PORT} ${HTTPS_PORT} ${IO_PORT}

CMD ["/scripts/run.sh"]
