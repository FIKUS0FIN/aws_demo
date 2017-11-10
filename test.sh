#!/bin/bash
echo "start"

aws=1

function KILL ($aws) {
  if [[ $1 == "1" ]]; then
    echo "killing box "
  fi
}
