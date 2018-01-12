#!/bin/bash

USER='Admin'
PASS='admin'
ZABBIX_SERVER='35.205.201.49'
API='http://35.205.201.49/zabbix/api_jsonrpc.php'

IP_ADDRESS="$(dig +short myip.opendns.com @resolver1.opendns.com)"

HOST_NAME=$(hostname)

# Authenticate with Zabbix API

authenticate() {
  echo `curl -s -H  'Content-Type: application/json-rpc' -d "{\"jsonrpc\": \"2.0\",\"method\":\"user.login\",\"params\":{\"user\":\""${USER}"\",\"password\":\""${PASS}"\"},\"auth\": null,\"id\":0}" $API`
}

get_host() {
  echo  $(curl -i -X POST -H 'Content-Type: application/json' -d "{\"jsonrpc\":\"2.0\",\"method\":\"host.get\",\"params\":{\"output\":\"extend\",\"filter\":{\"host\":\"Zabbix server\"}},\"auth\":\""${AUTH_TOKEN}"\",\"id\":1}" $API)
}

create_host() {
  curl -i -X POST -H 'Content-Type: application/json-rpc' -d "{\"jsonrpc\":\"2.0\",\"method\":\"host.create\",\"params\":{\"host\":\"$HOST_NAME\",\"interfaces\": [{\"type\": 1,\"main\": 1,\"useip\": 1,\"ip\": \"$IP_ADDRESS\",\"dns\": \"\",\"port\": \"10050\"}],\"groups\": [{\"groupid\": \"10\"}]},\"auth\":\"$AUTH_TOKEN\",\"id\":0}" $API
}

AUTH_TOKEN=`echo $(authenticate)|jq -r .result`

GET_HOST=$(get_host)

CREAT=$(create_host)

echo "$AUTH_TOKEN"
echo "$GET_HOST"
echo "$CREAT" > zabbix.conf


#echo "$GET_HOST"   # DEBUG PART
