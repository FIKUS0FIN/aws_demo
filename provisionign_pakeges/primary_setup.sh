#!/bin/bash -e
sudo apt update
sudo apt-get install -y --no-install-recommends python-minimal
sudo apt-get install ansible -y
apt install jq -y 

################################################################################
#add zabixx monitor _ auto registration

echo "[Unit]
Before=shutdown.target reboot.target
After=network.target
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
