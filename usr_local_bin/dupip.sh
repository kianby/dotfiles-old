#!/bin/bash
#
#   Find duplicated IP on a C-network LAN
#

usage () {
    echo "Usage: `basename $0` c-network "
    echo "  c-network: C-Class network address"
    echo
    echo "Examples:"
    echo "> `basename $0` 192.168.0"
    echo
    exit 0
}

if [ "$#" -lt 1 ]; then
    usage
fi

for ip in $(seq 1 1 254)
do
  count=$(arping -i eth0 -d -c 2 $1.$ip | grep "bytes from" | wc | awk '{print $1}')
  if [ "$count" -gt "2" ]; then
    echo "duplicated IP $1.$ip => $count"
  fi
done
