#!/bin/bash
# Author: Zak Hassan

# SETUP CONFIGURATIONS:
sed -i -e "s/- seeds: .*/- seeds: \"$HOSTNAME\"/" /usr/local/cassandra/conf/cassandra.yaml
sed -i -e "s/listen_address:.*/listen_address: $(cat /etc/hosts  |grep $HOSTNAME  | awk '{print $1}')/"  /usr/local/cassandra/conf/cassandra.yaml
echo "broadcast_address: $(cat /etc/hosts  |grep $HOSTNAME  | awk '{print $1}')" >>  /usr/local/cassandra/conf/cassandra.yaml
echo "broadcast_rpc_address: $(cat /etc/hosts  |grep $HOSTNAME  | awk '{print $1}')" >>  /usr/local/cassandra/conf/cassandra.yaml

# RUN CASSANDRA
/usr/local/cassandra/bin/cassandra -f -R
