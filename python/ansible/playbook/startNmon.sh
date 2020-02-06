#!/bin/bash

ansible all -i hosts -u root -m shell -a "rm -rf nmon_dist && mkdir nmon_dist && ./nmon -s 5 -c 24 -F /root/nmon_dist/stat.nmon"

