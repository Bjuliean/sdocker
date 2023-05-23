#!/bin/bash

export DOCKER_CONTENT_TRUST=1
sudo docker build -t img:1.0 .
sudo docker run -d -p 80:81 --name temp img:1.0
sleep 2
echo
echo "curl localhost:80 =="
curl localhost:80
echo
echo "curl localhost:80/status =="
curl localhost:80/status
echo
echo "Clean? (y/n)"
read symbol
if [ $symbol == 'y' ] || [ $symbol == 'Y' ]
then
    ./clean.sh
else
    sudo docker stop temp
    sudo dockle img:1.0
fi