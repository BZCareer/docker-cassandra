Apache Cassandra on Docker
==========

In this repository you will find a docker file which will allow for running apache cassandra inside docker containers.


##Pull the image from Docker Repository
```
docker pull bzcareer/docker-cassandra:1.0.0-SNAPSHOT
```

## Building the image
Navigate to the bin directory and run
```
cd bin
./build.sh
```

or via docker commands:

```
docker build --rm -t bzcareer/docker-cassandra .
```
## Environment Variables

### `CASSIE_SEEDS`
 * Used for setting seeds for the cassandra cluster
 * It should be a comma separated list of server hostnames in your cluster for example:
 ```
 -e "CASSIE_SEEDS=hadoopmaster,hadoopdata1,hadoopdata2"
 ```
 * See below section titled `Running the image`
 * Warning: Its recommended that you don't set this variable unless you already have a cluster defined.

### Kubernetes environment variables available to Cassandra docker container:
```
MONITOR_D_PORT_7199_TCP=tcp://172.30.143.165:7199
MONITOR_D_PORT_8080_TCP_ADDR=172.30.143.165
MONITOR_D_PORT_7001_TCP_ADDR=172.30.143.165
MONITOR_D_SERVICE_PORT_MONITOR_D_CASSANDRA_TLS_INTERCOM=7001
MONITOR_D_PORT_9160_TCP=tcp://172.30.143.165:9160
HOSTNAME=monitor-d-new
MONITOR_D_PORT_9042_TCP_PROTO=tcp
KUBERNETES_PORT=tcp://172.30.0.1:443
KUBERNETES_PORT_443_TCP_PORT=443
KUBERNETES_SERVICE_PORT=443
MONITOR_D_PORT_7199_TCP_PORT=7199
MONITOR_D_PORT=tcp://172.30.143.165:8080
MONITOR_D_PORT_9160_TCP_PORT=9160
MONITOR_D_PORT_9160_TCP_PROTO=tcp
KUBERNETES_SERVICE_HOST=172.30.0.1
KUBERNETES_PORT_53_TCP=tcp://172.30.0.1:53
MONITOR_D_PORT_27017_TCP=tcp://172.30.143.165:27017
LC_ALL=en_US.UTF-8
MONITOR_D_SERVICE_HOST=172.30.143.165
KUBERNETES_PORT_53_UDP=udp://172.30.0.1:53
MONITOR_D_PORT_27017_TCP_PORT=27017
MONITOR_D_PORT_7001_TCP_PROTO=tcp
KUBERNETES_PORT_53_TCP_PORT=53
MONITOR_D_PORT_8080_TCP_PROTO=tcp
LS_COLORS=
KUBERNETES_SERVICE_PORT_DNS=53
MONITOR_D_PORT_7199_TCP_PROTO=tcp
MONITOR_D_PORT_7000_TCP_ADDR=172.30.143.165
KUBERNETES_PORT_53_TCP_ADDR=172.30.0.1
MONITOR_D_PORT_8181_TCP_PROTO=tcp
MONITOR_D_PORT_27017_TCP_ADDR=172.30.143.165
MONITOR_D_PORT_9042_TCP_PORT=9042
MONITOR_D_PORT_9160_TCP_ADDR=172.30.143.165
MONITOR_D_SERVICE_PORT_MONITOR_D_CASSANDRA_CQL_TRANSPORT=9042
KUBERNETES_PORT_53_UDP_ADDR=172.30.0.1
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/cassandra/bin
MONITOR_D_SERVICE_PORT_MONITOR_D_UI=8080
MONITOR_D_PORT_9042_TCP=tcp://172.30.143.165:9042
MONITOR_D_PORT_7001_TCP_PORT=7001
MONITOR_D_PORT_8080_TCP_PORT=8080
PWD=/
JAVA_HOME=/usr/lib/jvm/java-8-oracle
CASSANDRA_HOME=/usr/local/cassandra
LANG=en_US.UTF-8
MONITOR_D_SERVICE_PORT_MONITOR_D_BKEND=8181
MONITOR_D_PORT_7000_TCP_PROTO=tcp
KUBERNETES_PORT_53_UDP_PORT=53
MONITOR_D_SERVICE_PORT_MONITOR_D_CASSANDRA_THRIFT_CLIENT=9160
MONITOR_D_PORT_8181_TCP_PORT=8181
MONITOR_D_SERVICE_PORT=8080
SHLVL=1
HOME=/root
MONITOR_D_PORT_8181_TCP=tcp://172.30.143.165:8181
KUBERNETES_PORT_53_UDP_PROTO=udp
MONITOR_D_SERVICE_PORT_MONITOR_CASSANDRA_JMX=7199
KUBERNETES_PORT_443_TCP_PROTO=tcp
KUBERNETES_SERVICE_PORT_HTTPS=443
MONITOR_D_SERVICE_PORT_MONITOR_D_CASSANDRA_INTERCOM=7000
MONITOR_D_PORT_8080_TCP=tcp://172.30.143.165:8080
MONITOR_D_PORT_7001_TCP=tcp://172.30.143.165:7001
MONITOR_D_SERVICE_PORT_MONITOR_D_DB=27017
LESSOPEN=| /usr/bin/lesspipe %s
MONITOR_D_PORT_9042_TCP_ADDR=172.30.143.165
MONITOR_D_PORT_8181_TCP_ADDR=172.30.143.165
MONITOR_D_PORT_27017_TCP_PROTO=tcp
KUBERNETES_PORT_443_TCP_ADDR=172.30.0.1
KUBERNETES_PORT_53_TCP_PROTO=tcp
KUBERNETES_SERVICE_PORT_DNS_TCP=53
MONITOR_D_PORT_7000_TCP_PORT=7000
KUBERNETES_PORT_443_TCP=tcp://172.30.0.1:443
LESSCLOSE=/usr/bin/lesspipe %s %s
MONITOR_D_PORT_7199_TCP_ADDR=172.30.143.165
MONITOR_D_PORT_7000_TCP=tcp://172.30.143.165:7000
```

### Tip
  #### Use --add-host to append values to /etc/hosts
 * Used for setting the mapping between hosts names and ip address.
 * Format to pass will be like so $HOST $IP, $HOST2 $IP, ... For example:
 ```
docker run --add-host="hadoopmaster:192.168.33.40"  --add-host="hadoopdata1:192.168.33.41" --add-host="hadoopdata2:192.168.33.42"  -it -P  --hostname cassandra.hadoopdata.com bzcareer/docker-cassandra
 ```
## Running the image in docker standalone

* if using boot2docker make sure your VM has more than 2GB memory
for single standalone mode:
```
docker run -it -P  -h cassandra-1 bzcareer/docker-cassandra
```
or for clustermode:
```
docker run -e "CASSIE_SEEDS=hadoopmaster,hadoopdata1,hadoopdata2" -it -P  -h cassandra-1 bzcareer/docker-cassandra
```

## Running on kubernetes/openshift-origin

To speed things up a bit pull down the docker image from dockerhub:
```
docker pull bzcareer/docker-cassandra
```

```
[ cassanda-admin@localhost] $ oc new-project cloudcassandra
Now using project "cloudcassandra" on server "https://10.2.2.2:8443".
...

[ cassanda-admin@localhost] $

## Versions
```
Apache Cassandra v3.7 on Ubuntu with Java 8
```

![alt tag](https://raw.githubusercontent.com/BZCareer/hadoop-ansible/master/imgs/Cassandra-3-NodeCluster.png)
