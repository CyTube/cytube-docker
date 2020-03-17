# sync-docker-compose
Docker compose for sync by calzoneman

https://github.com/calzoneman/sync

## How to get started

To run this application first you must clone the repo using ```git clone --recursive https://github.com/Aersaud/cytube-docker.git```

Next you will need to run copy_config.sh in order to automatically copy the latest versions of the config from the sync folder. You may also choose to do this manually. You will need the conf/example and a config.yaml files so that they can be mounted into the container. The script is there to make this easier for you by downloading the necessary files.

After you have the files, open the config.yaml file and edit the information in the config to meet your specific needs.
calzoneman has thoroughly commented the file to give you a good idea of what needs to be edited.

After editing your config.yaml file you will need to edit the docker-compose.yml to match what you have entered in the config.yaml file. It is commented to give you an idea of what needs to be edited.

When you have finished the previous steps start the containers by running ```docker-compose up -d``` this will cause docker-compose to build the Dockerfile and start the sync and mariadb/mysql containers.

## Nginx Reverse Proxy Config

Here is an example config for using Nginx to reverse proxy sync using https on port 8443.

```
server {

    listen 443 ssl http2;
    server_name sync.example.com;
    ssl_certificate /etc/letsencrypt/live/example.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/example.com/privkey.pem;
    include /etc/letsencrypt/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;


        location / {
                proxy_pass https://sync:8443;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Forwarded-Proto $scheme;
                proxy_set_header Host $http_host;
                   }
}
```

If you already have a reverse proxy in place such as Nginx you must add the network to the sync container in the docker-compose.yml file.

Example docker-compose.yml configuration with a Reverse Proxy:

```
version: "3.7"
services:
   sync:
     build: .
     depends_on:
       - "mysql"
     ports:
       - "8980:8080"
       - "1337:1337"
       - "8443:8443"
     volumes:
       - "./certs:/etc/certs"
       - "./config.yaml:/home/syncuser/sync/config.yaml"
     networks:
        - sync_internal
# This is an example of the network where the nginx is located
        - my_reverse_proxy_network
   mysql:
     image: mariadb:10.5.1
     environment:
       - MYSQL_ROOT_PASSWORD=sync 
       - MYSQL_DATABASE=cytube3 
       - MYSQL_USER=cytube3
       - MYSQL_PASSWORD=super_secure_password
     volumes:
       - "./mysql:/var/lib/mysql"      
     networks:
       - sync_internal
networks:
  sync_internal:
# You must also add the network here and clarify that the network is external from this docker-compose.yml file
  my_reverse_proxy_network:
    external: true
```
