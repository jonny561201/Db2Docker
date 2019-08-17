#!/bin/bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $CURRENT_DIR/variables

function createDb2Image {
    echo "----------Creating Db2 Image----------"
    docker build -t $CONTAINER_NAME $CURRENT_DIR/docker/db2Sql
}

function createFlywayImage {
    echo "----------Creating Flyway Image----------"
    docker build -t $FLYWAY_NAME $CURRENT_DIR/docker/flway
}

createDb2Image
createFlywayImage