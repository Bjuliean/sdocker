#!/bin/bash

sudo docker-compose build
sudo docker-compose up
curl localhost:80
curl localhost:80/status