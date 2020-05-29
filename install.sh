#!/bin/bash
scriptdir="$HOME/scripts/"

### Check for dir, if not found create it using the mkdir ##
[ ! -d "$scriptdir" ] && mkdir -p "$scriptdir"

cd ~/scripts

#Check if Git installed
git --version 2>&1 >/dev/null 
GIT_IS_AVAILABLE=$?
if [ $GIT_IS_AVAILABLE -eq 0 ]; then 
  git clone https://github.com/karolgit/getmac.git
else 
  echo "git is not installed. Please install git (e.g.) yum install git "
fi


cd ~/scripts/getmac

#Check if docker installed
docker --version 2>&1 >/dev/null
DOCKER_IS_AVAILABLE=$?
if [ $DOCKER_IS_AVAILABLE -eq 0 ]; then
  docker build -t getmacsh .
else
  echo "docker is not installed. Please install docker. Refer https://docs.docker.com/get-docker/ (e.g.) yum install docker-ce  "
fi

#set path to run from anywhere in the box as a tool 
export PATH=$HOME/scripts/getmac/bin:$PATH:

echo "Sample Run ...."
getmac 44:38:39:ff:ef:57
