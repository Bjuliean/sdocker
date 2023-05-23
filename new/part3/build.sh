#!/bin/bash
sudo docker pull nginx
sudo docker run -d -p 81:81 --name temp nginx
sudo docker exec temp mkdir /etc/nginx/mini_server
sudo docker cp ./mini-server.c temp:etc/nginx/mini_server
sudo docker cp ./nginx.conf temp:/etc/nginx/nginx.conf
sudo docker exec temp apt-get update
sudo docker exec temp apt-get install -y gcc spawn-fcgi libfcgi-dev
sudo docker exec temp gcc /etc/nginx/mini_server/mini-server.c -o /etc/nginx/mini_server/mini-server.fcgi -lfcgi
sudo docker exec temp spawn-fcgi -p 8080 /etc/nginx/mini_server/mini-server.fcgi
sudo docker exec temp nginx -s reload
echo
curl http://localhost:81/
echo
echo
echo "Clean? (y\n)"
read symbol
if [ $symbol == 'y' ] || [ $symbol == 'Y' ] 
then
    ./clean.sh
fi