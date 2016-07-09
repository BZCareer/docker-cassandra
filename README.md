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
 "hadoopmaster,hadoopdata1,hadoopdata2"
 * See below section titled `Running the image`
 * Warning: Its recommended that you don't set this variable unless you already have a cluster defined.
## Running the image

* if using boot2docker make sure your VM has more than 2GB memory
for single standalone mode:
```
docker run -it -P  -h cassandra-1 bzcareer/docker-cassandra
```
or for clustermode:
```
docker run -e "CASSIE_SEEDS=hadoopmaster,hadoopdata1,hadoopdata2" -it -P  -h cassandra-1 bzcareer/docker-cassandra
```
## Versions
```
Apache Cassandra v3.7 on Ubuntu with Java 8
```

![alt tag](https://raw.githubusercontent.com/BZCareer/hadoop-ansible/master/imgs/Cassandra-3-NodeCluster.png)
