#!/bin/bash

#set env
REDIS_HOME=$HOME/redis-cluster

#run svr
$REDIS_HOME/bin/redis-cli  -p  7001   shutdown    1>>$REDIS_HOME/logs/shutdown_master.log 
