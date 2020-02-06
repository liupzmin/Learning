#!/bin/bash

ansible background -i hosts -u ec2-user -m shell -a "cd ~/ccts-cms/bin && ./shutdown.sh"

ansible background -i hosts -u ec2-user -m shell -a "cd ~/ccts-sms-relay/bin && ./shutdown.sh"

ansible background -i hosts -u ec2-user -m shell -a "cd ~/ccts-mail-relay/bin && ./shutdown.sh"

ansible ccts-trader-persistent -i hosts -u ec2-user -m shell -a "cd ~/ccts-trader-persistent/bin && ./shutdown.sh"

ansible ccts-assets-persistent -i hosts -u ec2-user -m shell -a "cd ~/ccts-assets-persistent/bin && ./shutdown.sh"

ansible background -i hosts -u ec2-user -m shell -a "cd ~/ccts-authority-center/bin && ./shutdown.sh"

ansible background -i hosts -u ec2-user -m shell -a "cd ~/ccts-market-future/bin && ./shutdown.sh"

ansible background -i hosts -u ec2-user -m shell -a "cd ~/ccts-account-notification/bin && ./shutdown.sh"

ansible background -i hosts -u ec2-user -m shell -a "cd ~/ccts-customer-center/bin && ./shutdown.sh"

ansible background -i hosts -u ec2-user -m shell -a "cd ~/ccts-assets-center/bin && ./shutdown.sh"

ansible background -i hosts -u ec2-user -m shell -a "cd ~/ccts-clearing/bin && ./shutdown.sh"

ansible background -i hosts -u ec2-user -m shell -a "cd ~/ccts-system-timing/bin && ./shutdown.sh"

ansible ccts-data-center -i hosts -u ec2-user -m shell -a "cd ~/ccts-data-center/bin && ./shutdown.sh"

ansible ccts-quotation-calculate-unit -i hosts -u ec2-user -m shell -a "cd ~/ccts-quotation-calculate-unit/bin && ./shutdown.sh"

ansible ccts-quotation-dayline -i hosts -u ec2-user -m shell -a "cd ~/ccts-quotation-kline/bin && ./shutdown.sh"

ansible ccts-quotation-dayline -i hosts -u ec2-user -m shell -a "cd ~/ccts-quotation-dayline/bin && ./shutdown.sh"

ansible ccts-quotation-spot-price -i hosts -u ec2-user -m shell -a "cd ~/ccts-quotation-spot-price/bin && ./shutdown.sh"

ansible ccts-quotation-gateway -i hosts -u ec2-user -m shell -a "cd ~/ccts-quotation-gateway/bin && ./shutdown.sh"

ansible ccts-business-center -i hosts -u ec2-user -m shell -a "cd ~/ccts-business-center/bin && ./shutdown.sh"
ansible ccts-business-center -i hosts -u ec2-user -m shell -a "cd ~/ccts-business-center2/ccts-business-center/bin && ./shutdown.sh"

ansible ccts-match-engine -i hosts -u ec2-user -m shell -a "cd ~/ccts-match-engine/bin && ./shutdown.sh"

ansible ccts-risk-engine -i hosts -u ec2-user -m shell -a "cd ~/risk-engine/bin && ./shutdown.sh"

ansible background -i hosts -u ec2-user -m shell -a "cd ~/ccts-trading-status/bin && ./shutdown.sh"

ansible background -i hosts -u ec2-user -m shell -a "cd ~/ccts-assets-proxy-out/bin && ./shutdown.sh"

ansible background -i hosts -u ec2-user -m shell -a "cd ~/ccts-assets-proxy-in/bin && ./shutdown.sh"

ansible background -i hosts -u ec2-user -m shell -a "cd ~/ccts-system-manager/bin && ./shutdown.sh"

ansible ccts-own-gateway -i hosts -u ec2-user -m shell -a "cd ~/ccts-own-gateway/bin && ./shutdown.sh"
