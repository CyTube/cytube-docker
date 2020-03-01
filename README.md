# sync-docker-compose
Docker compose for sync by calzoneman

https://github.com/calzoneman/sync

## How to get started

To run this application first you must clone the repo.

Next you will need to run get_latest_configs.sh in order to automatically pull the latest versions of the config from the sync repo. You may also choose to do this manually. You will need the conf/example and a config.yaml files so that they can be mounted into the container. The script is there to make this easier for you by downloading the necessary files.

After you have the files, open the config.yaml file and edit the information in the config to meet your specific needs.
calzoneman has thoroughly commented the file to give you a good idea of what needs to be edited.

After editting your config.yaml file you will need to edit the docker-compose.yml to match what you have entered in the config.yaml file. It is commented to give you an idea of what needs to be editted.

When you have finished the previous steps start the containers by running ```docker-compose up -d``` this will cause docker-compose to build the Dockerfile and start the sync and mariadb/mysql containers.

## docker-compose.yml

This is the docker-compose.yml file, in this file you will need to update the environmental variables, ports, paths to your certificate files (if using SSL) and the path to your config file. Failure to update this will cause sync/cytube to not start.
The file has comments to help you edit what is necessary.
```
version: "3.7"
services:
   sync:
     build: .
     depends_on:
       - "mysql"
     ports:
# Change these ports to match your application settings defined in config.yaml
       - "8980:8080"
       - "1337:1337"
       - "8443:8443"
     volumes:
# Change the path to import your certificates for SSL
       - "./certs:/etc/certs"
# Change this path to import your config.yaml into the container. 
# By default it is in the same folder as the docker-compose.yml file.
       - "./config.yaml:/home/syncuser/sync/config.yaml"
# If you plan on using a reverse proxy please add the name of your docker network which contains the proxy.
# An example is provided in the Readme.
     networks:
        - sync_internal
   mysql:
     image: mariadb:10.5.1
     environment:
# Change these environmental variables to match what is in your config.yaml
       - MYSQL_ROOT_PASSWORD=sync 
       - MYSQL_DATABASE=cytube3 
       - MYSQL_USER=cytube3
       - MYSQL_PASSWORD=super_secure_password
     volumes:
# This will create and mount the mysql files in the same folder as the docker-compose.yml file.
# You can change this to be anywhere.
# This will provide data persistence to your MariaDB database.
       - "./mysql:/var/lib/mysql"      
     networks:
       - sync_internal
# If you are using a reverse proxy please do not forget to add the network here as well.
# Refer to the Readme for more information regarding using a Reverse Proxy.
networks:
  sync_internal:
```
