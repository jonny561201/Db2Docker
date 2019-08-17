#!/bin/bash

SQL_DOCKER_NAME=Db2Test
CONTAINER_NAME=db2-server:latest
INSTANCE_NAME=db2inst1
SQL_PASSWORD=password
SQL_NAME=FAKEDATABASE
SQL_PORT=50000

function startContainer {
    echo "----------Starting Up Docker Container----------"
    docker run --privileged=true --name=${SQL_DOCKER_NAME} -d=true -p "$SQL_PORT:$SQL_PORT" \
    -e LICENSE=accept \
    -e DB2INSTANCE=${INSTANCE_NAME} \
    -e DB2INST1_PASSWORD=${SQL_PASSWORD} \
    -e DBNAME=${SQL_NAME} \
    -e ARCHIVE_LOGS=false \
    -e AUTOCONFIG=false \
    ${CONTAINER_NAME}
}

startContainer

