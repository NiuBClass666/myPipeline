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

docker run -d --name jenkins -v /var/run/docker.sock:/var/run/docker.sock -p 8080:8080 -p 50000:50000 liyuansdockerhub/jenkins 


sleep 2m

chmod 777 /var/run/docker.sock 

java -jar /tmp/jenkins-cli.jar -s http://localhost:8080/ -auth admin:admin create-job autoBuild < /tmp/template.xml

java -jar /tmp/jenkins-cli.jar -s http://localhost:8080/ -auth admin:admin create-job BlueGreenDeploy < /tmp/template2.xml


sleep 10

java -jar /tmp/jenkins-cli.jar -s http://localhost:8080 -auth admin:admin create-credentials-by-xml system::system::jenkins "(global)"  <  /tmp/docker-hub-credentials.xml
java -jar /tmp/jenkins-cli.jar -s http://localhost:8080 -auth admin:admin create-credentials-by-xml system::system::jenkins "(global)"  <  /tmp/Github-Repo.xml

sleep 1m

curl http://0.0.0.0:8080/git/notifyCommit?url=https://github.com/LiyuanWang123/InsightDevopsProject


