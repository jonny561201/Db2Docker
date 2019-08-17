#!/bin/bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $CURRENT_DIR/variables

function createImage {
    echo "----------Creating Image----------"
    docker build -t $CONTAINER_NAME $CURRENT_DIR/docker/db2Sql
}

createImage