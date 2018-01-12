#!/bin/bash -e
sudo apt update
sudo apt-get install -y --no-install-recommends python-minimal
sudo apt-get install ansible -y
sudo apt-get install jq -y

################################################################################
#add zabixx monitor _ auto registration

echo "#!/bin/bash
date >> ~/add_monitor.log
echo "add_monitor wass secsessfull" >> ~/add_monitor.log" > /usr/local/bin/add_monitor.sh

echo "#!/bin/bash
HOST_ID=$(cat /home/ubuntu/zabbix.conf | grep hostids |  cut -d"\"" -f10
USER='Admin'
PASS='admin'
ZABBIX_SERVER='35.205.201.49'
API='http://35.205.201.49/zabbix/api_jsonrpc.php'

# Authenticate with Zabbix API

authenticate() {
  echo `curl -s -H  'Content-Type: application/json-rpc' -d "{\"jsonrpc\": \"2.0\",\"method\":\"user.login\",\"params\":{\"user\":\""${USER}"\",\"password\":\""${PASS}"\"},\"auth\": null,\"id\":0}" $API`
}

dell_host(){
  curl -i POST -H 'Content-Type: application/json-rpc' -d "{\"jsonrpc\": \"2.0\",\"method\": \"host.delete\",\"params\": [\"$HOST_ID\"],\"auth\": \"$AUTH_TOKEN\",\"id\": 1}" $API
}

AUTH_TOKEN=`echo $(authenticate)|jq -r .result`

DELL_HOST=$(dell_host)

echo "dell_monitor wass secsessfull" >> ~/dell_monitor.log" > /usr/local/bin/dell_monitor.sh

#### adding files config

echo "[Unit]
After=mysql.service

[Service]
ExecStart=/usr/local/bin/add_monitor.sh

[Install]
WantedBy=default.target" > /etc/systemd/system/add_monitor.service


echo "[Unit]
Before=shutdown.target reboot.target
After=mysql.service
Requires=network.target

[Service]
ExecStart=/usr/local/bin/dell_monitor.sh

[Install]
WantedBy=default.target" > /etc/systemd/system/dell_monitor.service


for CONF in add_monitor dell_monitor;do
  chmod 744 /usr/local/bin/$CONF.sh
  chmod 664 /etc/systemd/system/$CONF.service
  systemctl daemon-reload
  systemctl enable $CONF.service
done
