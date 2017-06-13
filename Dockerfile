FROM alpine:3.6

ARG FROM_REPOSITORY=https://github.com/calzoneman/sync

ADD scripts /scripts

RUN sh /scripts/container-install.sh

WORKDIR /app

ENV MYSQL_HOST=localhost \
	MYSQL_PORT=3306 \
	MYSQL_DATABASE=cytube \
	MYSQL_USER=cytube \
	MYSQL_PASSWORD=nico_best_girl \
	MYSQL_ROOT_PASSWORD=ruby_best_girl \
	SYNC_TITLE=Sync \
	SYNC_DESCRIPTION="Sync Video" \
	ROOT_URL=http://localhost:8080 \
	ROOT_PORT=8080 \
	IO_ROOT_URL=http://localhost \
	IO_ROOT_PORT=1337 \
	ROOT_DOMAIN=localhost:8080 \
	HTTPS_ENABLED=false \
	YOUTUBE_KEY=your_youtube_key \
	TWITCH_CLIENT_ID=your_twitch_client_id

EXPOSE 8080 1337

CMD ["sh", "run.sh"]
