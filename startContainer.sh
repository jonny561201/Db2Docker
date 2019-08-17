#!/bin/bash

SQL_DOCKER_NAME=Db2Test
CONTAINER_NAME=db2-server
INSTANCE_NAME=db2inst1
SQL_PASSWORD=password
SQL_NAME=FAKEDATABASE
SQL_PORT=50000
GREEN='\033[0;32m'
WHITE='\033[0m'

function waitForHealthyContainer {
    until [[ "$(docker inspect -f='{{.State.Health.Status}}' ${SQL_DOCKER_NAME})" = "healthy" ]]; do
        echo "...waiting for container to become healthy..."
        sleep 1
    done
    echo -e "${GREEN}Container is healthy!${WHITE}"
}

function startContainer {
    echo "----------Starting Up Docker Container----------"
    docker run --privileged=true --name=${SQL_DOCKER_NAME} -d=true -p "$SQL_PORT:$SQL_PORT" \
    -e 'LICENSE=accept' \
    -e 'DB2INSTANCE=db2inst1' \
    -e 'DB2INST1_PASSWORD=password' \
    -e 'DBNAME=FAKEDB' \
    -e 'ARCHIVE_LOGS=false' \
    -e 'AUTOCONFIG=false' \
    ${CONTAINER_NAME}
}

startContainer
waitForHealthyContainer
