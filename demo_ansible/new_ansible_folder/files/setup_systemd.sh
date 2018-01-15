
  chmod 744 /usr/local/bin/dell_monitor.sh
  chmod 664 /etc/systemd/system/dell_monitor.service
  systemctl daemon-reload
  systemctl enable dell_monitor.service
