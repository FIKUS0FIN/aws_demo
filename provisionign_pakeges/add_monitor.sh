#!/bin/bash -e

apt-get update
  apt-get -y install zabbix-agent sysv-rc-conf
  sysv-rc-conf zabbix-agent on
  sed -i 's/Server=127.0.0.1/Server=35.189.247.128 /' /etc/zabbix/zabbix_agentd.conf
  sed -i 's/ServerActive=127.0.0.1/ServerActive=35.189.247.128/' /etc/zabbix/zabbix_agentd.conf
  HOSTNAME=`hostname` && sed -i "s/Hostname=Zabbix\ server/Hostname=$HOSTNAME/" /etc/zabbix/zabbix_agentd.conf
  service zabbix-agent restart
