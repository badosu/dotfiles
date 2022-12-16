#!/bin/bash

test -d /proc/sys/net/ipv4/conf/$1 &&
  echo "{\"class\": \"connected\"   , \"alt\": \"lock\"  , \"text\": \"$(sudo wg show all endpoints | cut -f3 | cut -d':' -f1)\", \"tooltip\": \"$(sudo wg show | sed -z 's/\n/\\n/g')\"}" ||
  echo "{\"class\": \"disconnected\", \"alt\": \"unlock\", \"text\": \"\",                                                        \"tooltip\": \"Wireguard Interface $1 disconnected\"}"
