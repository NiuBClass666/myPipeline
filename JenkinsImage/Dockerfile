FROM jenkins/jenkins:latest

USER root

#Install docker
RUN apt-get -y update -qq \
    && apt-get install -qqy apt-transport-https ca-certificates curl gnupg2 software-properties-common 
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
RUN apt-get update  -qq \
    && apt-get install docker-ce=17.12.1~ce-0~debian -y

#Install terraform
RUN apt-get install unzip
RUN wget https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_linux_amd64.zip
RUN unzip terraform_0.11.13_linux_amd64.zip
RUN mv terraform /usr/local/bin/
RUN terraform --version 

#Give Jenkins admin authority 
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

RUN usermod -a -G staff jenkins

#Pre-configure jenkins
USER jenkins

#Skip initialsetupWizard
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

#Add an admin by using groovy script
COPY security.groovy /usr/share/jenkins/ref/init.groovy.d/security.groovy

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt

#tfs is terraform files we need to spawn up new web servers
COPY tfs /usr/share/terraform

#install plugins in plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt


