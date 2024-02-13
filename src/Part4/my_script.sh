#!/bin/bash

gcc my_server.c -lfcgi -o my_server
spawn-fcgi -p 8080 my_server
nginx -g "daemon off;"