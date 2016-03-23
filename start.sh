#!/bin/bash

# Create database directories
mkdir /data/db/db-001
mkdir /data/db/db-002
mkdir /data/db/db-003

# Run mongo replica sets using config files
mongod --config /conf/mongod_1.conf
mongod --config /conf/mongod_2.conf
mongod --config /conf/mongod_3.conf

# mongo  --eval 'var config = { _id: "rs0", members: [ { _id: 0, host: "localhost:27017" }, { _id: 1, host: "localhost:27018" }, { _id: 3, host: "localhost:27019" } ] }; rs.initiate( config ); while (rs.status().startupStatus || (rs.status().hasOwnProperty("myState") && rs.status().myState != 1)) { printjson( rs.status() ); sleep(1000); }; printjson( rs.status() );'
sleep(5000)

mongo --eval 'rs.initiate();rs.add("localhost:27018");rs.add("localhost:27019"); printjson(rs.status())'

# Run mongo as the running process, this is required to keep the docker process running
mongo


