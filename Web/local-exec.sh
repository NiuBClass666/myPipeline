#!/bin/bash

#Install docker ce
apt-get update
apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable #edge" 
apt-get update 
apt-get install -y docker-ce

#Run two containers, one with the application, the other one with Tool watchTower
docker run -d   --name web --rm -p 5000:5000 liyuansdockerhub/insight_project

sleep 30s

docker run -d   --name watchtower   -v /var/run/docker.sock:/var/run/docker.sock  v2tec/watchtower --cleanup -i 30
