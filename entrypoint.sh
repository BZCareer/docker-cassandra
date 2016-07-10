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

if [ -z "$CASSIE_BROADCAST_HOSTNAME" ]; then
  sed -i -e "s/listen_address:.*/listen_address:  $CASSIE_BROADCAST_HOSTNAME  /"  /usr/local/cassandra/conf/cassandra.yaml
  echo "broadcast_address: $CASSIE_BROADCAST_HOSTNAME " >>  /usr/local/cassandra/conf/cassandra.yaml
  echo "broadcast_rpc_address: $CASSIE_BROADCAST_HOSTNAME "  >>  /usr/local/cassandra/conf/cassandra.yaml
else
  sed -i -e "s/listen_address:.*/listen_address: $(cat /etc/hosts  |grep $HOSTNAME  | awk '{print $1}')/"  /usr/local/cassandra/conf/cassandra.yaml
  echo "broadcast_address: $(cat /etc/hosts  |grep $HOSTNAME  | awk '{print $1}')" >>  /usr/local/cassandra/conf/cassandra.yaml
  echo "broadcast_rpc_address: $(cat /etc/hosts  |grep $HOSTNAME  | awk '{print $1}')" >>  /usr/local/cassandra/conf/cassandra.yaml
fi

# Creating required directories
mkdir -p /usr/local/cassandra/data/data
mkdir -p /usr/local/cassandra/data/commitlog
mkdir -p /usr/local/cassandra/data/saved_caches
mkdir -p /usr/local/cassandra/data/hints

cat /etc/security/limits.d/cassandra.conf


# RUN CASSANDRA
/usr/local/cassandra/bin/cassandra -f -R
