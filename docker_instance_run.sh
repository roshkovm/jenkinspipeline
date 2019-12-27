#!/bin/bash -x

DOCKER_INSTANCE_NAME=nginx_web

docker_running_check() {
  echo "Check if NEW Docker Instance was running..."
  RUNNING_STATUS=$(docker inspect -f '{{.State.Running}}' $DOCKER_INSTANCE_NAME)
  if [ "$RUNNING_STATUS" == "true" ]; then
	 echo "OK! NEW Docker instance was running!"
	 #exit 0
  else
	 echo "ERROR! NEW Docker instance was NOT running!"
	 exit 1
  fi
}

echo
echo "Check status Nginx Docker instance..."
echo
RUNNING_STATUS=$(docker inspect -f '{{.State.Running}}' $DOCKER_INSTANCE_NAME)
echo "Running status: $RUNNING_STATUS"

if  [ "$RUNNING_STATUS" == "true" ]
then
   echo "Docker Instance is running. Try to stop it..."
   DOCKER_ID=$(docker ps -aqf "name=$DOCKER_INSTANCE_NAME")
   echo "Docker ID: $DOCKER_ID"
   docker stop $DOCKER_ID
   docker rm $DOCKER_ID
   
   echo
   echo "Check if OLD Docker Instance was removed..."
   DOCKER_ID=$(docker ps -aqf "name=$DOCKER_INSTANCE_NAME")
   if [[ -z $DOCKER_ID ]]; then
	  echo
	  echo "OK! OLD Docker instance was removed. Try to start NEW Docker instance..."
	  docker run --name nginx_web -d -p 80:80 -it mynginx:latest
	  
	  docker_running_check
	  
	  
   else
	  echo "ERROR! OLD Docker instance was NOT removed!"
	  exit 1
   fi
   
else
   
   echo "OLD Docker Instance is not running..."  
   echo "Check Docker instance ID..."
   DOCKER_ID=$(docker ps -aqf "name=$DOCKER_INSTANCE_NAME")
   echo
   
   if [[ -z $DOCKER_ID ]]; then
	  echo
	  echo "OK! OLD Docker instance was stopped and removed. Try to start it..."
	  docker run --name nginx_web -d -p 80:80 -it mynginx:latest
	  
	  docker_running_check
	  
	  
   else
	  echo "WARNING! OLD Docker instance was stopped, but not removed! Trying to remove it..."
	  docker rm $DOCKER_ID
	  echo 
	  echo "Check if OLD Docker Instance was removed..."
	  DOCKER_ID=$(docker ps -aqf "name=$DOCKER_INSTANCE_NAME")
	  
	  if [[ -z $DOCKER_ID ]]; then
		echo "OK! OLD Docker instance was removed. Try to start it..."
		docker run --name nginx_web -d -p 80:80 -it mynginx:latest
		echo
	  
	  docker_running_check
		
	  else
		echo "ERROR! OLD Docker instance was NOT removed!"
		exit 1
	  fi
	  
	  

   fi
   
   
fi