FROM jenkins/jenkins:latest

USER root

RUN apt-get -y update -qq \
    && apt-get install -qqy apt-transport-https ca-certificates curl gnupg2 software-properties-common 
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
RUN apt-get update  -qq \
    && apt-get install docker-ce=17.12.1~ce-0~debian -y

RUN apt-get install unzip
RUN wget https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_linux_amd64.zip
RUN unzip terraform_0.11.13_linux_amd64.zip
RUN mv terraform /usr/local/bin/
RUN terraform --version 

RUN apt-get update
RUN apt-get -y install vim

RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

RUN usermod -a -G staff jenkins

USER jenkins

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

COPY security.groovy /usr/share/jenkins/ref/init.groovy.d/security.groovy
 
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt

COPY config.xml /usr/share/jenkins/ref/config.xml

COPY jenkins-cli.jar /usr/share/jenkins/

COPY template.xml /usr/share/jenkins/

COPY tfs /usr/share/terraform

RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt


