#!/bin/bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${CURRENT_DIR}/variables

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

function dockerFlywayMigration {
    DOCKER_VOLUME=${SCRIPT_DIR}/docker/flyway/db/migration
    WINDOWS_VOLUME=$(echo ${DOCKER_VOLUME} | sed -e 's/^\///' -e 's/\//\\/g' -e 's/^./\0:/')
    echo "----------Flyway Volume set to: $DOCKER_VOLUME"
    echo "test windows volume: ${WINDOWS_VOLUME}"
    echo "----------Executing Flyway Migrations----------"
    docker run --net=host --rm -v /${WINDOWS_VOLUME}:/flyway/sql ${FLYWAY_NAME} -url="jdbc:db2://localhost:$SQL_PORT/$SQL_NAME" -user=${INSTANCE_NAME} -password=${SQL_PASSWORD} migrate
}

function startContainer {
    echo "----------Starting Up Docker Container----------"
    docker run --privileged=true --name=${SQL_DOCKER_NAME} -d=true -p "$SQL_PORT:$SQL_PORT" \
    -e 'LICENSE=accept' \
    -e DB2INSTANCE=${INSTANCE_NAME} \
    -e DB2INST1_PASSWORD=${SQL_PASSWORD} \
    -e DBNAME=${SQL_NAME} \
    -e 'ARCHIVE_LOGS=false' \
    -e 'AUTOCONFIG=false' \
    ${CONTAINER_NAME}
}

startContainer
waitForHealthyContainer
dockerFlywayMigration