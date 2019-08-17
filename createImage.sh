#!/bin/bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CONTAINER_NAME=db2-server:latest

function createImage {
    echo "----------Creating Image----------"
    docker build -t $CONTAINER_NAME $CURRENT_DIR/docker/db2Sql
}

createImage