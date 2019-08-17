#!/bin/bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $CURRENT_DIR/variables

function waitForHealthyContainer {
    if [[ "$(docker inspect -f='{{.State.Status}}' ${SQL_DOCKER_NAME})" = "exited" ]]
    then
        echo -e "${RED}ERROR: Docker container exited prematurely!!!"
        exit 1
    fi
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
    -e DB2INSTANCE=${INSTANCE_NAME} \
    -e DB2INST1_PASSWORD=$SQL_PASSWORD \
    -e DBNAME=${SQL_NAME} \
    -e 'ARCHIVE_LOGS=false' \
    -e 'AUTOCONFIG=false' \
    ${CONTAINER_NAME}
}

startContainer
waitForHealthyContainer
