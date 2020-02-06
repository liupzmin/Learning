#!/bin/bash

ansible redis -i hosts -u ec2-user -m shell -a "cd ~/redis/bin && ./redis-cli flushall"

ansible redis-cluster -i hosts -u ec2-user -m shell -a "cd ~/redis-cluster/bin && ./redis-cli -p 7001 flushall"

