#!/bin/bash

#set env
REDIS_HOME=/home/appsvr/RedisSvr

#run svr
nohup $REDIS_HOME/bin/redis-server $REDIS_HOME/conf/svrredis_slave.conf 1>>$REDIS_HOME/logs/redis_slave.log 2>>$REDIS_HOME/logs/redis_slave_err.log &
