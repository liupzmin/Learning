#!/bin/bash

ansible all -i hosts -u ec2-user -m shell -a "find . -name 'server.log*' | xargs rm -rf  "

ansible all -i hosts -u ec2-user -m shell -a "find . -name 'server.log' | xargs rm -rf  "
