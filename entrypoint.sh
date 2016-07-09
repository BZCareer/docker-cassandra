#!/bin/bash
# Author: Zak Hassan

# SETUP CONFIGURATIONS:
if [ -z "$CASSIE_SEEDS" ]; then
  echo "CASSIE_SEEDS is not set defaulting to: $HOSTNAME for seeds"
  sed -i -e "s/- seeds: .*/- seeds: \"$HOSTNAME\"/" /usr/local/cassandra/conf/cassandra.yaml
else
  echo "CASSIE_SEEDS is set"
  sed -i -e "s/- seeds: .*/- seeds: \"$CASSIE_SEEDS\"/" /usr/local/cassandra/conf/cassandra.yaml

fi

sed -i -e "s/listen_address:.*/listen_address: $(cat /etc/hosts  |grep $HOSTNAME  | awk '{print $1}')/"  /usr/local/cassandra/conf/cassandra.yaml
echo "broadcast_address: $(cat /etc/hosts  |grep $HOSTNAME  | awk '{print $1}')" >>  /usr/local/cassandra/conf/cassandra.yaml
echo "broadcast_rpc_address: $(cat /etc/hosts  |grep $HOSTNAME  | awk '{print $1}')" >>  /usr/local/cassandra/conf/cassandra.yaml

# RUN CASSANDRA
/usr/local/cassandra/bin/cassandra -R
/bin/bash

if [ -z "$ZAK" ]; then
    echo "Need to set ZAK"
    exit 1
fi
