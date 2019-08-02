#!/bin/bash

set -e

docker ps -f "status=exited" -f "name=k8s*" | sed -n '2,$p' | while read c1 c2; do docker rm $c1; done
