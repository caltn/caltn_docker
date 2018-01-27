FROM node:latest


RUN mkdir -p /home/myapp

WORKDIR /home/myapp
RUN  npm install pm2 -g --no-optional\
     && npm install 

CMD pm2 start ./bin/www --no-daemon