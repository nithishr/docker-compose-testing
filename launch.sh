#!/usr/bin/env sh

######################################################################
# @author      : chedim (chedim@couchbaser)
# @file        : docker
# @created     : Friday Nov 19, 2021 03:12:55 EST
#
# @description : Runs notebooks in Docker
######################################################################


docker build . -t jupyter-couchbase
docker run  -v $(pwd):/home/jovyan/work --net=host jupyter-couchbase
