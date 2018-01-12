#!/bin/bash

for CONF in add_monitor dell_monitor;do
  chmod 744 /usr/local/bin/$CONF.sh
  chmod 664 /etc/systemd/system/$CONF.service
  systemctl daemon-reload
  systemctl enable $CONF.service
done
