#!/bin/bash -x
echo
echo "Create new mynginx Docker image..."
echo
docker build --rm --no-cache -t mynginx . --file=Dockerfile

echo
echo "List docker images..."
echo
docker images