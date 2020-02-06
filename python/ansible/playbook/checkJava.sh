#!/bin/bash

ansible all -i hosts -u root -m shell -a "ps -ef|grep java"

