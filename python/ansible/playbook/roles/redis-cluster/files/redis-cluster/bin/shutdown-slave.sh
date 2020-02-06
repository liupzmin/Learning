#!/bin/bash

#set env
REDIS_HOME=/home/appsvr/RedisSvr

#run svr
$REDIS_HOME/bin/redis-cli -p 6380  shutdown save  1>>$REDIS_HOME/logs/shutdown_slave.log 
