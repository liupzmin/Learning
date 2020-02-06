#!/bin/bash

ansible redis-cluster -i hosts -u root -m shell -a "cd ~/redis-cluster/bin && ./redis-cli -p 7001 info | grep instantaneous_ops_per_sec "

