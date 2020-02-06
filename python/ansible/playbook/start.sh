#!/bin/bash

ansible background -i hosts -u ec2-user -m shell -a "cd ~/ccts-cms/bin && ./startup.sh"

sleep 5

ansible background -i hosts -u ec2-user -m shell -a "cd ~/ccts-sms-relay/bin && ./startup.sh"


sleep 5

ansible background -i hosts -u ec2-user -m shell -a "cd ~/ccts-mail-relay/bin && ./startup.sh"

sleep 5

ansible ccts-trader-persistent -i hosts -u ec2-user -m shell -a "cd ~/ccts-trader-persistent/bin && ./startup.sh"

sleep 5

ansible ccts-assets-persistent -i hosts -u ec2-user -m shell -a "cd ~/ccts-assets-persistent/bin && ./startup.sh"

sleep 5

ansible background -i hosts -u ec2-user -m shell -a "cd ~/ccts-authority-center/bin && ./startup.sh"

sleep 5

ansible background -i hosts -u ec2-user -m shell -a "cd ~/ccts-market-future/bin && ./startup.sh"

sleep 5

ansible background -i hosts -u ec2-user -m shell -a "cd ~/ccts-account-notification/bin && ./startup.sh"

sleep 5


ansible background -i hosts -u ec2-user -m shell -a "cd ~/ccts-customer-center/bin && ./startup.sh"

sleep 5

ansible background -i hosts -u ec2-user -m shell -a "cd ~/ccts-assets-center/bin && ./startup.sh"

sleep 30

ansible background -i hosts -u ec2-user -m shell -a "cd ~/ccts-clearing/bin && ./startup.sh"

sleep 5

ansible background -i hosts -u ec2-user -m shell -a "cd ~/ccts-system-timing/bin && ./startup.sh"

sleep 30

ansible ccts-data-center -i hosts -u ec2-user -m shell -a "cd ~/ccts-data-center/bin && ./startup.sh"

sleep 5

ansible ccts-quotation-calculate-unit -i hosts -u ec2-user -m shell -a "cd ~/ccts-quotation-calculate-unit/bin && ./startup.sh"

sleep 5

ansible ccts-quotation-dayline -i hosts -u ec2-user -m shell -a "cd ~/ccts-quotation-kline/bin && ./startup.sh"

sleep 5

ansible ccts-quotation-dayline -i hosts -u ec2-user -m shell -a "cd ~/ccts-quotation-dayline/bin && ./startup.sh"

sleep 5

ansible ccts-quotation-spot-price -i hosts -u ec2-user -m shell -a "cd ~/ccts-quotation-spot-price/bin && ./startup.sh"

sleep 5

ansible ccts-quotation-gateway -i hosts -u ec2-user -m shell -a "cd ~/ccts-quotation-gateway/bin && ./startup.sh"

sleep 5

ansible ccts-business-center -i hosts -u ec2-user -m shell -a "cd ~/ccts-business-center/bin && ./startup.sh"

#ansible ccts-business-center -i hosts -u ec2-user -m shell -a "cd ~/ccts-business-center2/ccts-business-center/bin && ./startup.sh"

sleep 5

ansible ccts-match-engine -i hosts -u ec2-user -m shell -a "cd ~/ccts-match-engine/bin && ./startup.sh"

sleep 5

ansible ccts-risk-engine -i hosts -u ec2-user -m shell -a "cd ~/risk-engine/bin && ./startup.sh"

sleep 5

ansible background -i hosts -u ec2-user -m shell -a "cd ~/ccts-trading-status/bin && ./startup.sh"

sleep 5

ansible background -i hosts -u ec2-user -m shell -a "cd ~/ccts-assets-proxy-out/bin && ./startup.sh"

sleep 5

ansible background -i hosts -u ec2-user -m shell -a "cd ~/ccts-assets-proxy-in/bin && ./startup.sh"

sleep 5

ansible background -i hosts -u ec2-user -m shell -a "cd ~/ccts-system-manager/bin && ./startup.sh"

sleep 5

ansible ccts-own-gateway -i hosts -u ec2-user -m shell -a "cd ~/ccts-own-gateway/bin && ./startup.sh"
