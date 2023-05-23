#!/bin/bash

sudo docker stop part6_server_1
sudo docker stop part6_proxy_1
sudo docker rm part6_server_1
sudo docker rm art6_proxy_1
sudo docker rmi part6_proxy -f
sudo docker rmi part6_server -f
sudo docker rmi alpine -f