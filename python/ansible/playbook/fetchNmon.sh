#!/bin/bash

ansible all -i hosts -u root -m fetch -a "src=/root/nmon_dist/stat.nmon dest=/root/nmon_dist/"

