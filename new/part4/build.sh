#!/bin/bash

sudo docker build -t img .
sudo docker run -d -p 80:81 --name temp img
sleep 2
echo
echo "curl localhost:80 =="
curl localhost:80
echo
echo "curl localhost:80/status =="
curl localhost:80/status
open http://localhost:80/
echo
echo "Clean? (y/n)"
read symbol
if [ $symbol == 'y' ] || [ $symbol == 'Y' ]
then
    ./clean.sh
fi