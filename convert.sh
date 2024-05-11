#!/bin/sh
CONTAINER_NAME=local-dotprint
docker run --rm -v "$(pwd)":/work ${CONTAINER_NAME} $*
