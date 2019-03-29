#!/bin/bash


apt-get update
wget --no-check-certificate -qO - https://pkg.jenkins.io/debian/jenkins-ci.org.key | apt-key add - 
echo deb https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list 
apt-get install -y python-software-properties debconf-utils
add-apt-repository ppa:webupd8team/java --yes
sudo apt-get update
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
echo "CONFIG DONE" 
apt-get install oracle-java8-installer -y

apt-get update
apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable #edge" 
apt-get update 
apt-get install -y docker-ce

apt-get update

java -Djenkins.install.runSetupWizard=false -jar /tmp/jenkins.war

java -jar /tmp/jenkins-cli.jar -s http://localhost:8080/ create-job autoBuildFlask < /tmp/template.xml

sudo service jenkins restart

gpasswd -a jenkins docker
service docker restart




