#!/bin/bash

ansible ccts-quotation-calculate-unit -i hosts -u ec2-user -m shell -a "cd ~/ccts-quotation-calculate-unit/data && rm -rf dempsey*"

ansible ccts-quotation-dayline -i hosts -u ec2-user -m shell -a "cd ~/ccts-quotation-kline/data && rm -rf dempsey*"

