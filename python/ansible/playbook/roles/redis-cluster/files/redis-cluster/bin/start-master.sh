#!/bin/bash

#set env
REDIS_HOME=$HOME/redis-cluster

#run svr
$REDIS_HOME/bin/redis-server $REDIS_HOME/conf/redis.conf 
