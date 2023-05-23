#!/bin/bash

service nginx start
spawn-fcgi -p 8080 ./mini-server
nginx -s reload
tail -f /dev/null