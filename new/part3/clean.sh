#!/bin/bash

sudo docker stop temp
sudo docker rm temp
sudo docker rmi nginx -f