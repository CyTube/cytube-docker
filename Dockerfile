from node:latest

CMD apt update && apt upgrade -y && apt install build-essential git -y

RUN useradd -ms /bin/bash syncuser

USER syncuser
WORKDIR /home/syncuser

RUN git clone -b 3.0 https://github.com/calzoneman/sync

WORKDIR /home/syncuser/sync

RUN npm install

CMD [ "node", "index.js" ]
