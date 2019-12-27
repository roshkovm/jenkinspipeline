#!/bin/bash

echo
echo "List docker images..."
echo
docker images
echo
echo "Removing untagged docker images..."
echo
list_none_images=$(docker images | grep "^<none>" | awk '{print $3}')
echo "List NONE images for remove:"
echo $list_none_images

for image in $list_none_images
do
  echo "Docker Image for remove: $image"
  docker rmi $image
done
