#!/bin/bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $CURRENT_DIR/variables

function killDb2Image {
	echo "------------Killing Db2 Image---------------"
	docker kill $SQL_DOCKER_NAME
}

function removeDb2Image {
	echo "------------Removing Db2 Image---------------"
	docker rm $SQL_DOCKER_NAME
}

killDb2Image
removeDb2Image