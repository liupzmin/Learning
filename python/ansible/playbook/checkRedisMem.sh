#!/bin/bash

ansible redis -i hosts -u ec2-user -m shell -a "cd ~/redis/bin && ./redis-cli info | grep used_memory_human  "

